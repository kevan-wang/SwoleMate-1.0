//
//  NewPlan1VC.swift
//  SwoleMate 1.0
//
//  Created by Kevan Wang on 8/31/18.
//  Copyright © 2018 Kevan Wang. All rights reserved.
//

import UIKit

class NewPlan1VC: UIViewController  {
    
    // NOTE:  The NewPlanVCs do NOT use delegates to pass information between each other, will be using the DBManager singleton newPlanDict and newPlanTime variables instead.
    
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var feedbackText: UILabel!
    
    var dayButtons:[UIButton] = []
    
    @IBAction func dayButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let numSelected = countDaysSelected()
        feedbackText.text = fitnessPlanInstructions[numSelected]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        dayButtons = [ sundayButton, mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton ]
        timePicker.datePickerMode = UIDatePickerMode.time
        feedbackText.text = ""
        DBManager.shared.newPlanDict = [
            "name" : "",    //  Fitness Plan name
            "expLevel" : "",    //  User's experience level
            "goal" : "",    //  User's goal
            "routineType" : "",     //  Split or Full Body
            "mainSetType" : "", // Standard, Pyramid, or Reverse Pyramid
            "mainRegimenFormat" : "",   // 5x5, 3x8, 14/12/10/8/6, etc
            "auxSetType" : "", // Standard, Pyramid, or Reverse Pyramid
            "auxRegimenFormat" : ""   // 5x5, 3x8, 14/12/10/8/6, etc
        ]
        DBManager.shared.newPlanWeek = []
        DBManager.shared.newPlanTime = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func countDaysSelected() -> Int {
        var numSelected = 0
        for button in dayButtons {
            if button.isSelected {
                numSelected += 1
            }
        }
        return numSelected
    }
    
    func checkValidInputs() -> Bool {
        let nameCheck = nameField.text != ""
        let daysCheck = countDaysSelected() > 0
        return nameCheck && daysCheck
    }
    
    
    //  BUTTON FUNCTIONS
    
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        DBManager.shared.newPlanDict = [:]
        DBManager.shared.newPlanWeek = []
        DBManager.shared.newPlanTime = nil
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonPress(_ sender: UIButton) {
        if checkValidInputs() {
            DBManager.shared.newPlanDict["name"] = nameField.text
            var dayIndex = 0
            for button in dayButtons {
                if button.isSelected {
                    DBManager.shared.newPlanWeek.append(dayIndex)
                }
                dayIndex += 1
            }
            DBManager.shared.newPlanTime = timePicker.date
            performSegue(withIdentifier: "NewPlanSegue2", sender: sender)
        }
        else {
            let title = "Oops!"
            var message = ""
            if nameField.text == "" {
                message += "\nPlease enter a plan name!"
            }
            if countDaysSelected() == 0 {
                if message.count > 0 {
                    message += "\n"
                }
                message += "\nPlease select at least one workout day!"
            }
            createAlert(alertTitle: title, message: message)
        }
    }
    
    
    //  INFO BUTTON FUNCTIONS

    @IBAction func planNameInfo(_ sender: UIButton) {
        let title = "Plan Name"
        let message = "\nGive your workout plan a unique name!"
        createAlert(alertTitle: title, message: message)
    }
    
    @IBAction func schedInfo(_ sender: UIButton) {
        let title = "Schedule"
        let message = "\nSelect the days you plan to work out on, and the general time of day that gives you about an hour for your gym sesh.  You can customize your time more fully later.\n\nYour Swolemate recommends you select approximately THREE workout days."
        createAlert(alertTitle: title, message: message)
    }
    
    func createAlert(alertTitle: String, message: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Gotcha, bro!", style: .default, handler: nil)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
}

let fitnessPlanInstructions = [
    0: "Please select at least one day to work out!  Your Swolemate recommends THREE!",
    1: "If you have a busy schedule, one day a week is good for basic physical maintenance.  However, try to add more to your plan later on!",
    2:  "Two workout days a week!  Modest and gradual gains.  Slow and steady wins the race!",
    3:  "Three workout days a week!  A balanced pace that gives your body a good amount of time to recover between workouts!",
    4:  "Hittin' it hard at four days a week!  Beginning to push for those serious gainz!",
    5:  "Swole god!  Hope you're able to eat and sleep right, because your scheduled recovery time is beginning to get limited.  Swolemate will recommend a split routine to keep the same muscle groups from being overworked.",
    6:  "Whoa!  Really hooked on gym, eh?  Your Swolemate is beginning to get concerned!  Be sure to leave enough time to recover between workouts, and reserve at least one of these days for light cardio only!",
    7:  "Whoa!  Really hooked on gym, eh?  Your Swolemate is beginning to get concerned!  Be sure to leave enough time to recover between workouts, and reserve a few of these days for light cardio only!"
]





