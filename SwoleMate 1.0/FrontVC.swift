//
//  ViewController.swift
//  SwoleMate 1.0
//
//  Created by Kevan Wang on 8/12/18.
//  Copyright © 2018 Kevan Wang. All rights reserved.
//

import UIKit

class FrontVC: UIViewController {


    @IBOutlet weak var swoleTipLabel: UILabel!
    @IBOutlet weak var checkInButton: UIButton!
    @IBOutlet weak var surveysButton: UIButton!
    @IBOutlet weak var fitnessPlansButton: UIButton!
    @IBOutlet weak var recordsButton: UIButton!

    
    var myButtons:[UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myButtons = [ checkInButton, surveysButton, fitnessPlansButton, recordsButton ]
        activationsOnViewLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func activationsOnViewLoad() {
        swoleTipLabel.text = nil
        if DBManager.shared.user == nil {
            createAlert()
            swoleTipLabel.text = "Please set up your profile!  It's quick!"
            deactivateButtons(buttons: myButtons)
        }
        else {
            displaySwoleTip()
            activateButtons(buttons: myButtons)
        }
    }
    
    func createAlert() {
        let alert = UIAlertController(title: "Welcome!", message: "\nPlease set up a profile to start using Swolemate!", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Gotcha, bro!", style: .default, handler: nil)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
    func displaySwoleTip() {
        let stCount = UInt32(DBManager.shared.swoleTips.count)
        let index = Int(arc4random_uniform(stCount))
        let text = DBManager.shared.swoleTips[index].text
        swoleTipLabel.text = text
    }
    
    func activateButtons(buttons: [UIButton]) {
        for button in buttons {
            button.isEnabled = true
        }
        if !DBManager.shared.options!.survey {
            surveysButton.isEnabled = false
        }
    }

    func deactivateButtons(buttons: [UIButton]) {
        for button in buttons {
            button.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav  = segue.destination as! UINavigationController
        if segue.identifier == "ProfileSegue" {
            let dest = nav.topViewController! as! ProfileVC
            dest.frontVC = self
        }
        else if segue.identifier == "OptionsSegue" {
            let dest = nav.topViewController! as! OptionsVC
            dest.frontVC = self
        }
    }
    
    //  BUTTON FUNCTIONS
    
    @IBAction func infoButtonClicked(_ sender: UIButton) {
        var helpMessage = ""
        if DBManager.shared.user == nil {
            helpMessage = "Welcome to SwoleMate!  Please set up a Profile to begin!"
        } else {
            helpMessage = "\nThanks for using SwoleMate!\n\nWORKOUT CHECK-IN:  Check in for today's workout, or update SwoleMate if you need to skip a day!\n\nSURVEYS:  Answer questions to help SwoleMate improve fitness research!\n\nFITNESS PLANS:  Allows you to create, edit, view, or delete fitness plans!\n\nRECORDS:  Check your performance record over time!"
        }
        let alert = UIAlertController(title: "Main Page Help!", message: helpMessage, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Gotcha, bro!", style: .default, handler: nil)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    


}













