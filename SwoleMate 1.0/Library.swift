//
//  Library.swift
//  SwoleMate 1.0
//
//  Created by Kevan Wang on 8/12/18.
//  Copyright © 2018 Kevan Wang. All rights reserved.
//

//  For SwoleMate 2.0 : Organize these Library elements under a singleton, to keep all these things from being listed as globals.

//  SWOLETIP library

let stLibrary = [
    "Supplement:  ZMA (a blend of zinc, magnesium, and vitamin B6) may help with vitamin deficiencies, but its effectiveness with muscle gains is unclear.  If you choose to use it, take it on right before bed.",
    "Supplement:  Melatonin is a safe, natural sleep aid that helps synchronize your sleep cycles and provides deeper, more restful sleep!  Take it about half an hour before bed!",
    "Supplement:  BCAAs (Branched Chain Amino Acids) aid in muscle recovery and help prevent muscle breakdown!  Take about 3-5 mg both before and after your workout!",
    "Supplement:  Creatine phosphate helps improve power, stamina, and recovery!  Try 5 grams a day dissolved in your morning tea or coffee!",
    "Supplement:  Whey protein is an essential for muscle building, since it is rapidly absorbed and speeds muscle recovery!  Take a scoop dissolved in water ASAP after your workout!",
    "Supplements like Creatine Phosphate and BCAAs don't dissolve easily in cold water.  Either mix them into hot drinks or buy them in capsule form!",
    "Form:  Remember that good form is crucial!  Lowering the weights to get good form is always better than pumping heavy with bad form!",
    "Form:  Never lock your joints!  Not only does this interrupt the Time Under Tension for your muscles, it places strain on your joints which can cause injury!",
    "Form:  Let the weights come to a rest as little as possible between reps.  You'll want to keep your muscles under constant tension throughout a set!",
    "Form:  Your muscle gets more of a workout with a gradual release on the eccentric portion of your rep.  That is, when you're releasing the weight back down to its starting position.  Let the weights down slowly as you finish for better gains!",
    "Fitness is about nutrition and recovery every bit as much as it's about exercise!  Remember to eat healthy and sleep well!",
    "There is such a thing as too much protein!  Excess protein can't be absorbed by the human body and is excreted instead.  Taking more than 15 grams of whey protein every 90 minutes is just wasteful!",
    "Not all whey protein brands are the same!  A lot are made with cheap filler materials or low quality protein.  A little research will help keep you from getting fooled!",
    "While traditionally we were taught to stretch before exercising, static stretching actually decreases performance and increases risk of injury!  Do light warmup exercises or dynamic stretches instead!",
    "As nice as it would be to relax with a brew after a workout, even small amounts of alcohol has been shown to inhibit protein synthesis and hurts your muscle recovery.  Stay away from the booze if you wanna keep your gains!",
    "Your Swolemate respects people of all shapes and sizes!  Plus-size weightlifters or slim runners are just as legit as your stereotypical gym bunny.  So long as you're happy and healthy, Swolemate is here to support you!",
    "Marathon runners with intense regimens can suffer from cardiac fibrosis, where healthy heart tissue is replaced with unhealthy scar tissue.  For this reason, SwoleMate recommends modest High Intensity Interval Training when doing cardio, which avoids this problem!",
    "REMINDER:  Be sure to update your profile on the reg, preferably once a week to account for changes in age, height, or weight!"
]


//  DESCRIPTION LABELS

let setTypeLabelText = [
    // Used in NewPlan3VC & NewPlan4VC
    "Standard sets (AKA straight sets) use a standard number of reps for each set.  Useful in a wide variety of applications from strength training to endurance to general fitness.",
    "Pyramid sets start off light/high-rep and increase the weight while decreasing the number of reps with each progressive set.  Warm-up sets are built in to ease you into it!",
    "Reverse Pyramid sets start off heavy/low-rep and decrease the weight while increasing the rep count with each set.  Cool-down sets are built-in which help with muscle recovery!"
]


//  MUSCLE GROUP LIBRARY

