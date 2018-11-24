//
//  ViewController.swift
//  iRounds
//
//  Created by Sam Trent on 11/14/18.
//  Copyright © 2018 Sam Trent. All rights reserved.
//

import UIKit
import Firebase

var roundForm: [RoundLocation] = []

class ViewController: UIViewController {

    var ICenterForm = createICenterRoundForm.init()
    var fitnessCenterForm = createFitnessCenterRoundForm.init()
   
    
    var ref: DocumentReference? = nil
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    let BYUI_BLUE = UIColor.init(red: 0.20, green: 0.45, blue: 0.75, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      self.tableView.delegate = self
      self.tableView.dataSource = self
      self.navigationController?.navigationBar.prefersLargeTitles = true
      self.navigationItem.largeTitleDisplayMode = .always
      navigationController?.navigationBar.barStyle = .default
      
     self.view.backgroundColor = UIColor.white
      
    
      //make tableview clear
      tableView.backgroundView = nil
      tableView.backgroundColor = UIColor.clear
    
        
        //init the default form
        roundForm = fitnessCenterForm.listOfRoundLocations
        
        
        //signing in
        Auth.auth().signIn(withEmail: "sd.trent@yahoo.com", password: "") { (result, error) in
            if let error = error
            {
                print("there was a problem logging the user in...\(error.localizedDescription)")
            }
            else
            {
                print("Logged in user \(String(describing: result?.user.email!))")
            }
            
            
        }
      
      let gradient = CAGradientLayer()

      gradient.frame = view.bounds

      gradient.colors = [UIColor(red:0.53, green:0.81, blue:0.92, alpha:1.0).cgColor, BYUI_BLUE.cgColor]

      self.view.layer.insertSublayer(gradient, at: 0)
      
      self.view.backgroundColor = UIColor(red:0.53, green:0.81, blue:0.92, alpha:1.0)
      
//      tableView.layer.backgroundColor = UIColor.clear.cgColor
      
        //getting employee data
//        db.collection("employees").getDocuments() { (querySnapshot, error) in
//            if let error = error
//            {
//                print("there was an error getting the docs...\(error.localizedDescription)")
//            }
//            else
//            {
//                for document in querySnapshot!.documents
//                {
////                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
      
        
    }
   
   override func viewWillAppear(_ animated: Bool) {
      tableView.reloadData()
      print("hi")
   }

    @IBAction func submitButton(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Ready to submit Rounds?", message: "Are you sure you want to submit this Round Form?", preferredStyle: .alert)
      
      alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
         action in
         //set the round form back to 0's
         switch self.segmentController.selectedSegmentIndex
         {
         case 0: //fitness center
            roundForm = self.fitnessCenterForm.listOfRoundLocations
            self.tableView.reloadData()
         case 1:
            roundForm = self.ICenterForm.listOfRoundLocations
            self.tableView.reloadData()
         default:
            break
         }
         let resetAlert = UIAlertController(title: "Round submitted successfully!", message: "", preferredStyle: .alert)
         resetAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
         self.present(resetAlert, animated: true, completion: nil)
      }))
      
      alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
      
      self.present(alert, animated: true, completion: nil)
    }
    
    //Gets called when a new segment was selected
    @IBAction func segmentControllerWasChanged(_ sender: UISegmentedControl)
    {
        switch segmentController.selectedSegmentIndex
        {
            case 0: //fitness center
                roundForm = fitnessCenterForm.listOfRoundLocations
                tableView.reloadData()
            case 1:
                roundForm = ICenterForm.listOfRoundLocations
                tableView.reloadData()
        default:
            break
        }
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(roundForm)
        return roundForm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! roundItemTableViewCell
        
        cell.locationLabel.text = roundForm[indexPath.row].locationName
        cell.numberOfParticepents.text = String(describing: roundForm[indexPath.row].numberOfParticipants)
      cell.activityLabel.text = roundForm[indexPath.row].activity
      
       cell.layer.backgroundColor = UIColor.clear.cgColor
      
        
        
        return cell
    }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
   {
      let indexPath = tableView.indexPathForSelectedRow
      
      let selectedCell = tableView.cellForRow(at: indexPath!) as! roundItemTableViewCell
      
      print(roundForm[(indexPath?.row)!])
      
      print("Selected index path \(String(describing: selectedCell.locationLabel.text!))")
      
      let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
      let destination = storyboard.instantiateViewController(withIdentifier: "roundDataViewContoller") as! RoundDataViewController
      
      //pass in the the selected index to the next view
      destination.selectedIndexPathForRoundData = indexPath?.row

      navigationController?.present(destination, animated: true, completion: nil)
      
   }
}

