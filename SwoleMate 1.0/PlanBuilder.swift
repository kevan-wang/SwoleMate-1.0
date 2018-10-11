//
//  PlanBuilder.swift
//  SwoleMate 1.0
//
//  Created by Kevan Wang on 9/11/18.
//  Copyright © 2018 Kevan Wang. All rights reserved.
//

import UIKit
import Foundation

class PlanBuilder {

    static let shared = PlanBuilder()

    var expLevel = ""
    var goal = ""
    var age = 0
    var myRegimen:[String:Int] = [:]
    
    private init() {
    }
    
    func updateData() {
        expLevel = DBManager.shared.newPlanDict["expLevel"]!
        goal = DBManager.shared.newPlanDict["goal"]!
        age = Int(DBManager.shared.user!.age)
    }
    
    func createExerciseRegimen() {
        updateData()
        myRegimen = baseRegimen[goal]!
        adjustRegimenByExperience()
        adjustRegimenByAge()
    }
    
    func adjustRegimenByExperience() {
        //  Replaces some regimen with the ones given based on experience
        let modifiers = expModifierReplace[goal]![expLevel]!
        let keys = Array(modifiers.keys)
        for key in keys {
            if key == "" {
                break;
            }
            myRegimen[key] = modifiers[key]
        }
    }
    
    func adjustRegimenByAge() {
        //  Adjusts some regimen based on age, generally increasing rep number to alleviate joint strain as well as recommending lighter cardio
        let ageCategories = ["Young", "Mature", "Middle", "Older", "Elderly"]
        var ageIndex = (age - 21) / 10
        if ageIndex > 4 {
            ageIndex = 4
        }
        if ageIndex < 0 {
            ageIndex = 0
        }
        let ageStr = ageCategories[ageIndex]
        let modifiers = ageModifier[goal]![ageStr]!
        let keys = Array(modifiers.keys)
        for key in keys {
            if key == "" {
                break;
            }
            myRegimen[key] = myRegimen[key]! + modifiers[key]!
        }
        capRegimenByAge(ageIndex: ageIndex)
    }
    
    func capRegimenByAge(ageIndex: Int) {
        //  Further adjustments to regimen based on age, reducing number of sets to reduce strain
        //  Cap pyramid sets
        let maxPyrSets = 7 - ageIndex
        if myRegimen["PyrSets"]! > maxPyrSets {
            myRegimen["PyrSets"] = maxPyrSets
        }
        //  Cap standard sets
        let maxStaSets = 6 - ageIndex
        if myRegimen["StaSets"]! > maxStaSets {
            myRegimen["StaSets"] = maxStaSets
        }
        //  Older and Elderly individuals should replace Reverse Pyramid with Pyramid sets for safety reasons.
        if ageIndex > 2 {
            if myRegimen["MainType"] == 2 {
                myRegimen["MainType"] = 1
            }
        }
    }

    
    //  REGIMEN FOR PLAN BUILDER
    
    let baseRegimen = [
        // For Regimen, 0 = split regimen, 1 = full body
        // For MainType, 0 = standard, 1 = pyramid, 2 = reverse pyramid
        // For CardioStyle, 0 = HIIT, 1 = light, 2 = either at discretion
        // For PyrReps, this lists the starting reps STANDARD pyramid.  Subsequently backcaculate the number of reps for REVERSE pyramid later in processing.
        "Strength Gains" : [ "Regimen" : 0, "PyrSets" : 3, "PyrReps" : 7, "PyrIncDec" : 1, "StaSets" : 4, "StaReps" : 6, "MainType" : 0, "NumMain" : 1, "NumAux" : 2, "MaxAux" : 10, "TotalCardio" : 0, "NumMuscles" : 2, "RestTime" : 120, "CardioStyle" : 0 ],
        "Muscle Size" : [ "Regimen" : 0, "PyrSets" : 3, "PyrReps" : 12, "PyrIncDec" : 2, "StaSets" : 3, "StaReps" : 8, "MainType" : 2, "NumMain" : 1, "NumAux" : 2, "MaxAux" : 10, "TotalCardio" : 0, "NumMuscles" : 2, "RestTime" : 120, "CardioStyle" : 0 ],
        "Muscle Endurance" : [ "Regimen" : 0, "PyrSets" : 3, "PyrReps" : 16, "PyrIncDec" : 2, "StaSets" : 2, "StaReps" : 15, "MainType" : 0, "NumMain" : 1, "NumAux" : 2, "MaxAux" : 10, "TotalCardio" : 0, "NumMuscles" : 2, "RestTime" : 60, "CardioStyle" : 0  ],
        "General Fitness" : [ "Regimen" : 1, "PyrSets" : 3, "PyrReps" : 12, "PyrIncDec" : 2, "StaSets" : 2, "StaReps" : 10, "MainType" : 0, "NumMain" : 1, "NumAux" : 1, "MaxAux" : 2, "TotalCardio" : 30, "NumMuscles" : 4, "RestTime" : 60, "CardioStyle" : 0 ],
        "Cardiac Health" : [ "Regimen" : 1, "PyrSets" : 3, "PyrReps" : 16, "PyrIncDec" : 2, "StaSets" : 2, "StaReps" : 15, "MainType" : 0, "NumMain" : 1, "NumAux" : 1, "MaxAux" : 10, "TotalCardio" : 35, "NumMuscles" : 0, "RestTime" : 60, "CardioStyle" : 0 ],
        "Weight Loss" : [ "Regimen" : 1, "PyrSets" : 3, "PyrReps" : 12, "PyrIncDec" : 2, "StaSets" : 3, "StaReps" : 8, "MainType" : 0, "NumMain" : 1, "NumAux" : 1, "MaxAux" : 2, "TotalCardio" : 30, "NumMuscles" : 3, "RestTime" : 90, "CardioStyle" : 0 ]
    ]
    
