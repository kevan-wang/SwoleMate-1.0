//
//  OptionsVC.swift
//  SwoleMate 1.0
//
//  Created by Kevan Wang on 8/16/18.
//  Copyright © 2018 Kevan Wang. All rights reserved.
//

import UIKit

protocol OptionsVCDelegate: class {
    func metricReset()
}

class OptionsVC: UIViewController {
    
    @IBOutlet weak var metricSwitch: UISwitch!
    @IBOutlet weak var surveySwitch: UISwitch!
    
    var delegate: OptionsVCDelegate?
    var frontVC:FrontVC?
    var metricChange = false
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        frontVC?.activationsOnViewLoad()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        DBManager.shared.saveOptions(metricPref: metricSwitch.isOn, surveyPref: surveySwitch.isOn)
        if metricChange {
            delegate?.metricReset()
        }
        frontVC?.activationsOnViewLoad()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func metricSwitchPressed(_ sender: UISwitch) {
        metricChange = !metricChange
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if DBManager.shared.options!.metricPref {
            metricSwitch.isOn = true
        } else {
            metricSwitch.isOn = false
        }
        if DBManager.shared.options!.survey {
            surveySwitch.isOn = true
        } else {
            surveySwitch.isOn = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*  INFORMATION BUTTON FUNCTIONS
     */
    
    @IBAction func metricInfoPressed(_ sender: UIButton) {
        let title = "Use Metric"
        let message = "\nWhen on, all values will be presented in metric units (centimeters, kilograms) rather than imperial (feet, pounds)."
        createAlert(alertTitle: title, message: message)
    }
    
    @IBAction func surveyInfoPressed(_ sender: UIButton) {
        let title = "Surveys"
        let message = "\nWhen on, the user allows SwoleMate to collect workout and survey question data to help improve fitness research and improve SwoleMate's ability to build more customized exercise regimens.  SwoleMate needs YOUR help!  Please turn this on if you can!"
        createAlert(alertTitle: title, message: message)
    }
    
    
    func createAlert(alertTitle: String, message: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Gotcha, bro!", style: .default, handler: nil)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }



}
