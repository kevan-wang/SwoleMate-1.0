//
//  NewPlan3VC.swift
//  SwoleMate 1.0
//
//  Created by Kevan Wang on 9/8/18.
//  Copyright © 2018 Kevan Wang. All rights reserved.
//

import UIKit

class NewPlan3VC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // NOTE:  The NewPlanVCs do NOT use delegates to pass information between each other, will be using the DBManager singleton newPlanDict and newPlanTime variables instead.


    @IBOutlet weak var setTypePicker: UIPickerView!
    @IBOutlet weak var numSetsField: UITextField!
    @IBOutlet weak var numRepsField: UITextField!
    @IBOutlet weak var incDecField: UITextField!
    @IBOutlet weak var incDecLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    let setTypes = [ "Standard", "Pyramid", "Reverse Pyramid" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTypePicker.dataSource = self
        setTypePicker.delegate = self
        setDefaultValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //  PICKER VIEW FUNCTIONS
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return setTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        setRepsSets()
        pickerTextUpdate()
        return setTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setRepsSets()
        pickerTextUpdate()
    }
    

    //  BUTTON & TEXTFIELD FUNCTIONS
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func defaultButtonPressed(_ sender: UIButton) {
        setDefaultValues()
    }
    
    @IBAction func editedTextField(_ sender: UITextField) {
        pickerTextUpdate()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        let setType = setTypes[ setTypePicker.selectedRow(inComponent: 0) ]
        DBManager.shared.newPlanDict["mainSetType"] = setType
        let regimenFormat = regimenFormatString()
        DBManager.shared.newPlanDict["mainRegimenFormat"] = regimenFormat
        print(DBManager.shared.newPlanDict)
        performSegue(withIdentifier: "NewPlanSegue4", sender: sender)
    }
    
    
    
    //  INFO BUTTON FUNCTIONS
    
    @IBAction func mainExInfo(_ sender: UIButton) {
        let title = "Main Exercise"
        let message = "\nYour Main Exercises are the primary exercises for their associated muscle groups, and play a central focus in your workout since these are ones that recruit the most muscle fibers.  These should be the first exercises performed for a given muscle group in your gym session!"
        createAlert(alertTitle: title, message: message)
    }
    
    @IBAction func inputInfo(_ sender: UIButton) {
        let title = "Sets, Reps, Dec/Inc"
        let message = "\nOften written as 4x5 (4 sets of 5 repetitions), 3x8 (3 sets of 8 repetitions), or 12/10/8/6/4 (a set of 12, followed by a set of 10, followed by a set of 8, etc...).  Swolemate will help you track your performance and target number of reps/set!\n\nPlease note that the maximum number of sets that SwoleMate can process is 8.\n\nThe Decrement or Increment (Dec/Inc) field is only used for pyramid sets, and represents the number of reps that should be dropped or raised for each subsequent set."
        createAlert(alertTitle: title, message: message)
    }
    
    @IBAction func defaultInfo(_ sender: UIButton) {
        let title = "SwoleMate Recommends!"
        let message = "\nSwoleMate's default recommendations take into account the user's age and experience level to calculate a safe and effective fitness plan to best achieve your given goal!"
        createAlert(alertTitle: title, message: message)
        //  For SwoleMate 2.0, give dynamic feedback given user's metrics
    }
    
    func createAlert(alertTitle: String, message: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Gotcha, bro!", style: .default, handler: nil)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    //  HELPER FUNCTIONS
    
    func setDefaultValues() {
        //  Set setTypePicker to the default value.
        let mainSetType = PlanBuilder.shared.myRegimen["MainType"]!
        setTypePicker.selectRow(mainSetType, inComponent: 0, animated: false)
        setRepsSets()
        pickerTextUpdate()
    }
    
    func setRepsSets() {
        //  Set the numSetsField, numRepsField, and incDecField to default main set type values.
        let mainSetType = setTypePicker.selectedRow(inComponent: 0)
        if mainSetType != 0 {
            //  If the main set type is a Pyramid or Reverse pyramid set
            let numSets = PlanBuilder.shared.myRegimen["PyrSets"]!
            var numReps = PlanBuilder.shared.myRegimen["PyrReps"]!
            let incDec = PlanBuilder.shared.myRegimen["PyrIncDec"]!
            if mainSetType == 2 {
                //  If the regimen specifically calls for a Reverse Pyramid set instead of Reverse Pyramid, adjust the rep count accordingly since the regimen builder by default assumes Reverse Pyramid
                numReps -= incDec * (numSets-1)
            }
            numSetsField.text = String(numSets)
            numRepsField.text = String(numReps)
            incDecField.text = String(incDec)
        }
        else {
            incDecField.text = ""
            let numSets = PlanBuilder.shared.myRegimen["StaSets"]!
            let numReps = PlanBuilder.shared.myRegimen["StaReps"]!
            numSetsField.text = String(numSets)
            numRepsField.text = String(numReps)
        }
    }
    
    func pickerTextUpdate() {
        if setTypePicker.selectedRow(inComponent: 0) == 0 {
            //  Standard set settings
            incDecLabel.text = "N/A"
            incDecField.isEnabled = false
            incDecField.backgroundColor = UIColor.gray
        } else if setTypePicker.selectedRow(inComponent: 0) == 1 {
            // Pyramid set settings
            incDecLabel.text = "Dec:"
            incDecField.isEnabled = true
            incDecField.backgroundColor = UIColor.white
        } else if setTypePicker.selectedRow(inComponent: 0) == 2 {
            // Reverse Pyramid set settings
            incDecLabel.text = "Inc:"
            incDecField.isEnabled = true
            incDecField.backgroundColor = UIColor.white
        }
        let setTypeDesc = setTypeLabelText[setTypePicker.selectedRow(inComponent: 0)]
        let regimenFormat = generateRegimenDesc()
        detailLabel.text = setTypeDesc + regimenFormat
    }
    
    func generateRegimenDesc() -> String {
        //  Describes the regimen.
        var str = "\n\nYour main exercise rep-set format is currently "
        str += regimenFormatString()
        return str
    }
    
    func regimenFormatString() -> String {
        var str = ""
        let setType = setTypePicker.selectedRow(inComponent: 0)
        let regimenArrayFields = [ numSetsField, numRepsField, incDecField ]
        var regimenValues = [ 1, 1, 0]
        for index in 0...2 {
            if let x = Int((regimenArrayFields[index]?.text!)!) {
                regimenValues[index] = x
            } else {
                regimenArrayFields[index]?.text = ""
            }
        }
        var numSets = regimenValues[0]
        if numSets > 8 {
            numSets = 8
            numSetsField.text = "8"
        }
        let numReps = regimenValues[1]
        let numIncDec = regimenValues[2]
        switch setType {
        case 0:
            for index in 1...numSets {
                str += String(numReps)
                if index != numSets {
                    str += "/"
                }
            }
        case 1:
            for index in 1...numSets {
                let totalDec = numIncDec * (index - 1)
                if totalDec >= numReps {
                    str += "1"
                } else {
                    str += String(numReps - totalDec)
                }
                if index != numSets {
                    str += "/"
                }
            }
        case 2:
            for index in 1...numSets {
                str += String(numReps + (numIncDec * (index - 1)))
                if index != numSets {
                    str += "/"
                }
            }
        default:
            str += "ERROR"
        }
        return str
    }
}