    let expModifierReplace = [
        // For Regimen, 0 = split regimen, 1 = full body
        // For MainType, 0 = standard, 1 = pyramid, 2 = reverse pyramid
        // These modifiers REPLACE the base numbers.
        // Modifier values of [ "" : 0 ] means there will be no effect... this array only exists to keep an empty array from being misinterpreted as "[ANY]"
        "Strength Gains" : [
            "Beginner" : [ "NumAux" : 1 ],
            "Intermediate" : [ "PyrSets" : 4, "PyrReps" : 7, "StaSets" : 5, "StaReps" : 5 ],
            "Advanced" : [ "PyrSets" : 5, "PyrReps" : 7, "StaSets" : 5, "StaReps" : 5 ],
            "Elite" : [ "PyrSets" : 6, "PyrReps" : 8, "StaSets" : 5, "StaReps" : 5, "NumMain" : 2 ]
        ],
        "Muscle Size" : [
            "Beginner" : [ "MainType" : 0, "NumAux" : 1 ],
            "Intermediate" : [ "PyrSets" : 4 ],
            "Advanced" : [ "PyrSets" : 5, "PyrReps" : 14 ],
            "Elite" : [ "PyrSets" : 5, "PyrReps" : 14, "NumMain" : 2 ]
        ],
        "Muscle Endurance" : [
            "Beginner" : [ "NumAux" : 1 ],
            "Intermediate" : [ "StaSets" : 3 ],
            "Advanced" : [ "StaSets" : 3, "NumMain" : 2 ],
            "Elite" : [ "StaSets" : 3, "NumMain" : 2, "RestTime" : 40 ]
        ],
        "General Fitness" : [
            "Beginner" : [ "" : 0 ],
            "Intermediate" : [ "TotalCardio" : 35, "MaxAux" : 3 ],
            "Advanced" : [ "TotalCardio" : 40, "MaxAux" : 3, "NumMuscles" : 5 ],
            "Elite" : [ "TotalCardio" : 45, "MaxAux" : 4, "NumMuscles" : 6 ]
        ],
        "Cardiac Health" : [
            "Beginner" : [ "" : 0 ],
            "Intermediate" : [ "TotalCardio" : 40 ],
            "Advanced" : [ "TotalCardio" : 50 ],
            "Elite" : [ "TotalCardio" : 60 ]
        ],
        "Weight Loss" : [
            "Beginner" : [ "MainType" : 0 ],
            "Intermediate" : [ "NumMuscles" : 4, "TotalCardio" : 35, "MaxAux" : 3 ],
            "Advanced" : [ "NumMuscles" : 4, "TotalCardio" : 40, "MaxAux" : 4 ],
            "Elite" : [ "NumMuscles" : 5, "TotalCardio" : 45, "MaxAux" : 5 ]
        ]
    ]
    
    let ageModifier = [
        // For CardioStyle, 0 = HIIT, 1 = light, 2 = either at discretion
        // Age categories: Mature = 31-40, Middle = 41-50, Older = 51-60, Elderly = 61+
        // Add the following values to the base, do NOT replace.
        // Modifier values of [ "" : 0 ] means there will be no effect... this array only exists to keep an empty array from being misinterpreted as "[ANY]"
        "Strength Gains" : [
            "Young" : [ "" : 0 ],
            "Mature" : [ "PyrReps" : 1, "StaReps" : 1 ],
            "Middle" : [ "CardioStyle" : 2, "PyrReps" : 1, "StaReps" : 1 ],
            "Older" : [ "CardioStyle" : 1, "PyrReps" : 2, "StaReps" : 2 ],
            "Elderly" : [ "CardioStyle" : 1, "PyrReps" : 3, "StaReps" : 3 ]
        ],
        "Muscle Size" : [
            "Young" : [ "" : 0 ],
            "Mature" : [ "StaReps" : 1 ],
            "Middle" : [ "CardioStyle" : 2, "StaReps" : 2 ],
            "Older" : [ "CardioStyle" : 1, "StaReps" : 3 ],
            "Elderly" : [ "CardioStyle" : 1, "StaReps" : 4 ]
        ],
        "Muscle Endurance" : [
            "Young" : [ "" : 0 ],
            "Mature" : [ "" : 0 ],
            "Middle" : [ "CardioStyle" : 2 ],
            "Older" : [ "CardioStyle" : 1 ],
            "Elderly" : [ "CardioStyle" : 1 ]
        ],
        "General Fitness" : [
            "Young" : [ "" : 0 ],
            "Mature" : [ "" : 0 ],
            "Middle" : [ "CardioStyle" : 2 ],
            "Older" : [ "CardioStyle" : 1 ],
            "Elderly" : [ "CardioStyle" : 1 ]
        ],
        "Cardiac Health" : [
            "Young" : [ "" : 0 ],
            "Mature" : [ "" : 0 ],
            "Middle" : [ "CardioStyle" : 2 ],
            "Older" : [ "CardioStyle" : 1 ],
            "Elderly" : [ "CardioStyle" : 1 ]
        ],
        "Weight Loss" : [
            "Young" : [ "" : 0 ],
            "Mature" : [ "StaReps" : 1 ],
            "Middle" : [ "CardioStyle" : 2, "StaReps" : 2 ],
            "Older" : [ "CardioStyle" : 1, "StaReps" : 3 ],
            "Elderly" : [ "CardioStyle" : 1, "StaReps" : 4 ]
        ]
    ]
}

