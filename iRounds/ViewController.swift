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
  
 let loginActivityIndicator = UIActivityIndicatorView(style: .gray)
  var loggedInUser = ""
  var currentSelectedLocation = ""
    var ICenterForm = createICenterRoundForm.init()
    var fitnessCenterForm = createFitnessCenterRoundForm.init()
   
  @IBOutlet weak var submitButtonOutlet: UIBarButtonItem!
  
    var ref: DocumentReference? = nil
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentController: UISegmentedControl!

  @IBOutlet var loginButtonOutlet: UIButton!
  
  
  @IBOutlet weak var leftButtonbarloginButtonOutlet: UIBarButtonItem!
  
  let BYUI_BLUE = UIColor.init(red: 0.20, green: 0.45, blue: 0.75, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      self.submitButtonOutlet.isEnabled = false
      
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
        currentSelectedLocation = fitnessCenterForm.locationName
        roundForm = fitnessCenterForm.listOfRoundLocations
        
        
        
      
      let gradient = CAGradientLayer()

      gradient.frame = view.bounds

      gradient.colors = [UIColor(red:0.53, green:0.81, blue:0.92, alpha:1.0).cgColor, BYUI_BLUE.cgColor]

      self.view.layer.insertSublayer(gradient, at: 0)
      
      self.view.backgroundColor = UIColor(red:0.53, green:0.81, blue:0.92, alpha:1.0)
      
//      tableView.layer.backgroundColor = UIColor.clear.cgColor
      
      
      
    }
  
  
  
  
  @IBAction func loginButtonPressed(_ sender: UIButton)
  {
    print("login button pressed")
    
    
    let alert = UIAlertController(title: "Login", message: "Enter your Hart Scheduling email and password", preferredStyle: .alert)
    alert.addTextField { ( usernameTextField ) in
      usernameTextField.placeholder = "Enter Email"
       usernameTextField.keyboardType = UIKeyboardType.emailAddress
    }
    alert.addTextField { (UITextField) in
      UITextField.placeholder = "Enter Password"
      UITextField.isSecureTextEntry = true
      UITextField.keyboardType = UIKeyboardType.default
    }
    
    alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { (UIAlertAction) in
      
      let usernameField = alert.textFields![0] as UITextField
      let passwordFeild = alert.textFields![1] as UITextField
      
      self.displayLoginActivityIndcator()
      
      //signing in
      Auth.auth().signIn(withEmail: usernameField.text!, password: passwordFeild.text!) { (result, error) in
        if let error = error
        {
          print("there was a problem logging the user in...\(error.localizedDescription)")
          self.displayCustomAlert(title: "Login Error", message: "\(error.localizedDescription)")
          self.hideLoginActivityIndicator()
        }
        else
        {
         
          self.getEmployeeDataFromFirebase(email: result!.user.email!)
          print("Logged in user \(String(describing: result!.user.email!))")
         
          
          
        }
      }
    }))
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  
  
  @IBAction func clearFormAction(_ sender: UIButton)
  {
    let alert = UIAlertController(title: "Are you sure?", message: "Do you really want to reset the form?", preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (UIAlertAction) in
        self.resetForm()
    }))
    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
    
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
        
        self.sendFormToFirebase(roundForm: roundForm)
        
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
              currentSelectedLocation = fitnessCenterForm.locationName
                roundForm = fitnessCenterForm.listOfRoundLocations
                tableView.reloadData()
            case 1:
              currentSelectedLocation = ICenterForm.locationName
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


extension ViewController
{
  func displayLoginActivityIndcator()
  {
    
    let activityIndicator: UIBarButtonItem = UIBarButtonItem(customView: self.loginActivityIndicator)
    self.navigationItem.leftBarButtonItem = activityIndicator
    self.loginActivityIndicator.startAnimating()
    
  }
  
  func hideLoginActivityIndicator()
  {
    self.loginActivityIndicator.stopAnimating()
    let loginButton: UIBarButtonItem = UIBarButtonItem(customView: self.loginButtonOutlet)
    self.navigationItem.leftBarButtonItem = loginButton
  }
  
  
  func resetForm()
  {
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
  }
  
  func displayCustomAlert(title: String, message: String)
  {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
    
  }
  
  //searches for the employee who logged in vai their email
  func getEmployeeDataFromFirebase(email: String)
  {
    var employeeName = ""
    
    print("querying for email \(email)")
    // Create a reference to the cities collection
    let employeeRef = db.collection("employees")
    
    // Create a query against the collection.
    employeeRef.whereField("email", isEqualTo: email)
      .getDocuments() { (querySnapshot, err) in
        if let err = err {
          print("Error getting documents: \(err)")
        } else {
          for document in querySnapshot!.documents {
            print("\(document.documentID) => \(document.data())")
            employeeName = "\(document.data()["firstname"]!) \(document.data()["lastname"]!)"
            self.loggedInUser = employeeName
            
            self.submitButtonOutlet.isEnabled = true
            self.loginButtonOutlet.setTitle(employeeName, for: .normal)
            self.hideLoginActivityIndicator()
            self.displayCustomAlert(title: "Login Success", message: "You are logged in as \(employeeName)")
          }
        }
      
        
    }
 
   
   
  }
    
  
}

extension ViewController
{
  func getTime() -> String
  {
    let dateFormatter : DateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone.autoupdatingCurrent
    dateFormatter.dateFormat = "hh:mm a"
    
    let date = Date()
    let TimeString = dateFormatter.string(from: date)
    
    print(TimeString)
    
    return TimeString
  }
  
  func getDate() -> String
  {
    let dateFormatter : DateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone.autoupdatingCurrent
    dateFormatter.dateFormat = "MM/dd/yyyy"
    
    let date = Date()
    let dateString = dateFormatter.string(from: date)
    
    print(dateString)
    
    return dateString
  }
  
  func sendFormToFirebase(roundForm: [RoundLocation])
  {
    let uploadTime = getTime()
    let updateDate = getDate()
    
    var roundFormDictionary: [String: [String]] = [:]
    //convert the round form data into a dictionary. Firebase will only accept the data like this
    for roundItem in roundForm
    {
      roundFormDictionary.updateValue([String(roundItem.numberOfParticipants), roundItem.activity], forKey: roundItem.locationName)
    }
    
    print(roundFormDictionary)
  
//creates a new document with a generated ID
    db.collection("roundForms").addDocument(data: [

      //data to upload...
      "employee": loggedInUser,
      "location": currentSelectedLocation,
      "timeOfUpload": uploadTime,
      "DateOfUpload": updateDate,
      "roundFormData": roundFormDictionary



    ])
    { (error) in
      if error != nil
      {
        //display error...
        print("upload error \(String(describing: error?.localizedDescription))")
        self.displayCustomAlert(title: "Upload Error", message: "\(String(describing: error?.localizedDescription))")
      }
      else
      {
        //success!
        let resetAlert = UIAlertController(title: "Round submitted successfully!", message: "", preferredStyle: .alert)
        resetAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(resetAlert, animated: true, completion: nil)
        self.resetForm()
      }
    }
  }
    
  
}
