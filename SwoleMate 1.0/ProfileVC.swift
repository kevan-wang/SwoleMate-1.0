//
//  ProfileVC.swift
//  SwoleMate 1.0
//
//  Created by Kevan Wang on 8/14/18.
//  Copyright © 2018 Kevan Wang. All rights reserved.
//

import UIKit
import Foundation

class ProfileVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var heightLabel1: UILabel!
    @IBOutlet weak var heightLabel2: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var heightField1: UITextField!
    @IBOutlet weak var heightField2: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    var name: String = ""
    var heightCm: Double = 0.0
    var weightKg: Double = 0.0
    var age: Int = 0
    var gender: String = ""
    let genders = [ "N/A", "Male", "Female", "Nonbinary/Other" ]
    
    var frontVC:FrontVC?
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        frontVC?.activationsOnViewLoad()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        gatherData()
        if checkValidFields() {
            DBManager.shared.saveUser(age: Int32(self.age), gender: self.gender, heightCm: Int32(self.heightCm), name: self.name, weightKg: self.weightKg)
            frontVC?.activationsOnViewLoad()
            dismiss(animated: true, completion: nil)
        }
    }

    /*  SETUP FUNCTIONS
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.genderPicker.dataSource = self
        self.genderPicker.delegate = self
        genderPicker.tag = 0
        genderPicker.selectRow(0, inComponent: 0, animated: false)
        metricReset()
        fillFieldsFromDB()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        gatherData()
        let nav = segue.destination as! UINavigationController
        let dest = nav.topViewController as! OptionsVC
        dest.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }

    
    /*  INPUT HANDLER FUNCTIONS
     */
    
    func fillFieldsFromDB() {
        if DBManager.shared.user != nil {
            let user = DBManager.shared.user!
            nameField.text = user.name
            ageField.text = String(user.age)
            let genderInt = genders.index(of: user.gender!)
            genderPicker.selectRow(genderInt!, inComponent: 0, animated: false)
            self.heightCm = Double(user.heightCm)
            self.weightKg = user.weightKg
            metricReset()
        }
    }
    
    func gatherData() {
        self.gender = genders[genderPicker.selectedRow(inComponent: 0)]
        gatherName()
        gatherAge()
        gatherHeight()
        gatherWeight()
    }
    
    // Helper function for gatherData()
    func gatherName() {
        if let nameTest = nameField.text {
            self.name = nameTest
        }
        else {
            self.name = ""
            nameField.text = ""
        }
    }
    
    // Helper function for gatherData()
    func gatherAge() {
        if let ageTest = Int(ageField.text!) {
            self.age = ageTest
        }
        else {
            self.age = 0
            ageField.text = ""
        }
    }
    
    // Helper function for gatherData()
    func gatherHeight() {
        // If user option uses metric, store the values as they are
        if DBManager.shared.options!.metricPref {
            if let heightTest = Double(heightField1.text!) {
                self.heightCm = heightTest
            }
            else {
                self.heightCm = 0
                heightField1.text = ""
            }
        }
        // If the user option does NOT use metric, convert to metric values
        else {
            var heightIn: Double = 0.0
            if let heightTest1 = Double(heightField1.text!) {
                heightIn += heightTest1 * 12
            }
            else {
                heightField1.text = ""
            }
            if let heightTest2 = Double(heightField2.text!) {
                heightIn += heightTest2
            }
            else {
                heightField1.text = ""
            }
            if heightIn > 0 {
                self.heightCm = Double(heightIn * 2.54)
            }
            else {
                self.heightCm = 0
            }
        }
    }
    
    // Helper function for gatherData()
    func gatherWeight() {
        // If user option uses metric, store the values as they are
        if DBManager.shared.options!.metricPref {
            if let weightTest = Double(weightField.text!) {
                self.weightKg = weightTest
            }
            else {
                self.weightKg = 0
                weightField.text = ""
            }
        }
        // If the user option does NOT use metric, convert to metric values
        else {
            if let weightTest = Double(weightField.text!) {
                self.weightKg = weightTest / 2.2
            }
            else {
                self.weightKg = 0
                weightField.text = ""
            }
        }
    }
    
    func checkValidFields() -> Bool {
        let nameCheck = self.name != ""
        let heightCheck = self.heightCm > 0
        let weightCheck = self.weightKg > 0
        let ageCheck = self.age > 0
        return nameCheck && heightCheck && weightCheck && ageCheck
    }


    
}


extension ProfileVC: OptionsVCDelegate {
    func metricReset() {
        if DBManager.shared.options!.metricPref {
            //  Reset the labels from imperial units to metric
            heightLabel1.text = "cm"
            heightLabel2.text = ""
            weightLabel.text = "kgs"
            
            // Fill the fields with the appropriate metric values.
            heightField1.text = String(Int(heightCm))
            heightField2.text = ""
            weightField.text = String(round(weightKg * 10) / 10)

            // Disable heightField2 as it is no longer needed
            heightField2.isEnabled = false
            heightField2.backgroundColor = UIColor.gray
        }
        else {
            // Ensure that heightField2 is enabled
            heightField2.isEnabled = true
            heightField2.backgroundColor = UIColor.white

            //  Reset the labels from imperial units to metric
            heightLabel1.text = "ft"
            heightLabel2.text = "in"
            weightLabel.text = "lbs"
            
            //  Convert existing values in the fields from imperial to metric
            let heightIn = heightCm / 2.54
            let weightLb = weightKg * 2.2
            
            // Fill the fields with the appropriate metric values.
            heightField1.text = String(Int(heightIn / 12))
            heightField2.text = String(Int(round(heightIn)) % 12)
            weightField.text = String(round(weightLb*10)/10)
        }
        if heightField1.text == "0" {
            heightField1.text = ""
        }
        if heightField2.text == "0" {
            heightField2.text = ""
        }
        if weightField.text == "0.0" {
            weightField.text = ""
        }

    }
}





