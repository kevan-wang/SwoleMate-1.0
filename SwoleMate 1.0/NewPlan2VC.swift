//
//  NewPlan2VC.swift
//  SwoleMate 1.0
//
//  Created by Kevan Wang on 9/5/18.
//  Copyright © 2018 Kevan Wang. All rights reserved.
//

import UIKit

class NewPlan2VC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var expPicker: UIPickerView!
    @IBOutlet weak var expInstructions: UILabel!
    @IBOutlet weak var goalPicker: UIPickerView!
    @IBOutlet weak var goalInstructions: UILabel!
    
    var planName = ""
    var weekSchedule:[Int] = []
    var timeStart:Date = Date()
    
    let expLevels = [ "Beginner", "Intermediate", "Advanced", "Elite" ]
    let goals = [ "Strength Gains", "Muscle Size", "Muscle Endurance", "General Fitness", "Cardiac Health", "Weight Loss" ]


    override func viewDidLoad() {
        super.viewDidLoad()
        expPicker.tag = 0
        goalPicker.tag = 1
        expPicker.dataSource = self
        expPicker.delegate = self
        goalPicker.dataSource = self
        goalPicker.delegate = self
        expInstructions.text = ""
        goalInstructions.text = ""
        //  If the newPlanDict has stored previous legal values for the UIPickers, set the UIPickers to select the rows with those values.
        if let index = expLevels.index(of: DBManager.shared.newPlanDict["expLevel"]!) {
            expPicker.selectRow(index, inComponent: 0, animated: false)
        }
        if let index = goals.index(of: DBManager.shared.newPlanDict["goal"]!) {
            goalPicker.selectRow(index, inComponent: 0, animated: false)
        }
        pickerTextUpdate(picker: expPicker, row: expPicker.selectedRow(inComponent: 0))
        pickerTextUpdate(picker: goalPicker, row: expPicker.selectedRow(inComponent: 0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //  PICKER VIEW FUNCTIONS

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return expLevels.count
        } else {
            return goals.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return expLevels[row]
        } else {
            return goals[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextUpdate(picker: pickerView, row: row)
    }

    //  INFO BUTTON FUNCTIONS
    
    @IBAction func expLevelInfo(_ sender: UIButton) {
        let title = "Experience Level"
        let message = "Select how much experience you have at the gym.  SwoleMate will adjust its recommendations based on this and your physical metrics."
        createAlert(alertTitle: title, message: message)
    }
    
    @IBAction func goalInfo(_ sender: UIButton) {
        let title = "Fitness Goal"
        let message = "\nSelect what you'd like SwoleMate to help you with!  Would you like to increase strength?  Build muscle?  Increase endurance?  Focus on cardio?  Lose weight?  SwoleMate will build a regimen that best suits your needs!"
        createAlert(alertTitle: title, message: message)
    }
    
    func createAlert(alertTitle: String, message: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Gotcha, bro!", style: .default, handler: nil)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    //  BUTTON FUNCTIONS
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let expSelect = expLevels[expPicker.selectedRow(inComponent: 0)]
        let goalSelect = goals[goalPicker.selectedRow(inComponent: 0)]
        DBManager.shared.newPlanDict["expLevel"] = expSelect
        DBManager.shared.newPlanDict["goal"] = goalSelect
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonPress(_ sender: UIButton) {
        let expSelect = expLevels[expPicker.selectedRow(inComponent: 0)]
        let goalSelect = goals[goalPicker.selectedRow(inComponent: 0)]
        DBManager.shared.newPlanDict["expLevel"] = expSelect
        DBManager.shared.newPlanDict["goal"] = goalSelect
        PlanBuilder.shared.updateData()
        PlanBuilder.shared.createExerciseRegimen()
        print(PlanBuilder.shared.myRegimen)
        performSegue(withIdentifier: "NewPlanSegue3", sender: sender)
    }
    
    
    //  HELPER FUNCTIONS
    
    func pickerTextUpdate( picker: UIPickerView, row: Int ) {
        if picker.tag == 0 {
            expInstructions.text = expLabelText[row]
        } else {
            goalInstructions.text = goalLabelText[row]
        }
    }

}

let expLabelText = [
    "New to the gym?  Don't worry!  SwoleMate will help guide you into a light new routine.  If needed, please refer to SwoleMate's guidebook on the front page!",
    "Thanks for giving SwoleMate a try for your fitness tracking needs!  We'll do our best to meet your fitness goals!",
    "Swolemate welcomes advanced gym goers and is happy to help you making gains!  Expect pyramid sets and multiple auxiliary exercise recommendations!",
    "Hardcore!  Swolemate will design a workout regimen to meet your needs, but feel free to tune things up or down to better suit your experience!"
]

let goalLabelText = [
    "Strength Gains uses a higher number of sets at lower reps with heavier weights.  Users should have familiarity with the gym and good form when choosing this option!",
    "Muscle Size uses a split routine with an intermediate rep count and weights.  Auxiliary exercises are included to help maximize your gains!",
    "Muscle Endurance focuses on increasing muscle endurance with a high rep count at lighter weights.  Auxiliary exercises are included to help improve endurance and tone!",
    "General Fitness is a balanced workout regimen, and involves a full-body workout with moderate cardio to meet a fuller range of fitness needs!",
    "Cardiac Health is a great way to fight heart disease!  This program focuses entirely on cardio, and SwoleMate recommends a High Intensity Interval Training regimen!",
    "Remember, 90% of Weight Loss takes place in the kitchen.  You can't exercise your way out of a bad diet.  However, good fitness habits help maintain weight loss!  This plan combines muscle building and cardio to help burn more calories!"
]


