//
//  DBManager.swift
//  SwoleMate 1.0
//
//  Created by Kevan Wang on 8/12/18.
//  Copyright © 2018 Kevan Wang. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class DBManager {
    //  The DBManager is a singleton:  Initialized once and can be called from elsewhere in the program.
    //  It serves as the main access point to the database.
    
    static let shared = DBManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    var user:User?
    var options:Options?
    var swoleTips = [SwoleTip]()
    var muscleGroups = [MuscleGroup]()
    var exerciseCategories = [ExerciseCategory]()
    var weightExercises = [WeightExercise]()
    var cardioExercises = [CardioExercise]()
    
    // NewPlanDict variables are global variables for creating a new plan.
    
    var newPlanDict:[String:String] = [:]
    var newPlanWeek:[Int] = []
    var newPlanTime:Date?
    
    
    
    ////////
    //
    //  READ FUNCTIONS
    //
    ////////

    func fetchFitnessPlans() -> [FitnessPlan] {
        let request : NSFetchRequest<FitnessPlan> = FitnessPlan.fetchRequest()
        var arr : [FitnessPlan] = []
        do {
            arr = try context.fetch(request)
        } catch {
            print("ERROR in reading FitnessPlans.\n \(error)")
        }
        return arr
    }
    
    
    
    
    ////////
    //
    //  USER, SETTINGS, AND LIBRARY INITIALIZATION FUNCTIONS
    //
    ////////
    
    private init() {
        //  The init() method is run by default to set initial values
        initializeUser()
        initializeSwoleTips()
        initializeOptions()
        initializeMuscleGroups()
        initializeExerciseCategories()
        initializeWeightExercises()
        initializeCardioExercises()
//        let exercises = filterExercisesByTarget(exercises: weightExercises, target: "Mid Pectoralis")
//        let powerExercises = filterExercisesByPOF(exercises: exercises, pof: "Power")
//        for ex in powerExercises {
//            print(ex.name!)
//        }
//        let equipment = [ "Machine", "Cable", "Barbell", "Dumbbell"  ]
//        print("IDEAL EXERCISE:  " + (idealWeightExercise(exercises: powerExercises, equipment: equipment)?.name!)!)
    }
    
    func initializeUser() {
        let userRequest:NSFetchRequest<User> = User.fetchRequest()
        do {
            let userArr = try context.fetch(userRequest)
            if userArr.count > 0 {
                user = userArr[0]
            }
        } catch {
            print("\(error)")
        }
    }
    
    func initializeSwoleTips() {
        // Initializes the database of SwoleTip entities.
        let request:NSFetchRequest<SwoleTip> = SwoleTip.fetchRequest()
        do {
            swoleTips = try context.fetch(request)
            if swoleTips.count == 0 {
                for elem in stLibrary {
                    let newST = SwoleTip(context: context)
                    newST.text = elem
                    newST.displayedFlag = false
                    saveContext()
                }
                swoleTips = try context.fetch(request)
            }
        } catch {
            print("\(error)")
        }
    }
    
    func initializeMuscleGroups() {
        // Initializes the database of MuscleGroup entities.
        let request:NSFetchRequest<MuscleGroup> = MuscleGroup.fetchRequest()
        do {
            muscleGroups = try context.fetch(request)
            if muscleGroups.count == 0 {
                for elem in mgLibrary {
                    let newMG = MuscleGroup(context: context)
                    newMG.region = elem[0]
                    newMG.subregion = elem[1]
                    newMG.name = elem[2]
                    saveContext()
                }
                muscleGroups = try context.fetch(request)
            }
        } catch {
            print("\(error)")
        }
    }
    
    func initializeExerciseCategories() {      // connect the ExCat to the given exercise!!!
        // Initialize the database of ExerciseCategory entities.
        let request:NSFetchRequest<ExerciseCategory> = ExerciseCategory.fetchRequest()
        do {
            exerciseCategories = try context.fetch(request)
            if exerciseCategories.count == 0 {
                for elem in exCatLibrary {
                    let newExCat = ExerciseCategory(context: context)
                    newExCat.name = elem[0]
                    newExCat.force = elem[2]
                    newExCat.mechanics = elem[3]
                    newExCat.position = elem[4]
                    newExCat.utility = elem[5]
                    // connect relationships:  MuscleGroups (target)
                        // WeightExercise will be linked in initializeWeightExercises()
                    // retrieve the muscle group with the name in elem[1] of the given exCat array
                    let muscleGroupNames = elem[1].split(separator: "/")
                    for mgName in muscleGroupNames {
                        let predicate = NSPredicate(format: "name = %@", argumentArray: [mgName])
                        let mGroup = (muscleGroups as NSArray).filtered(using: predicate) as! [MuscleGroup]
                        newExCat.addToTargets(mGroup[0])
                    }
                    saveContext()
                }
                exerciseCategories = try context.fetch(request)
            }
        } catch {
            print("\(error)")
        }
    }
    
    func initializeWeightExercises() {
        // Initialize the database of WeightExercise entities.
        let request:NSFetchRequest<WeightExercise> = WeightExercise.fetchRequest()
        do {
            weightExercises = try context.fetch(request)
            if weightExercises.count == 0 {
                for elem in weightExLibrary {
                    let newWeightEx = WeightExercise(context: context)
                    newWeightEx.name = elem[1]
                    newWeightEx.uses = elem[4]
                    newWeightEx.desc = elem[5]
                    newWeightEx.oneRepMaxKg = 0.0
                    // connect relationships:  MuscleGroup (synergists), MuscleGroup (stabilizers), ExerciseCategory
                    // retrieve the synergist muscle group with the name in elem[1] of the given exCat array
                    let synergistNames = elem[2].split(separator: "/")
                    for mgName in synergistNames {
                        let predicate = NSPredicate(format: "name = %@", argumentArray: [mgName])
                        let mGroup = (muscleGroups as NSArray).filtered(using: predicate) as! [MuscleGroup]
                        newWeightEx.addToSynergists(mGroup[0])
                    }
                    let stabilizerNames = elem[3].split(separator: "/")
                    for mgName in stabilizerNames {
                        let predicate = NSPredicate(format: "name = %@", argumentArray: [mgName])
                        let mGroup = (muscleGroups as NSArray).filtered(using: predicate) as! [MuscleGroup]
                        newWeightEx.addToStabilizers(mGroup[0])
                    }
                    let exCatName = elem[0]
                    let predicate = NSPredicate(format: "name = %@", argumentArray: [exCatName])
                    let exCat = (exerciseCategories as NSArray).filtered(using: predicate) as! [ExerciseCategory]
                    newWeightEx.exerciseCategory = exCat[0]
                    saveContext()
                }
                weightExercises = try context.fetch(request)
            }
        } catch {
            print("\(error)")
        }
    }
    
    func initializeCardioExercises() {
        // Initializes the database of MuscleGroup entities.
        let request:NSFetchRequest<CardioExercise> = CardioExercise.fetchRequest()
        do {
            cardioExercises = try context.fetch(request)
            if cardioExercises.count == 0 {
                for elem in cardioExLibrary {
                    let newCardEx = CardioExercise(context: context)
                    newCardEx.name = elem[0]
                    newCardEx.desc = elem[1]
                    saveContext()
                }
                cardioExercises = try context.fetch(request)
            }
        } catch {
            print("\(error)")
        }
    }
    
    func initializeOptions() {
        let optionsRequest:NSFetchRequest<Options> = Options.fetchRequest()
        do {
            let optionsArr = try context.fetch(optionsRequest)
            if optionsArr.count > 0 {
                options = optionsArr[0]
            }
            else {
                let newOptions = Options(context: context)
                newOptions.metricPref = false
                newOptions.survey = false
                options = newOptions
                saveContext()
            }
        } catch {
            print("\(error)")
        }
    }

    func saveUser(age: Int32, gender: String, heightCm: Int32, name: String, weightKg: Double) -> Void {
        if user == nil {
            let newUser = User(context: context)
            newUser.age = age
            newUser.gender = gender
            newUser.heightCm = heightCm
            newUser.name = name
            newUser.weightKg = weightKg
            saveContext()
            user = newUser
        }
        else {
            user!.age = age
            user!.gender = gender
            user!.heightCm = heightCm
            user!.name = name
            user!.weightKg = weightKg
            saveContext()
        }
    }
    
    func saveOptions(metricPref: Bool, surveyPref: Bool) {
        options!.metricPref = metricPref
        options!.survey = surveyPref
        saveContext()
    }
    
    
    
    ////////
    //
    //  FITNESS PLAN AND DAY PLAN MANAGEMENT
    //
    ////////
    
    func createFitnessPlan() {
        let cardioStyles = ["HIIT cardio", "Light Cardio", "HIIT or Light Cardio" ]
        
        let newPlan = FitnessPlan(context: context)
        newPlan.active = false
        newPlan.name = newPlanDict["name"]
        newPlan.experience = newPlanDict["expLevel"]
        newPlan.goal = newPlanDict["goal"]
        newPlan.daysOfWeek = stringifyWeek(arr: newPlanWeek)
        newPlan.mainSetFormat = stringifyRegimen( setType: newPlanDict["mainSetType"]!, setFormat: newPlanDict["mainRegimenFormat"]! )
        newPlan.auxSetFormat = stringifyRegimen( setType: newPlanDict["auxSetType"]!, setFormat: newPlanDict["auxRegimenFormat"]! )
        newPlan.totalCardio = Int32(PlanBuilder.shared.myRegimen["TotalCardio"]!)
        newPlan.restTime = Int32(PlanBuilder.shared.myRegimen["RestTime"]!)
        newPlan.cardioStyle = cardioStyles[ PlanBuilder.shared.myRegimen["CardioStyle"]! ]
        fillFitnessPlan(fitnessPlan: newPlan)
        saveContext()
    }
    
    func stringifyWeek(arr: [Int]) -> String {
        //  converts an array of Ints for the week (0 for Sunday, 6 for Saturday) into a string
        //      for storing in a new plan's daysOfWeek field.
        var str = ""
        for elem in arr {
            str += String(elem)
        }
        return str
    }
    
    func stringifyRegimen(setType: String, setFormat: String) -> String {
        //  Turns a regimen into a string.  Kind of basic.
        //  INPUT:  setType is "Standard", "Pyramid", or "Reverse Pyramid".  setFormat is something like 6/6/6
        //  OUTPUT:  Just takes the first character of the setType and attaches it to the setFormat.
        return setType.prefix(1) + setFormat
    }
    
    func destringifySetFormat(format: String) -> [Int] {
        //  Turns a string from a plan's mainSetFormat or auxSetFormat into an array of Ints representing the reps
        //      for each set.
        let reps = format.suffix(format.count-1)    // removes the setType prefix.
        let arr = reps.split(separator: "/")        // array of strings that represent the reps.
        var arr2 : [Int] = []
        for num in arr {
            arr2.append(Int(num)!)
        }
        return arr2
    }
    
    func identSetType(format: String) -> String {
        let char = format.prefix(1)
        switch char {
        case "S":
            return "Standard"
        case "P":
            return "Pyramid"
        case "R":
            return "Reverse Pyramid"
        default:
            return "ERROR IN identSetType"
        }
    }
    
    func fillFitnessPlan(fitnessPlan: FitnessPlan) {
        //  Generates all day plans for a FitnessPlan
        let numMusc = PlanBuilder.shared.myRegimen["NumMuscles"]!
        let numMain = PlanBuilder.shared.myRegimen["NumMain"]!
        let numAux = PlanBuilder.shared.myRegimen["NumAux"]!
        let maxAux = PlanBuilder.shared.myRegimen["MaxAux"]!
        addDayPlans(fitnessPlan: fitnessPlan, numMusc: numMusc)
        addWeightRegimens(fitnessPlan: fitnessPlan, numMain: numMain, numAux: numAux, maxAux: maxAux)
        addCardioRegimens(fitnessPlan: fitnessPlan)       //  FIX:  This function needs to be created.
//        printFitnessPlanDays(fitnessPlan: fitnessPlan)
//        printFitnessPlanExercises(fitnessPlan: fitnessPlan)
    }
    
    func addDayPlans(fitnessPlan: FitnessPlan, numMusc: Int) {
        //  Adds all the exercise days and their given muscle groups
        var sequence = 0
        let muscleGroupsWorked : [String:[String]]
        var dayKeys : [String] = []
        if newPlanDict["routineType"] == "Split" {
            muscleGroupsWorked = [
                "Chest & Bicep Day" : [ "Mid Pectoralis", "Biceps" ],
                "Leg Day" : [ "Hamstrings", "Quadriceps", "Gluteus", "Calves" ],
                "Tricep & Shoulder Day" : [ "Triceps", "Deltoids" ],
                "Back Day" : [ "Trapezius", "Latissimus Dorsi" ]
            ]
            dayKeys = [ "Chest & Bicep Day", "Leg Day", "Tricep & Shoulder Day", "Back Day" ]
        } else {
            muscleGroupsWorked = [
                "Full Body Day 1" : [ "Mid Pectoralis", "Trapezius", "Gluteus", "Calves", "Rectus Abdominis", "Erector Spinae" ],
                "Full Body Day 2" : [ "Quadriceps", "Hamstrings", "Latissimus Dorsi", "Biceps", "Triceps", "Deltoids" ],
                "Full Body Day 3" : [ "Erector Spinae", "Rectus Abdominis", "Calves", "Mid Pectoralis", "Trapezius", "Gluteus"  ],
                "Full Body Day 4" : [ "Triceps", "Biceps", "Deltoids", "Quadriceps", "Hamstrings", "Latissimus Dorsi" ]
            ]
            //  FIX:  Add a condition to deal with Cardiac Health, which doesn't list ANY muscle groups.
            dayKeys = [ "Full Body Day 1", "Full Body Day 2", "Full Body Day 3", "Full Body Day 4" ]
        }
        for day in dayKeys {
            //  Generate a day plan
            let newDayPlan = DayPlan(context: context)
            newDayPlan.name = day
            newDayPlan.sequence = Int32(sequence)
            newDayPlan.dateNext = newPlanTime // FIX THIS TO GIVE THE PROPER DATE - wrote dateToInt and nextDate functions to help.
            //  FIX:  Get back to data models and consider deleting the timeStart field from DayPlan
            //  Attach muscle groups to this day plan
            if day != "Leg Day" {
                //  Non-leg days will limit to the muscles listed
                for index in 0..<numMusc {
                    let mgName = muscleGroupsWorked[day]![index]
                    let predicate = NSPredicate(format: "name = %@", argumentArray: [mgName])
                    let mGroup = (muscleGroups as NSArray).filtered(using: predicate) as! [MuscleGroup]
                    newDayPlan.addToMuscleGroups(mGroup[0])
                }
            } else {
                //  Leg days will focus on all leg exercises
                let numLegMuscles = (muscleGroupsWorked["Leg Day"]?.count)!
                for index in 0..<numLegMuscles {
                    let mgName = muscleGroupsWorked[day]![index]
                    let predicate = NSPredicate(format: "name = %@", argumentArray: [mgName])
                    let mGroup = (muscleGroups as NSArray).filtered(using: predicate) as! [MuscleGroup]
                    newDayPlan.addToMuscleGroups(mGroup[0])
                }
            }
            fitnessPlan.addToDayPlans(newDayPlan)
            sequence += 1
        }
    }
    
    func addWeightRegimens(fitnessPlan: FitnessPlan, numMain: Int, numAux: Int, maxAux: Int) {
        //  Determine ideal piece of equipment to use.
        //  Starts at median of 2 (Cable)
        let expLevels = [ "Beginner", "Intermediate", "Advanced", "Elite" ]
        let expLevel = fitnessPlan.experience!
        var baseEquipIndex = expLevels.index(of: expLevel)! + 2
        baseEquipIndex = adjustEquipIndexByAge(index: baseEquipIndex)
        let equipment = equipmentPriority(baseIndex: baseEquipIndex, expLevel: expLevel)
        //  Loop through all the DayPlans in the FitnessPlan and populate the DayPlans with WeightRegimens
        if let dayPlans = fitnessPlan.dayPlans as? Set<DayPlan> {
            for day in dayPlans {
                var maxAuxCounter = maxAux
                if let muscles = day.muscleGroups as? Set<MuscleGroup> {
                    for muscle in muscles {
                        let muscleExercises = filterExercisesByTarget(exercises: weightExercises, target: muscle.name!)// all exercises that target this muscle group
                        var powerExercises = filterExercisesByPOF(exercises: muscleExercises, pof: "Power")
                        var contractedExercises = filterExercisesByPOF(exercises: muscleExercises, pof: "Contracted")
                        var stretchExercises = filterExercisesByPOF(exercises: muscleExercises, pof: "Stretch")
                        var dayExercisesMain : [WeightExercise] = []
                        var dayExercisesAux : [WeightExercise] = []
                        for _ in 0..<numMain {
                            //  Add a main exercise using a given equipment type
                            //  FIX:  Make adjustments for Leg Day.
                            //  FIX:  Make sure you remove redundant exercises that target the same muscle groups?
                            //  FIX:  Make sure you remove redundant exercises from the same exercise category?
                            //  FIX:  Additional main exercises after the first should use the Aux format instead of main.
                            //  FIX:  Consider adding the exercise tracker back in.
                            if powerExercises.count > 0 {
                                let setType = identSetType(format: fitnessPlan.mainSetFormat!)
                                if let addEx = idealWeightExercise(exercises: powerExercises, equipment: equipment, setType: setType) {
                                    powerExercises = removeExerciseFromList(exerciseList: powerExercises, remove: addEx)
                                    contractedExercises = removeExerciseFromList(exerciseList: contractedExercises, remove: addEx)
                                    stretchExercises = removeExerciseFromList(exerciseList: stretchExercises, remove: addEx)
                                    dayExercisesMain.append(addEx)
                                }
                            }
                        }
                        if maxAuxCounter > 0 {
                            //  Add up to one or two auxiliary exercises.
                            //  FIX:  Make adjustments for Leg Day.
                            let setType = identSetType(format: fitnessPlan.auxSetFormat!)
                            if numAux >= 1 {
                                //  If there is at least 1 auxiliary exercise per muscle group, add a contracted exercise
                                if let addEx = idealWeightExercise(exercises: contractedExercises, equipment: equipment, setType: setType) {
                                    contractedExercises = removeExerciseFromList(exerciseList: contractedExercises, remove: addEx)
                                    stretchExercises = removeExerciseFromList(exerciseList: stretchExercises, remove: addEx)
                                    dayExercisesAux.append(addEx)
                                    maxAuxCounter -= 1
                                }
                            }
                            if numAux == 2 {
                                //  If there are 2 auxiliary exercises per muscle group, add a stretch exercise
                                if let addEx = idealWeightExercise(exercises: stretchExercises, equipment: equipment, setType: setType) {
                                    stretchExercises = removeExerciseFromList(exerciseList: stretchExercises, remove: addEx)
                                    dayExercisesAux.append(addEx)
                                    maxAuxCounter -= 1
                                }
                            }
                        }
                        //  Now we have the list of main exercises for a muscle, as well as a list of aux exercises.
                        //  Add the muscle groups to the day plan
                        //  Build regimens, then add them to the day plan!
                        let mainRegimen = destringifySetFormat(format: fitnessPlan.mainSetFormat!)
                        let auxRegimen = destringifySetFormat(format: fitnessPlan.auxSetFormat!)
                        for exercise in dayExercisesMain {
                            let regimen = WeightRegimen(context: context)
                            var order = 0
                            for numReps in mainRegimen {
                                let set = WeightSet(context: context)
                                set.order = Int32(order)
                                set.repsGoal = Int32(numReps)
                                set.restTime = fitnessPlan.restTime
                                switch fitnessPlan.goal {
                                //  FIX:  Drop/Increase the amount of weight given if it's a pyramid or reverse pyramid set.
                                case "Strength Gains":
                                    set.weightKgGoal = exercise.oneRepMaxKg * 0.8 + 2.5 * Double(baseEquipIndex)
                                case "Muscle Size":
                                    set.weightKgGoal = exercise.oneRepMaxKg * 0.7 + 3.75 * Double(baseEquipIndex)
                                case "Weight Loss":
                                    set.weightKgGoal = exercise.oneRepMaxKg * 0.7 + 3.75 * Double(baseEquipIndex)
                                default:
                                    set.weightKgGoal = exercise.oneRepMaxKg * 0.6 + 2.5 * Double(baseEquipIndex)
                                }
                                regimen.addToWeightSets(set)
                                order += 1
                            }
                            day.addToWeightRegimens(regimen)
                            exercise.addToWeightRegimens(regimen)
                        }
                        for exercise in dayExercisesAux {
                            let regimen = WeightRegimen(context: context)
                            var order = 0
                            for numReps in auxRegimen {
                                let set = WeightSet(context: context)
                                set.order = Int32(order)
                                set.repsGoal = Int32(numReps)
                                set.restTime = fitnessPlan.restTime
                                switch fitnessPlan.goal {
                                //  FIX:  Drop/Increase the amount of weight given if it's a pyramid or reverse pyramid set.
                                case "Strength Gains":
                                    set.weightKgGoal = exercise.oneRepMaxKg * 0.8 + 2.5 * Double(baseEquipIndex)
                                case "Muscle Size":
                                    set.weightKgGoal = exercise.oneRepMaxKg * 0.7 + 3.75 * Double(baseEquipIndex)
                                case "Weight Loss":
                                    set.weightKgGoal = exercise.oneRepMaxKg * 0.7 + 3.75 * Double(baseEquipIndex)
                                default:
                                    set.weightKgGoal = exercise.oneRepMaxKg * 0.6 + 2.5 * Double(baseEquipIndex)
                                }
                                regimen.addToWeightSets(set)
                                order += 1
                            }
                            day.addToWeightRegimens(regimen)
                            exercise.addToWeightRegimens(regimen)
                        }
                        saveContext()
                    }
                }
            }
        }
    }
    
    func addCardioRegimens(fitnessPlan: FitnessPlan) {
        let totalCardioSeconds = fitnessPlan.totalCardio * 60
        if totalCardioSeconds > 0 {
            if let dayPlans = fitnessPlan.dayPlans as? Set<DayPlan> {
                //  Create a cardio workout best suited for the user's age... treadmill for under-40s, elliptical for over-40s.
                let cardioExercise = idealCardioExercise()
                let regimen = CardioRegimen(context: context)
                regimen.name = cardioExercise.name!
                regimen.notes = ""  //  FIX:  Add some notes about HIIT vs light cardio
                regimen.cardioExercise = cardioExercise
                let cardioSet = CardioSet(context: context)
                //  FIX:  Customize the cardio set data more here.
                cardioSet.resistLow = 0
                cardioSet.resistHigh = 0
                cardioSet.speedLow = 1
                cardioSet.speedHigh = 1
                cardioSet.timeLow = 40
                cardioSet.timeHigh = 80
                cardioSet.timeTotalGoal = 600
                regimen.addToCardioSets(cardioSet)
                for day in dayPlans {
                    day.addToCardioRegimens(regimen)
                }
            }
            saveContext()
        }
    }
    
    
    
    ////////
    //
    //      HELPER FUNCTIONS for fillFitnessPlans and its associated sub-functions.
    //
    ////////
    
    func dateToInt(date: Date) -> Int {
        //  Returns the given date converted to Int format consistent with our standard (0 = sunday, 6 = saturday)
        let calendar = Calendar(identifier: .gregorian)
        let dayNum = calendar.component(.weekday, from: date) - 1
        return dayNum
    }
    
    func nextDate(date: Date, nextDayNum: Int) -> Date {
        //  Returns the next date of exercise.
        //  FIX:  Currently only gives the same time.
        let daySpan : Int
        let currentDayNum = dateToInt(date: date)
        if nextDayNum > currentDayNum {
            //  If the next exercise day is later in the same week, just subtract the next day's number value from the
            //      current days number value.
            daySpan = nextDayNum - currentDayNum
        } else {
            daySpan = 7 - (currentDayNum - nextDayNum)
        }
        return Date.init(timeInterval: 86400 * Double(daySpan), since: date)
    }
    
    func adjustEquipIndexByAge(index: Int) -> Int {
        //  Helper function for addWeightRegimens... used to create an index of the central priority equipment to use.
        //  INPUT:  The base index for the equipment that the user should start with (older, less experienced
        //      individuals use machine or cable, at indices 1 and 2, while younger and more experienced
        //      individuals use barbells or dumbbells at indices 3 and 4).
        //  OUTPUT:  The index that has been adjusted by age.
        //  NOTES:  Index is for the equipment array of [ "Body", "Machine", "Cable", "Barbell", "Dumbbell" ]
        let age = Int(DBManager.shared.user!.age)
        var newIndex = index
        if age > 40 {
            newIndex -= 1
        }
        if age > 60 {
            newIndex -= 1
        }
        if newIndex > 4 {
            newIndex = 4
        }
        if newIndex < 0 {
            newIndex = 0
        }
        return newIndex
    }
    
    func equipmentPriority(baseIndex: Int, expLevel: String) -> [String] {
        //  Returns an array of equipment names that prioritizes what is ideal for the user first.
        //  INPUT:  The baseIndex of what equipment that is ideal, and the expLevel of Beginner, Intermediate,
        //      Advanced, or Elite.
        //  OUTPUT:  A re-sorted array, prioritizing the equipent closes to the user's ideal equipment type.
        var index = baseIndex
        var equipment = [ "Body", "Machine", "Cable", "Barbell", "Dumbbell" ]
        var arr : [String] = []
        while equipment.count != 0 {
            if index == 0 {
                // append equipment to arr
                arr += equipment
                break
            }
            if index == equipment.count - 1 {
                arr += Array<String>(equipment.reversed())
                break
            }
            arr.append(equipment[index])
            equipment.remove(at: index)
            if determineIntensity(expLevel: expLevel) == "low" {
                if arr.count % 2 == 1 {
                    index -= 1  // Hedge towards safer options
                }
            } else {
                if arr.count % 2 == 0 {
                    index -= 1  // Hedge towards safer options
                }
            }
        }
        return arr
    }
    
    func determineIntensity(expLevel: String) -> String {
        //  Returns "high" or "low", determining if the user should hedge towards more challenging equipment
        //      when arranging equipment priority.
        let age = Int(DBManager.shared.user!.age)
        if (expLevel == "Intermediate" && age < 40) || (expLevel == "Advanced" && age < 50) || (expLevel == "Elite" && age < 60) {
            return "high"
        }
        return "low"
    }
    
    func filterExercisesByTarget(exercises: [WeightExercise], target: String) -> [WeightExercise] {
        //  Filters an array of WeightExercises by the target name, return the filtered exercises
        var arr : [WeightExercise] = []
        for exercise in exercises {
            let category = exercise.exerciseCategory!
            if let muscTargets = category.targets as? Set<MuscleGroup> {
                for muscTarget in muscTargets {
                    if muscTarget.name! == target {
                        arr.append(exercise)
                        break
                    }
                }
            }
        }
        return arr
    }
    
    func filterExercisesByPOF(exercises: [WeightExercise], pof: String) -> [WeightExercise] {
        //  Filters an array of WeightExercises by the position of flexion for the target, return the filtered exercises
        //  NOTE:  Remember that for a WeightExercise the position is represented by a string that contains all the positions
        //      of flexion.  Hence the position attribute may contain "Power/Stretch/Contracted", hence necessitating the use of
        //      the "contains" function.
        var arr : [WeightExercise] = []
        for exercise in exercises {
            let category = exercise.exerciseCategory!
            let positionsOfFlexion = category.position!
            if positionsOfFlexion.contains(pof) {
                //  If the POFs for the exercise contain the string of a particular POF, append this exercise to the list.
                arr.append(exercise)
            }
        }
        return arr
    }
    
    func idealWeightExercise(exercises: [WeightExercise], equipment: [String], setType: String) -> WeightExercise? {
        //  setType = S for Standard, P for Pyramid, R for Reverse Pyramid.
        //  Returns the ideal exercise given a set of exercises and a list of equipment in order of priority.
        //  FIX - REMEMBER:  Pyramid sets (normal or Reverse) should prioritize cable or machine above all else.
        for equip in equipment {
            for exercise in exercises {
                if exercise.uses == equip {
                    return exercise
                }
            }
        }
        return nil
    }
    
    func removeExerciseFromList(exerciseList: [WeightExercise], remove: WeightExercise) -> [WeightExercise] {
        //  Returns a list of WeightExercises with one given WeightExercise removed.
        var list = exerciseList
        var index = 0
        while index < exerciseList.count {
            if list[index] == remove {
                list.remove(at: index)
                break
            }
            index += 1
        }
        return list
    }
    
    func idealCardioExercise() -> CardioExercise {
        var exerciseName = ""
        var cardio : CardioExercise = CardioExercise(context: context)
        if DBManager.shared.user!.age > 40 {
            exerciseName = "Elliptical"
        } else {
            exerciseName = "Treadmill"
        }
        for exercise in cardioExercises {
            if exercise.name == exerciseName {
                cardio = exercise
                break
            }
        }
        return cardio
    }
    
    
    
    ////////
    //
    //  TEST / TROUBLESHOOTING FUNCTIONS
    //
    ////////
    
    func test() {
        //        let str = "Pectoralis – Mid"
        //        print("Pectoralis - Mid".elementsEqual("Pectoralis – Mid"))
        //        for mgGroup in muscleGroups {
        //            if mgGroup.name! == str {
        //                print(mgGroup)
        //            }
        //        }
        // lets you retrieve exercises for a given muscle group
        let group = muscleGroups[2]
        print("MUSCLE GROUP: " + group.name!)
        print("EXERCISE CATEGORIES THAT TARGET THIS MUSCLE GROUP: ")
        if let exercises = group.targetExerciseCats as? Set<ExerciseCategory> {
            for exercise in exercises {
                print(exercise.name!)
            }
        }
        print("WEIGHT EXERCISES THAT SYNERGIZE WITH THIS MUSCLE GROUP: ")
        if let exercises = group.synExercise as? Set<WeightExercise> {
            for exercise in exercises {
                print(exercise.name!)
            }
        }
        print("/////")
        let weightEx = weightExercises[20]
        print("NUMBER OF WEIGHT EXERCISES: ")
        print(weightExercises.count)
        print("-->EXERCISE: " + weightEx.name!)
        print("-->STABILIZERS: ")
        if let groups = weightEx.stabilizers as? Set<MuscleGroup> {
            for group in groups {
                print(group.name!)
            }
        }
        print("Exercise Category: " + weightEx.exerciseCategory!.name!)
        
        let cardioEx = cardioExercises[5]
        print(cardioEx.name!)
        print(cardioEx.desc!)
    }
    
    func printFitnessPlanDays(fitnessPlan: FitnessPlan) {
        print("FITNESS PLAN NAME: " + fitnessPlan.name!)
        if let dayPlans = fitnessPlan.dayPlans as? Set<DayPlan> {
            for day in dayPlans {
                print("---DAY SEQUENCE:  " + String(day.sequence))
                print("---DAY NAME: " + day.name!)
                if let muscles = day.muscleGroups as? Set<MuscleGroup> {
                    for muscle in muscles {
                        print("------MUSCLE GROUP:  " + muscle.name!)
                    }
                }
            }
        }
    }
    
    func printFitnessPlanExercises(fitnessPlan: FitnessPlan) {
        print("FITNESS PLAN NAME: " + fitnessPlan.name!)
        if let dayPlans = fitnessPlan.dayPlans as? Set<DayPlan> {
            for day in dayPlans {
                print("---DAY SEQUENCE:  " + String(day.sequence))
                print("---DAY NAME: " + day.name!)
                if let regimens = day.weightRegimens as? Set<WeightRegimen> {
                    for regimen in regimens {
                        let exercise = regimen.weightExercise!
                        print("------EXERCISE:  " + exercise.name!)
                        if let sets = regimen.weightSets as? Set<WeightSet> {
                            var str = ""
                            for set in sets {
                                str += "/" + String(set.repsGoal)
                            }
                            print("------SETS:  " + str)
                        }
                    }
                }
                if let cardios = day.cardioRegimens as? Set<CardioRegimen> {
                    for cardio in cardios {
                        let cardioEx = cardio.cardioExercise!
                        print("------EXERCISE:  " + cardioEx.name!)
                    }
                }
            }
        }
        print("TOTAL CARDIO:  " + String(fitnessPlan.totalCardio))
    }
    
    func printFitnessPlanMainType(fitnessPlan: FitnessPlan) {
        print(fitnessPlan.mainSetFormat!)
    }
    
    func printFitnessPlanAuxType(fitnessPlan: FitnessPlan) {
        print(fitnessPlan.auxSetFormat!)
    }

    
}