let mgLibrary = [
    // region, subregion, name
    [ "Upper Body", "Flexor", "Upper Pectoralis" ],
    [ "Upper Body", "Flexor", "Mid Pectoralis" ],
    [ "Upper Body", "Flexor", "Biceps" ],
    [ "Upper Body", "Flexor", "Forearms" ],
    [ "Upper Body", "Extensor", "Latissimus Dorsi" ],
    [ "Upper Body", "Extensor", "Trapezius" ],
    [ "Upper Body", "Extensor", "Triceps" ],
    [ "Upper Body", "Shoulder", "Deltoids" ],
    [ "Core", "Abdominal", "Rectus Abdominis" ],
    [ "Core", "Abdominal", "Obliques" ],
    [ "Core", "Lower Back", "Erector Spinae" ],
    [ "Lower Body", "Flexor", "Hamstrings" ],
    [ "Lower Body", "Flexor", "Gluteus" ],
    [ "Lower Body", "Extensor", "Quadriceps" ],
    [ "Lower Body", "Extensor", "Calves" ],
    [ "Lower Body", "Extensor", "Hip Adductors" ],
    [ "Lower Body", "Extensor", "Hip Abductors" ]
]


//  EXERCISE CATEGORY LIBRARY

let exCatLibrary = [
    // name, target, force, mechanics, position, utility
    
    ["Push-Up", "Mid Pectoralis", "Push", "Compound", "Power", "Basic"],
    ["Bench Press", "Mid Pectoralis", "Push", "Compound", "Power", "Basic"],
    ["Chest Fly", "Mid Pectoralis", "Push", "Isolated", "Stretch/Contracted", "Auxiliary"],
    ["Incline Bench Press", "Upper Pectoralis", "Push", "Compound", "Power", "Basic"],
    ["Incline Chest Fly", "Upper Pectoralis", "Push", "Isolated", "Stretch/Contracted", "Auxiliary"],
    ["Chin-Up", "Biceps", "Pull", "Compound", "Power", "Basic"],
    ["Bicep Curl", "Biceps", "Pull", "Isolated", "Power", "Basic"],
    ["Incline Bicep Curl", "Biceps", "Pull", "Isolated", "Stretch", "Auxiliary"],
    ["Concentration Curl", "Biceps", "Pull", "Isolated", "Contracted", "Auxiliary"],
    ["Row", "Trapezius/Latissimus Dorsi", "Pull", "Compound", "Power", "Basic"],
    ["Shrug", "Trapezius", "Pull", "Isolated", "Stretch/Contracted", "Auxiliary"],
    ["Pull-ups", "Latissimus Dorsi", "Pull", "Compound", "Power", "Basic"],
    ["Pullover", "Latissimus Dorsi", "Pull", "Isolated", "Stretch", "Auxiliary"],
    ["Stiff-Arm Pulldown", "Latissimus Dorsi", "Pull", "Isolated", "Contracted", "Auxiliary"],
    ["Tricep Extension", "Triceps", "Push", "Isolated", "Power", "Basic"],
    ["High Incline Tricep Extension", "Triceps", "Push", "Isolated", "Stretch", "Auxiliary"],
    ["Dumbbell Kickback", "Triceps", "Push", "Isolated", "Contracted", "Auxiliary"],
    ["Shoulder Press", "Deltoids", "Push", "Compound", "Power", "Basic"],
    ["Upright Row", "Deltoids", "Pull", "Compound", "Power", "Basic"],
    ["Leaning Lateral Raise", "Deltoids", "Pull", "Isolated", "Stretch", "Auxiliary"],
    ["Partial Lateral Raise", "Deltoids", "Pull", "Isolated", "Contracted", "Auxiliary"],
    ["Deadlift", "Erector Spinae/Hamstrings/Gluteus", "Pull", "Compound", "Power/Stretch", "Basic"],
    ["Back Extension", "Erector Spinae", "Pull", "Isolated", "Stretch/Contracted", "Auxiliary"],
    ["Squat", "Quadriceps/Gluteus", "Push", "Compound", "Power", "Basic"],
    ["Leg Press", "Quadriceps/Gluteus", "Push", "Compound", "Power", "Basic"],
    ["Sissy Squat", "Quadriceps", "Push", "Isolated", "Stretch", "Auxiliary"],
    ["Leg Extension", "Quadriceps", "Push", "Isolated", "Contracted", "Auxiliary"],
    ["Leg Curls", "Hamstrings", "Pull", "Isolated", "Contracted", "Basic"],
    ["Standing Calf Raise", "Calves", "Push", "Isolated", "Power/Stretch/Contracted", "Basic"],
    ["Hip Adduction", "Hip Adductors", "Pull", "Isolated", "Power", "Auxiliary"],
    ["Hip Abduction", "Hip Abductors", "Push", "Isolated", "Power", "Auxiliary"],
    ["Crunch", "Rectus Abdominis", "Pull", "Isolated", "Power", "Basic"],
    ["Incline Crunch", "Rectus Abdominis", "Pull", "Isolated", "Power", "Basic"],
    ["Twist Crunch", "Obliques", "Pull", "Isolated", "Power", "Basic"],
    ["Incline Twist Crunch", "Obliques", "Pull", "Isolated", "Power", "Basic"]
]


