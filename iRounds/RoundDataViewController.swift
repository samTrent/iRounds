//
//  RoundDataViewController.swift
//  iRounds
//
//  Created by Sam Trent on 11/23/18.
//  Copyright © 2018 Sam Trent. All rights reserved.
//

import UIKit

var activityList: [String] = ["Swimming",
                             "Pickel Ball",
                             "Racquetball",
                             "Basketball",
                             "Wallyball",
                             "Volleyball",
                             "Other",
                             "Yoga",
                             "Water Aerobics",
                             "Water Pollo",
                             "Dance",
                             "Tennis",
                             "Futsol",
                             "Soccer",
                             "Spike Ball",
                             "Wrestling",
                             "Judo",
                             "Ju Jitsu",
                             "Taekwondo",
                             "RAD"]


class RoundDataViewController: UIViewController {

//   var roundLocationData: RoundLocation? = nil
   var selectedIndexPathForRoundData: Int? = nil
   
   @IBOutlet weak var locationLabel: UILabel!
   @IBOutlet weak var numberOfParticipantsLabel: UILabel!
   
   
   @IBOutlet weak var activityTextField: UITextField!
   
   
   override func viewDidLoad() {
        super.viewDidLoad()

      activityList.sort() //make it alphabetical
      initPicker()
      
      locationLabel.text = roundForm[selectedIndexPathForRoundData!].locationName
      
      numberOfParticipantsLabel.text = String(describing:  roundForm[selectedIndexPathForRoundData!].numberOfParticipants )
      
//      view.backgroundColor = UIColor.clear
//      view.isOpaque = false
//
      let gradient = CAGradientLayer()

      gradient.frame = view.bounds
      let BYUI_BLUE = UIColor.init(red: 0.20, green: 0.45, blue: 0.75, alpha: 1.0)
      gradient.colors = [UIColor(red:0.53, green:0.81, blue:0.92, alpha:1.0).cgColor, BYUI_BLUE.cgColor]

      self.view.layer.insertSublayer(gradient, at: 0)

    }
   
    
   @IBAction func doneButtonPressed(_ sender: UIBarButtonItem)
   {
      //dismiss the presented viewcontroller
       self.presentingViewController?.dismiss(animated: true, completion:nil)
   }
   
   @IBAction func addNumberOfParticipants(_ sender: UIButton)
   {
      roundForm[selectedIndexPathForRoundData!].numberOfParticipants += 1
      numberOfParticipantsLabel.text! = String(describing: roundForm[selectedIndexPathForRoundData!].numberOfParticipants )
   }
   
   @IBAction func removeNumberOfParticipants(_ sender: UIButton)
   {
      if( roundForm[selectedIndexPathForRoundData!].numberOfParticipants > 0)
      {
         roundForm[selectedIndexPathForRoundData!].numberOfParticipants -= 1
         numberOfParticipantsLabel.text! = String(describing: roundForm[selectedIndexPathForRoundData!].numberOfParticipants )
      }
   }
   
   
   
  
}

//picker code
extension RoundDataViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
   func initPicker()
   {
      //init picker
      let activityPicker = UIPickerView()
      activityTextField.inputView = activityPicker
      activityPicker.showsSelectionIndicator = true
      activityPicker.delegate = self
      activityPicker.dataSource = self
      
      //init picker tool bar
      let pickerToolbar = UIToolbar()
      pickerToolbar.barStyle = .default
      pickerToolbar.isTranslucent = true
      pickerToolbar.sizeToFit()
      
      let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
      let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(RoundDataViewController.donePicker))
      doneButton.tintColor = UIColor.blue
      
      pickerToolbar.setItems([spaceButton, spaceButton, doneButton], animated: true)
      pickerToolbar.isUserInteractionEnabled = true
      
      activityTextField.inputAccessoryView = pickerToolbar
      
      activityTextField.text = roundForm[selectedIndexPathForRoundData!].activity
      
   }
   
   @objc func donePicker()
   {
      activityTextField.resignFirstResponder()
   }
   
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return activityList.count
   }
   
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//      activityTextField.text = activityList[row]
//      roundForm[selectedIndexPathForRoundData!].activity = activityList[row]
      return activityList[row]
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      roundForm[selectedIndexPathForRoundData!].activity = activityList[row]
      activityTextField.text = activityList[row]
   }
}
