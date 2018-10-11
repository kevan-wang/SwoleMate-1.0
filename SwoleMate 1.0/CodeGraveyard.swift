/*

// From ProfileVC:

extension ProfileVC: OptionsVCDelegate {
    func metricReset() {
        if DBManager.shared.options!.metricPref {
            //  Reset the labels from imperial units to metric
            heightLabel1.text = "cm"
            heightLabel2.text = ""
            weightLabel.text = "kgs"
            
            //  Convert existing values in the fields from imperial to metric
            var heightCm: Double = 0.0
            if let heightVal1 = Double(heightField1.text!) {
                heightCm += heightVal1 * 12 * 2.54
            }
            if let heightVal2 = Double(heightField2.text!) {
                heightCm += heightVal2 * 2.54
            }
            var weightKg: Double = 0.0
            if let weight = Double(weightField.text!) {
                weightKg += weight / 2.2
                weightKg = round(weightKg * 10)
                weightKg /= 10
            }
            
            // Fill the fields with the appropriate metric values.
            heightField1.text = String(Int(heightCm))
            heightField2.text = ""
            weightField.text = String(weightKg)
            
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
            var heightIn: Double = 0.0
            if let heightVal1 = Double(heightField1.text!) {
                heightIn = heightVal1 / 2.54
            }
            var weightLb: Double = 0.0
            if let weight = Double(weightField.text!) {
                weightLb = weight * 2.2
                weightLb = round(weightLb * 10)
                weightLb /= 10
            }
            
            // Fill the fields with the appropriate metric values.
            heightField1.text = String(Int(round(heightIn) / 12))
            heightField2.text = String(Int(round(heightIn)) % 12)
            weightField.text = String(weightLb)
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
 
 
 // from DBManager, the test function was used for debugging the initializer functions.
 
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

 */