//  WEIGHT EXERCISE LIBRARY

let weightExLibrary = [
    // category, name, synergists, stabilizers, uses, description
    
    ["Push-Up", "Push-Up", "Deltoids/Triceps", "Biceps/Rectus Abdominis/Obliques/Quadriceps/Erector Spinae", "Body", "<empty>"],
    ["Bench Press", "Flat Dumbbell Bench Press", "Deltoids/Triceps", "Biceps", "Dumbbell", "<empty>"],
    ["Bench Press", "Flat Barbell Bench Press", "Deltoids/Triceps", "Biceps", "Barbell", "<empty>"],
    ["Bench Press", "Cable Bench Press", "Deltoids/Triceps", "Biceps", "Cable", "<empty>"],
    ["Bench Press", "Machine Bench Press", "Deltoids/Triceps", "Biceps", "Machine", "<empty>"],
    ["Chest Fly", "Dumbbell Chest Fly", "Deltoids/Biceps", "Biceps/Triceps", "Dumbbell", "<empty>"],
    ["Chest Fly", "Cable Chest Fly", "Deltoids/Biceps", "Biceps/Triceps", "Cable", "<empty>"],
    ["Chest Fly", "Machine Chest Fly", "Deltoids/Biceps", "Biceps/Triceps", "Machine", "<empty>"],
    ["Incline Bench Press", "Incline Dumbbell Bench Press", "Deltoids/Triceps", "Biceps", "Dumbbell", "<empty>"],
    ["Incline Bench Press", "Incline Barbell Bench Press", "Deltoids/Triceps", "Biceps", "Barbell", "<empty>"],
    ["Incline Bench Press", "Incline Cable Bench Press", "Deltoids/Triceps", "Biceps", "Cable", "<empty>"],
    ["Incline Bench Press", "Incline Machine Bench Press", "Deltoids/Triceps", "Biceps", "Machine", "<empty>"],
    ["Incline Chest Fly", "Incline Dumbbell Fly", "Deltoids/Biceps", "Biceps/Triceps", "Dumbbell", "<empty>"],
    ["Incline Chest Fly", "Incline Cable Fly", "Deltoids/Biceps", "Biceps/Triceps", "Cable", "<empty>"],
    ["Chin-Up", "Underhanded Chin-Up", "Latissimus Dorsi/Deltoids/Trapezius/Mid Pectoralis", "Triceps", "Body", "<empty>"],
    ["Chin-Up", "Assisted Underhanded Chin-Up", "Latissimus Dorsi/Deltoids/Trapezius/Mid Pectoralis", "Triceps", "Body", "<empty>"],
    ["Chin-Up", "Seated Cable Chin-Up", "Latissimus Dorsi/Deltoids/Trapezius/Mid Pectoralis", "Triceps", "Cable", "<empty>"],
    ["Bicep Curl", "Dumbbell Bicep Curl", "Forearms", "Deltoids/Trapezius/Forearms", "Dumbbell", "<empty>"],
    ["Bicep Curl", "Barbell Bicep Curl", "Forearms", "Deltoids/Trapezius/Forearms", "Barbell", "<empty>"],
    ["Bicep Curl", "Cable Bicep Curl", "Forearms", "Deltoids/Trapezius/Forearms", "Cable", "<empty>"],
    ["Bicep Curl", "Machine Bicep Curl", "Forearms", "Deltoids/Trapezius/Forearms", "Machine", "<empty>"],
    ["Incline Bicep Curl", "Incline Dumbbell Curl", "", "Deltoids/Forearms", "Dumbbell", "<empty>"],
    ["Concentration Curl", "Dumbbell Concentration Curls", "Forearms", "Trapezius/Erector Spinae", "Dumbbell", "<empty>"],
    ["Concentration Curl", "Cable Concentration Curls", "Forearms", "Trapezius/Erector Spinae", "Cable", "<empty>"],
    ["Row", "Dumbbell Bent-Over Row", "Deltoids/Mid Pectoralis/Forearms", "Biceps/Triceps", "Dumbbell", "<empty>"],
    ["Row", "Barbell Bent-Over Row", "Deltoids/Mid Pectoralis/Forearms", "Erector Spinae/Biceps/Triceps/Hamstrings/Gluteus/Quadriceps/Hip Adductors", "Barbell", "<empty>"],
    ["Row", "Seated Cable Row", "Deltoids/Mid Pectoralis/Forearms", "Erector Spinae/Biceps/Triceps/Hamstrings/Gluteus/Hip Adductors", "Cable", "<empty>"],
    ["Shrug", "Dumbbell Shrugs", "", "Erector Spinae", "Dumbbell", "<empty>"],
    ["Shrug", "Barbell Shrugs", "", "Erector Spinae", "Barbell", "<empty>"],
    ["Shrug", "Cable Shrugs", "", "Erector Spinae", "Cable", "<empty>"],
    ["Shrug", "Machine Shrugs", "", "Erector Spinae", "Machine", "<empty>"],
    ["Pull-ups", "Pull-Up", "Biceps/Deltoids/Trapezius/Forearms", "Triceps", "Body", "<empty>"],
    ["Pull-ups", "Assisted Pull-Up", "Biceps/Deltoids/Trapezius/Forearms", "Triceps", "Body", "<empty>"],
    ["Pull-ups", "Front Cable Pulldowns", "Biceps/Deltoids/Trapezius/Forearms", "Triceps", "Cable", "<empty>"],
    ["Pullover", "Dumbbell Pullover", "Mid Pectoralis/Triceps/Deltoids", "Triceps/Deltoids/Mid Pectoralis/Forearms", "Dumbbell", "<empty>"],
    ["Pullover", "Barbell Pullover", "Mid Pectoralis/Triceps/Deltoids", "Triceps/Deltoids/Mid Pectoralis/Forearms", "Barbell", "<empty>"],
    ["Pullover", "Cable Pullover", "Mid Pectoralis/Triceps/Deltoids", "Triceps/Deltoids/Mid Pectoralis/Forearms", "Machine", "<empty>"],
    ["Stiff-Arm Pulldown", "Stiff-Arm Pulldown", "", "Triceps/Rectus Abdominis/Forearms", "Cable", "<empty>"],
    ["Tricep Extension", "Lying Dumbbell Tricep Extension", "", "Deltoids/Mid Pectoralis/Latissimus Dorsi/Forearms", "Dumbbell", "<empty>"],
    ["Tricep Extension", "Lying Barbell Tricep Extension", "", "Deltoids/Mid Pectoralis/Latissimus Dorsi/Forearms", "Barbell", "<empty>"],
    ["Tricep Extension", "Lying Cable Tricep Extension", "", "Deltoids/Mid Pectoralis/Latissimus Dorsi/Forearms", "Cable", "<empty>"],
    ["Tricep Extension", "Machine Tricep Extension", "", "Deltoids/Mid Pectoralis/Latissimus Dorsi/Forearms", "Machine", "<empty>"],
    ["High Incline Tricep Extension", "High Incline Dumbbell Tricep Extension", "", "Deltoids/Mid Pectoralis/Latissimus Dorsi/Forearms", "Dumbbell", "*Use a high incline, almost vertical"],
    ["High Incline Tricep Extension", "High Incline Barbell Tricep Extension", "", "Deltoids/Mid Pectoralis/Latissimus Dorsi/Forearms", "Barbell", "*Use a high incline, almost vertical"],
    ["High Incline Tricep Extension", "High Incline Tricep Rope Extension", "", "Deltoids/Mid Pectoralis/Latissimus Dorsi/Forearms", "Cable", "*Use a high incline, almost vertical"],
    ["High Incline Tricep Extension", "High Incline Machine Tricep Extension", "", "Deltoids/Mid Pectoralis/Latissimus Dorsi/Forearms", "Machine", "*Use a high incline, almost vertical"],
    ["Dumbbell Kickback", "Dumbbell Kickbacks", "", "Deltoids/Latissimus Dorsi/Forearms", "Dumbbell", "<empty>"],
    ["Shoulder Press", "Dumbbell Shoulder Press", "Triceps/Trapezius", "", "Dumbbell", "*Focuses more on anterior deltoid than upright rows"],
    ["Shoulder Press", "Barbell Shoulder Press", "Triceps/Trapezius", "", "Barbell", "*Focuses more on anterior deltoid than upright rows"],
    ["Shoulder Press", "Cable Bar Shoulder Press", "Triceps/Trapezius", "", "Cable", "*Focuses more on anterior deltoid than upright rows"],
    ["Shoulder Press", "Machine Shoulder Press", "Triceps/Trapezius", "", "Machine", "*Focuses more on anterior deltoid than upright rows"],
    ["Upright Row", "Dumbbell Upright Row", "Forearms/Biceps/Trapezius", "", "Dumbbell", "*Focuses more on lateral deltoid than shoulder presses"],
    ["Upright Row", "Barbell Upright Row", "Forearms/Biceps/Trapezius", "", "Barbell", "*Focuses more on lateral deltoid than shoulder presses"],
    ["Upright Row", "Cable Bar Upright Row", "Forearms/Biceps/Trapezius", "", "Cable", "*Focuses more on lateral deltoid than shoulder presses"],
    ["Upright Row", "Machine Upright Row", "Forearms/Biceps/Trapezius", "", "Machine", "*Focuses more on lateral deltoid than shoulder presses"],
    ["Leaning Lateral Raise", "Leaning Dumbbell Lateral Raise", "Trapezius", "Forearms", "Dumbbell", "<empty>"],
    ["Leaning Lateral Raise", "Leaning Cable Lateral Raise", "Trapezius", "Forearms", "Cable", "<empty>"],
    ["Partial Lateral Raise", "Partial Dumbbell Lateral Raise", "Trapezius", "Forearms", "Dumbbell", "<empty>"],
    ["Partial Lateral Raise", "Partial Machine Lateral Raise", "Trapezius", "Forearms", "Machine", "<empty>"],
    ["Deadlift", "Barbell Deadlift", "Quadriceps/Hamstrings/Calves/Hip Adductors", "Hamstrings/Trapezius/Rectus Abdominis/Obliques", "Barbell", "<empty>"],
    ["Deadlift", "Cable Deadlift", "Quadriceps/Hamstrings/Calves/Hip Adductors", "Hamstrings/Trapezius/Rectus Abdominis/Obliques", "Cable", "<empty>"],
    ["Deadlift", "Machine Deadlift", "Quadriceps/Hamstrings/Calves/Hip Adductors", "Trapezius/Rectus Abdominis/Obliques", "Machine", "<empty>"],
    ["Back Extension", "Machine Back Extension", "", "Gluteus/Quadriceps/Hip Adductors/Calves", "Machine", "<empty>"],
    ["Back Extension", "Ball Back Extension", "", "", "Body", "<empty>"],
    ["Squat", "Dumbbell Squat", "Hip Adductors/Calves", "Hamstrings/Erector Spinae/Rectus Abdominis/Obliques/Trapezius/Calves", "Dumbbell", "<empty>"],
    ["Squat", "Barbell Squat", "Hip Adductors/Calves", "Hamstrings/Erector Spinae/Rectus Abdominis/Obliques/Calves", "Barbell", "<empty>"],
    ["Squat", "Cable Squat", "Hip Adductors/Calves", "Hamstrings/Erector Spinae/Rectus Abdominis/Obliques/Calves", "Cable", "<empty>"],
    ["Squat", "Machine Squat", "Hip Adductors/Calves", "Hamstrings/Erector Spinae/Rectus Abdominis/Obliques/Calves", "Machine", "<empty>"],
    ["Leg Press", "Leg Press", "Hip Adductors/Calves", "Hamstrings/Calves", "Machine", "<empty>"],
    ["Sissy Squat", "Sissy Squat", "", "Gluteus/Calves/Rectus Abdominis/Obliques", "Body", "<empty>"],
    ["Leg Extension", "Leg Extension", "", "Trapezius/Forearms/Biceps", "Machine", "<empty>"],
    ["Leg Curls", "Leg Curls", "Calves", "", "Machine", "<empty>"],
    ["Standing Calf Raise", "Standing Calf Raise", "", "Trapezius", "Machine", "*This exercise can be done without a machine.  Stand on a stair or box, and hold onto a rail to stay balanced."],
    ["Hip Adduction", "Cable Hip Adduction", "Gluteus", "", "Cable", "<empty>"],
    ["Hip Adduction", "Machine Hip Adduction", "", "", "Machine", "<empty>"],
    ["Hip Abduction", "Cable Hip Abduction", "Gluteus", "", "Cable", "<empty>"],
    ["Hip Abduction", "Machine Hip Abduction", "Gluteus", "", "Machine", "<empty>"],
    ["Crunch", "Cable Kneeling Crunch", "Obliques", "Mid Pectoralis/Latissimus Dorsi/Deltoids/Trapezius/Triceps", "Cable", "<empty>"],
    ["Crunch", "Seated Machine Crunch", "Obliques", "Mid Pectoralis/Latissimus Dorsi/Deltoids/Triceps", "Machine", "<empty>"],
    ["Crunch", "Crunch", "Obliques", "", "Body", "<empty>"],
    ["Incline Crunch", "Incline Crunch", "Obliques", "", "Body", "<empty>"],
    ["Twist Crunch", "Cable Kneeling Twist Crunch", "Rectus Abdominis", "Mid Pectoralis/Latissimus Dorsi/Deltoids/Trapezius/Triceps", "Cable", "<empty>"],
    ["Twist Crunch", "Twist Crunch", "Rectus Abdominis", "", "Body", "<empty>"],
    ["Incline Twist Crunch", "Incline Twist Crunch", "Rectus Abdominis", "", "Body", "<empty>"]
]

//  CARDIO EXERCISE LIBRARY

let cardioExLibrary = [
    // name, desc
    [ "Treadmill", "While nothing can beat cardio in a natural environment, the treadmill helps more easily track and quantify your performance." ],
    [ "Elliptical", "While the elliptical's effectiveness at giving a good workout is rather limited, its low-impact design is easy on the joints!" ],
    [ "Stair Mill", "Simulates an endless flight of stairs.  Excellent for firefighters or M.C. Escher enthusiasts!" ],
    [ "Spin Bike", "Another classic choice for cardio, the spin bike gives a great leg workout." ],
    [ "Recumbent Bike", "The recumbent bike allows for much of your upper body to be at rest and focuses solely on the legs.  Decent workout for beginners to cardio." ],
    [ "Rowing Machine", "Allows for a full-body cardio workout with a broad range of motion." ],
    [ "Outdoor Run", "A fresh jog through a park or the woods is refreshing both physically and mentally!  Stay safe though!" ],
    [ "Power Walk", "A fresh power walk through a park or the woods is refreshing both physically and mentally!  Stay safe though!" ]
]






//let infoLibrary = [
//    "FrontVC" : ["Welcome to Swolemate!",
//                 "Thanks for choosing Swolemate as your fitness app!  If you ever need assistance, Swolemate's Info button is here for you!\n\nIf you haven't started yet, please fill out your PROFILE!\n\nYou'll also want to set up a new fitness plan in SELECT FITNESS PLAN, where Swolemate will help customize the best workout schedule for your given goals.  Feel free to customize it as you like, and VIEW/EDIT your fitness plan whenever you need to!\n\nWhen you're ready for your workout, CHECK-IN to start your day at the gym!  If you need to skip or delay your workout, CHECK-IN helps with that too!\n\nFinally, check out RECORDS to see your long-term performance!\n\nGood luck with your GAINZ!"
//    ],
//    "ProfileVC" : ["Your Profile!",
//                   "Your profile and physical stats are used to help generate a recommended fitness plan and to track your progress.\n\nWhen it comes to your fitness GOAL, remember:  Muscle Building is about strength and bulk.  Muscle Toning is for those who want better muscular endurance.  General Fitness provides a well-rounded workout plan, and Cardiac Health focuses primarily on cardio work.\n\nWhile Swolemate offers a Weight Loss option, please remember that 90% of weight loss is done through proper dieting.  Exercise, though important, plays only a secondary role in helping to MAINTAIN that weight loss!\n\nGender is used for certain fitness calculations.  However, Swolemate is very aware that as of now there isn't much established data when it comes to fitness planning for those who are transitioning or on hormone replacement therapy.  Your Swolemate will do their best to keep up to date.  For now, select the gender identity that you feel would give you the most accurate results!"
//    ]
//]
