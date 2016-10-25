//
//  ExcercisesViewController.swift
//  Charley's Gym
//
//  Created by IMac on 4/27/15.
//  Copyright (c) 2015 iSync. All rights reserved.
//

import UIKit

class ExcercisesViewController: UIViewController {

    @IBOutlet var nav: UINavigationBar!
    
    var exerArray = [String]()
    
    var exerPicArray = [String]()
    
    var exerPicInArray = [String]()
    
    var exerSubtitleArray = [String]()
    
    var exerType: String = ""
    

    
    
    
    @IBAction func backBtn(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "bar_charlysgym.jpg")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)


    }

    
    
    
     //////////////////////////////////////////////// Chest
    @IBAction func chestPic(sender: AnyObject) {
        
        exerArray.removeAll()
        exerArray = ["Bench press", "Bench Press",
            "Bench press", "bench press",
            "Bench press", "Bench press",
            "Bench press", "Chest Dips",
            "Cross-Bench pullovers","Flyes",
            "Flyes", "Flyes",
            "Flyes","Flyes",
            "Flyes", "Machine chest press",
            "push-ups"]
        
        exerPicArray = ["logo.png", "chest_out_1.png", "chest_out_2.png", "chest_out_3.png", "logo.png", "chest_out_5.png", "chest_out_6.png", "chest_out_7.png", "chest_out_8.png", "logo.png", "chest_out_10.png", "chest_out_11.png", "chest_out_12.png", "chest_out_13.png", "chest_out_14.png", "chest_out_15.png", "chest_out_16.png"]
        
        exerPicInArray = ["logo.png", "chest1.jpg", "chest2.jpg", "chest3.jpg", "logo.png", "chest5.jpg", "chest6.jpg", "chest7.jpg", "chest8.jpg", "logo.png", "chest10.jpg", "chest11.jpg", "chest12.jpg", "chest13.jpg", "chest14.jpg", "chest15.jpg", "chest16.jpg"]
        
        exerSubtitleArray = ["Barbell", "barbell, incline",
            "dumbbell", "Dumbbell , incline",
            "Machine", "smith machine",
            "smith machine, incline", "parallel bars",
            "dumbbell","cable, flat bench",
            "cable,incline", "cable, upright",
            "dumbbellm flat bench","dumbbell,incline",
            "machine, seated", "seated",
            "push-ups"]
        
        
        exerType = "chest/"
        
    }
    @IBOutlet var chestTitle: UIButton!
    @IBAction func chestTitle(sender: AnyObject) {
        
        exerArray.removeAll()
        exerArray = ["Bench press", "Bench Press",
            "Bench press", "bench press",
            "Bench press", "Bench press",
            "Bench press", "Chest Dips",
            "Cross-Bench pullovers","Flyes",
            "Flyes", "Flyes",
            "Flyes","Flyes",
            "Flyes", "Machine chest press",
            "push-ups"]
        
        exerPicArray = ["logo.png", "chest_out_1.png", "chest_out_2.png", "chest_out_3.png", "logo.png", "chest_out_5.png", "chest_out_6.png", "chest_out_7.png", "chest_out_8.png", "logo.png", "chest_out_10.png", "chest_out_11.png", "chest_out_12.png", "chest_out_13.png", "chest_out_14.png", "chest_out_15.png", "chest_out_16.png"]
        
        exerPicInArray = ["logo.png", "chest1.jpg", "chest2.jpg", "chest3.jpg", "logo.png", "chest5.jpg", "chest6.jpg", "chest7.jpg", "chest8.jpg", "logo.png", "chest10.jpg", "chest11.jpg", "chest12.jpg", "chest13.jpg", "chest14.jpg", "chest15.jpg", "chest16.jpg"]
        
        exerSubtitleArray = ["Barbell", "barbell, incline",
            "dumbbell", "Dumbbell , incline",
            "Machine", "smith machine",
            "smith machine, incline", "parallel bars",
            "dumbbell","cable, flat bench",
            "cable,incline", "cable, upright",
            "dumbbellm flat bench","dumbbell,incline",
            "machine, seated", "seated",
            "push-ups"]
        
        exerType = "chest/"
    }
    
    
    
    
    
    
     //////////////////////////////////////////////// Back
    @IBAction func backPic(sender: AnyObject) {
        
        exerArray.removeAll()
        exerArray = ["Bent over row", "Bent over row",
            "Bent over row", "Chin-ups",
            "Chin-ups", "Chin-ups",
            "Chin-ups",
            "Cross-Bench pullovers",
            "Cross-bench pullovers",
            "Lying row",
            "Pulldowns","Row",
            "T-bar row", "T-bar row"]
        
        exerPicArray = ["back_out_0.png","back_out_1.png","back_out_2.png","back_out_3.png","back_out_4.png","logo.png","back_out_6.png","back_out_7.png","back_out_8.png","back_out_9.png","logo.png","back_out_11.png","back_out_12.png","back_out_13.png"]
        
        exerPicInArray = ["back0.jpg","back1.jpg","back2.jpg","back3.jpg","back4.jpg","logo.png","back6.jpg","back7.jpg","back8.jpg","back9.jpg","logo.png","back11.jpg","back12.jpg","back13.jpg"]
        
        exerSubtitleArray = ["barbell", "dumbbell, one-arm",
            "smith machine", "front, close grip",
            "front, wide-grip", "machine",
            "rear,wide grip", "barbell",
            "dumbbell", "dumbbell, two arms",
            "rears","cable",
            "barbell, v-grip","machine, close grip"]
        
        exerType = "back/"
    }
    
    @IBAction func backTitle(sender: AnyObject) {
        
        exerArray.removeAll()
        exerArray = ["Bent over row", "Bent over row",
            "Bent over row", "Chin-ups",
            "Chin-ups", "Chin-ups",
            "Chin-ups",
            "Cross-Bench pullovers",
            "Cross-bench pullovers",
            "Lying row",
            "Pulldowns","Row",
            "T-bar row", "T-bar row"]
        
        exerPicArray = ["back_out_0.png","back_out_1.png","back_out_2.png","back_out_3.png","back_out_4.png","logo.png","back_out_6.png","back_out_7.png","back_out_8.png","back_out_9.png","logo.png","back_out_11.png","back_out_12.png","back_out_13.png"]
        
        exerPicInArray = ["back0.jpg","back1.jpg","back2.jpg","back3.jpg","back4.jpg","logo.png","back6.jpg","back7.jpg","back8.jpg","back9.jpg","logo.png","back11.jpg","back12.jpg","back13.jpg"]
        
        exerSubtitleArray = ["barbell", "dumbbell, one-arm",
            "smith machine", "front, close grip",
            "front, wide-grip", "machine",
            "rear,wide grip", "barbell",
            "dumbbell", "dumbbell, two arms",
            "rears","cable",
            "barbell, v-grip","machine, close grip"]
        
        exerType = "back/"
    }
    

    
    
    
    
    
    
     //////////////////////////////////////////////// triceps
    @IBOutlet var tricepsPic: UIButton!
    
    @IBAction func tricepsPic(sender: AnyObject) {
        
        exerArray.removeAll()
        exerArray = ["Cable pushdowns",
            "Cable pushdowns",
            "Cable pushdowns",
            "Close-grip bench press",
            "Push-ups",
            "Seated narrow",
            "Triceps dips",
            "Triceps dips",
            "Triceps dips",
            "Triceps extensions",
            "Triceps extensions",
            "Triceps extensions",
            "Triceps extensions",
            "Triceps extensions",
            "Triceps extensions",
            "Triceps kickbacks"]
        
        
        exerPicArray = ["triceps_out_0.png","triceps_out_1.png","triceps_out_2.png","triceps_out_3.png","triceps_out_4.png","logo.png","triceps_out_6.png","triceps_out_7.png","triceps_out_8.png","logo.png","triceps_out_10.png","logo.png","logo.png","triceps_out_13.png","triceps_out_14.png","triceps_out_15.png"]
        
        exerPicInArray = ["triceps0.jpg","triceps1.jpg","triceps2.jpg","triceps3.jpg","triceps4.jpg","logo.png","triceps6.jpg","triceps7.jpg","triceps8.jpg","logo.png","triceps10.jpg","logo.png","logo.png","triceps13.jpg","triceps14.jpg","triceps15.jpg"]
        
        exerSubtitleArray = ["", "one arm",
            "rope", "barbell",
            "", "grip press",
            "assisted", "machine",
            "parallel bars", "barbell",
            "barbell, lying","cable, bent-over",
            "cable, lying","dumbbell",
            "dumbbell, one-arm", "dumbbell"]
        
        exerType = "triceps/"
        
        
    }
    
    
    @IBAction func tricepsText(sender: AnyObject) {
        exerArray.removeAll()
        exerArray = ["Cable pushdowns",
            "Cable pushdowns",
            "Cable pushdowns",
            "Close-grip bench press",
            "Push-ups",
            "Seated narrow",
            "Triceps dips",
            "Triceps dips",
            "Triceps dips",
            "Triceps extensions",
            "Triceps extensions",
            "Triceps extensions",
            "Triceps extensions",
            "Triceps extensions",
            "Triceps extensions",
            "Triceps kickbacks"]
        
        exerPicArray = ["triceps_out_0.png","triceps_out_1.png","triceps_out_2.png","triceps_out_3.png","triceps_out_4.png","logo.png","triceps_out_6.png","triceps_out_7.png","triceps_out_8.png","logo.png","triceps_out_10.png","logo.png","logo.png","triceps_out_13.png","triceps_out_14.png","triceps_out_15.png"]
        
        exerPicInArray = ["triceps0.jpg","triceps1.jpg","triceps2.jpg","triceps3.jpg","triceps4.jpg","logo.png","triceps6.jpg","triceps7.jpg","triceps8.jpg","logo.png","triceps10.jpg","logo.png","logo.png","triceps13.jpg","triceps14.jpg","triceps15.jpg"]
        
        exerSubtitleArray = ["", "one arm",
            "rope", "barbell",
            "", "grip press",
            "assisted", "machine",
            "parallel bars", "barbell",
            "barbell, lying","cable, bent-over",
            "cable, lying","dumbbell",
            "dumbbell, one-arm", "dumbbell"]
        
        
        exerType = "triceps/"
    }
    
    
    
    
    
    
    //////////////////////////////////////////////// Biceps
    @IBAction func bicepsPic(sender: AnyObject) {
        exerArray.removeAll()
        exerArray = ["Arms curls", "Arm curls",
            "Arm curls", "Arm curls",
            "Arm curls", "Arm curls",
            "Arm curls",
            "Concentration curls",
            "Preacher Curls"]
        
        exerPicArray = ["biceps_out_0.png","logo.png","biceps_out_2.png","biceps_out_3.png","biceps_out_4.png","biceps_out_5.png","biceps_out_6.png","biceps_out_7.png","biceps_out_8.png"]
        
        exerPicInArray = ["biceps0.jpg","logo.png","biceps2.jpg","biceps3.jpg","biceps4.jpg","biceps5.jpg","biceps6.jpg","biceps7.jpg","biceps8.jpg"]
        
        exerSubtitleArray = ["barbell", "cable",
            "cable, one arm", "dumbbell, incline",
            "dumbbell, seated", "dumbbell, standing",
            "machine", "",
            "barbell"]
        
        
        exerType = "biceps/"
    }
    
    
    @IBAction func bicepsText(sender: AnyObject) {
        exerArray.removeAll()
        exerArray = ["Arms curls", "Arm curls",
            "Arm curls", "Arm curls",
            "Arm curls", "Arm curls",
            "Arm curls",
            "Concentration curls",
            "Preacher Curls"]
        
        exerPicArray = ["biceps_out_0.png","logo.png","biceps_out_2.png","biceps_out_3.png","biceps_out_4.png","biceps_out_5.png","biceps_out_6.png","biceps_out_7.png","biceps_out_8.png"]
        
        exerPicInArray = ["biceps0.jpg","logo.png","biceps2.jpg","biceps3.jpg","biceps4.jpg","biceps5.jpg","biceps6.jpg","biceps7.jpg","biceps8.jpg"]
        
        exerSubtitleArray = ["barbell", "cable",
            "cable, one arm", "dumbbell, incline",
            "dumbbell, seated", "dumbbell, standing",
            "machine", "",
            "barbell"]
        
        exerType = "biceps/"
    }
    
    
    
    
     //////////////////////////////////////////////// Shoulders
    
    @IBAction func shouldersPic(sender: AnyObject) {
        
        exerArray.removeAll()
        exerArray = ["Arnold press",
            "Behind the neck press",
            "Behind the neck press",
            "Front raises",
            "Front raises",
            "Front raises",
            "Shoulder press",
            "Shoulder press",
            "Shoulder press",
            "Lateral raises",
            "Lateral raises",
            "Upright rows",
            "Bent over raises",
            "Bent over raises",
            "Bent over raises",
            "Bent over raises",
            "Machine seated",
            "Rear delt row",
            "Shoulder press",
            "Shoulder press",
            "Shrugs",
            "Shrugs",
            "Shrugs"]
        
        exerPicArray.removeAll()
        exerPicArray = ["logo.png","shoulders_out_1.png","shoulders_out_2.png","shoulders_out_3.png","shoulders_out_4.png","shoulders_out_5.png","shoulders_out_6.png","shoulders_out_7.png","logo.png","shoulders_out_9.png","shoulders_out_10.png","shoulders_out_11.png","logo.png","logo.png","logo.png","logo.png","logo.png","shoulders_out_17.png","shoulders_out_18.png","logo.png","shoulders_out_20.png","logo.png","shoulders_out_22.png"]
        
        exerPicInArray.removeAll()
        exerPicInArray = ["logo.png","shoulders1.jpg","shoulders2.jpg","shoulders3.jpg","shoulders4.jpg","shoulders5.jpg","shoulders6.jpg","shoulders7.jpg","logo.png","shoulders9.jpg","shoulders10.jpg","shoulders11.jpg","logo.png","logo.png","logo.png","logo.png","logo.png","shoulders17.jpg","shoulders18.jpg","logo.png","shoulders20.jpg","logo.png","shoulders22.jpg"]
        
        exerSubtitleArray.removeAll()
        exerSubtitleArray = ["",
            "barbell",
            "smith machine",
            "barbell",
            "cable", "dumbbell",
            "barbell", "barbell, seated",
            "dumbbell,seated",
            "cable",
            "dumbbell","barbell",
            "cable",
            "cable,one arm",
            "dumbbell",
            "Dumbbell, seated",
            "rear raises",
            "cable",
            "machine",
            "smith machine",
            "barbell",
            "cable", "dumbbell"]
        
        exerType = "shoulders/"
    }
    
    
    @IBAction func shouldersText(sender: AnyObject) {
        
        exerArray.removeAll()
        exerArray = ["Arnold press",
            "Behind the neck press",
            "Behind the neck press",
            "Front raises",
            "Front raises",
            "Front raises",
            "Shoulder press",
            "Shoulder press",
            "Shoulder press",
            "Lateral raises",
            "Lateral raises",
            "Upright rows",
            "Bent over raises",
            "Bent over raises",
            "Bent over raises",
            "Bent over raises",
            "Machine seated",
            "Rear delt row",
            "Shoulder press",
            "Shoulder press",
            "Shrugs",
            "Shrugs",
            "Shrugs"]
        
        exerPicArray = ["logo.png","shoulders_out_1.png","shoulders_out_2.png","shoulders_out_3.png","shoulders_out_4.png","shoulders_out_5.png","shoulders_out_6.png","shoulders_out_7.png","logo.png","shoulders_out_9.png","shoulders_out_10.png","shoulders_out_11.png","logo.png","logo.png","logo.png","logo.png","logo.png","shoulders_out_17.png","shoulders_out_18.png","logo.png","shoulders_out_20.png","logo.png","shoulders_out_22.png"]
        
        exerPicInArray = ["logo.png","shoulders1.jpg","shoulders2.jpg","shoulders3.jpg","shoulders4.jpg","shoulders5.jpg","shoulders6.jpg","shoulders7.jpg","logo.png","shoulders9.jpg","shoulders10.jpg","shoulders11.jpg","logo.png","logo.png","logo.png","logo.png","logo.png","shoulders17.jpg","shoulders18.jpg","logo.png","shoulders20.jpg","logo.png","shoulders22.jpg"]
        
        exerSubtitleArray = ["",
            "barbell",
            "smith machine",
            "barbell",
            "cable", "dumbbell",
            "barbell", "barbell, seated",
            "dumbbell,seated",
            "cable",
            "dumbbell","barbell",
            "cable",
            "cable,one arm",
            "dumbbell",
            "Dumbbell, seated",
            "rear raises",
            "cable",
            "machine",
            "smith machine",
            "barbell",
            "cable", "dumbbell"]
        
        exerType = "shoulders/"
    }
    
    
    
    
    
    
    //////////////////////////////////////////////// Legs
    
    @IBAction func legsPic(sender: AnyObject) {
        exerArray.removeAll()
        exerArray = ["Front squats",
            "Front squats",
            "Full squats",
            "Hack squats",
            "Hack squats",
            "Leg extensions",
            "Lunges",
            "Lunges",
            "Lunges",
            "Rear lunges",
            "Squats",
            "Squats",
            "Squats",
            "Step-up",
            "Deadlifts",
            "Good mornings",
            "Step-up",
            "Stiff leg straight",
            "Straight leg deadlifts",
            "Hip abductions",
            "Hip abductions",
            "Hip abductions",
            "Hip abductions",
            "Hip abductions",
            "Hip abductions",
            "Lying"]
        
        exerPicArray = ["legs_out_0.png","logo.png","logo.png","legs_out_3.png","logo.png","legs_out_5.png","legs_out_6.png","legs_out_7.png","legs_out_8.png","logo.png","legs_out_10.png","legs_out_11.png","legs_out_12.png","legs_out_13.png","legs_out_14.png","logo.png","legs_out_16.png","legs_out_17.png","logo.png","logo.png","logo.png","logo.png","logo.png","logo.png","logo.png","logo.png"]
        
        exerPicInArray = ["legs0.jpg","logo.png","logo.png","legs3.jpg","logo.png","legs5.jpg","legs6.jpg","legs7.jpg","legs8.jpg","logo.png","legs10.jpg","legs11.jpg","legs12.jpg","legs13.jpg","legs14.jpg","logo.png","legs16.jpg","legs17.jpg","logo.png","logo.png","logo.png","logo.png","logo.png","logo.png","logo.png","logo.png"]
        
        exerSubtitleArray = ["",
            "smith machine",
            "",
            "barbell",
            "machine",
            "",
            "barbell",
            "dumbbell","smith machine",
            "barbell",
            "dumbbells",
            "single dumbbell",
            "smith machine",
            "barbell",
            "",
            "",
            "dumbbell",
            "back deadlifts",
            "smith machine",
            "cable","machine,seated",
            "machine, standing",
            "cable","machine, seated",
            "machine, standing","leg curls"]
        
        exerType = "legs/"
        
    }
    
    @IBAction func legsText(sender: AnyObject) {
        
        exerArray.removeAll()
        exerArray = ["Front squats",
            "Front squats",
            "Full squats",
            "Hack squats",
            "Hack squats",
            "Leg extensions",
            "Lunges",
            "Lunges",
            "Lunges",
            "Rear lunges",
            "Squats",
            "Squats",
            "Squats",
            "Step-up",
            "Deadlifts",
            "Good mornings",
            "Step-up",
            "Stiff leg straight",
            "Straight leg deadlifts",
            "Hip abductions",
            "Hip abductions",
            "Hip abductions",
            "Hip abductions",
            "Hip abductions",
            "Hip abductions",
            "Lying"]
        
        exerPicArray = ["legs_out_0.png","logo.png","logo.png","legs_out_3.png","logo.png","legs_out_5.png","legs_out_6.png","legs_out_7.png","legs_out_8.png","logo.png","legs_out_10.png","legs_out_11.png","legs_out_12.png","legs_out_13.png","legs_out_14.png","logo.png","legs_out_16.png","legs_out_17.png","logo.png","logo.png","logo.png","logo.png","logo.png","logo.png","logo.png","logo.png"]
        
        exerPicInArray = ["legs0.jpg","logo.png","logo.png","legs3.jpg","logo.png","legs5.jpg","legs6.jpg","legs7.jpg","legs8.jpg","logo.png","legs10.jpg","legs11.jpg","legs12.jpg","legs13.jpg","legs14.jpg","logo.png","legs16.jpg","legs17.jpg","logo.png","logo.png","logo.png","logo.png","logo.png","logo.png","logo.png","logo.png"]
        
        exerSubtitleArray = ["",
            "smith machine",
            "",
            "barbell",
            "machine",
            "",
            "barbell",
            "dumbbell","smith machine",
            "barbell",
            "dumbbells",
            "single dumbbell",
            "smith machine",
            "barbell",
            "",
            "",
            "dumbbell",
            "back deadlifts",
            "smith machine",
            "cable","machine,seated",
            "machine, standing",
            "cable","machine, seated",
            "machine, standing","leg curls"]
        
        exerType = "legs/"
    }
    
    
    
    
    
    //////////////////////////////////////////////// Calves
    
    
    @IBAction func calvesPic(sender: AnyObject) {
        exerArray.removeAll()
        exerArray = ["Lying calf press", "Standing calf raises",
            "Standing calf raises", "Standing calf raises",
            "Standing calf raises", "Seated calf raises",
            "Seated calf raises"]
        
        exerPicArray = ["logo.png","calves_out_1.png","calves_out_2.png","calves_out_3.png","calves_out_4.png","calves_out_5.png","calves_out_6.png"]
        
        exerPicInArray = ["logo.png","calves1.jpg","calves2.jpg","calves3.jpg","calves4.jpg","calves5.jpg","calves6.jpg"]
        
        exerSubtitleArray = ["", "barbell",
            "dumbbell", "machine",
            "smith machine", "barbell",
            "plate"]
        
        exerType = "calves/"
        
    }
    
    @IBAction func calvesText(sender: AnyObject) {
        
        exerArray.removeAll()
        exerArray = ["Lying calf press", "Standing calf raises",
            "Standing calf raises", "Standing calf raises",
            "Standing calf raises", "Seated calf raises",
            "Seated calf raises"]
        
        exerPicArray = ["logo.png","calves_out_1.png","calves_out_2.png","calves_out_3.png","calves_out_4.png","calves_out_5.png","calves_out_6.png"]
        
        exerPicInArray = ["logo.png","calves1.jpg","calves2.jpg","calves3.jpg","calves4.jpg","calves5.jpg","calves6.jpg"]
        
        exerSubtitleArray = ["", "barbell",
            "dumbbell", "machine",
            "smith machine", "barbell",
            "plate"]
        
        exerType = "calves/"
    }
    
    
    
    
    
    
    //////////////////////////////////////////////// ABS
    
    
    @IBAction func absPic(sender: AnyObject) {
        
        exerArray.removeAll()
        exerArray = ["Bicycle crunches",
            "Cable crunches",
            "Crunches",
            "Crunches",
            "Killer ups",
            "Leg raises",
            "Leg raises",
            "Leg raises",
            "Leg raises",
            "MAchine crunches",
            "Reverse crunches",
            "Side twist",
            "Sit ups",
            "Sit ups",
            "Twisting crunches",
            "Twisting sit up",
            "Twisting sit up",
            "Vertical leg",
            "Russian twists",
            "side bend",
            "Side bends",
            "Side bends",
            "Side bends",
            "Side Crunches"]
        
        exerPicArray = ["abs_out_0.png","logo.png","logo.png","abs_out_3.png","abs_out_4.png","abs_out_5.png","abs_out_6.png","abs_out_7.png","abs_out_8.png","logo.png","abs_out_10.png","abs_out_11.png","logo.png","logo.png","abs_out_14.png","logo.png","logo.png","logo.png","abs_out_18.png","logo.png","logo.png","logo.png","logo.png","logo.png"]
        
        exerPicInArray = ["abs0.jpg","logo.png","logo.png","abs3.jpg","abs4.jpg","abs5.jpg","abs6.jpg","abs7.jpg","abs8.jpg","logo.png","abs10.jpg","abs11.jpg","logo.png","logo.png","abs14.jpg","logo.png","logo.png","logo.png","abs18.jpg","logo.png","logo.png","logo.png","logo.png","logo.png"]
        
        exerSubtitleArray = ["",
            "kneeling",
            "",
            "with legs",
            "",
            "flat",
            "hanging",
            "incline","parallel bar",
            "",
            "",
            "lying",
            "",
            "incline",
            "",
            "",
            "incline",
            "crunches",
            "", "","barbell","cable",
            "dumbbell",""]
        
        exerType = "abs/"
        
    }
    
    
    @IBAction func absText(sender: AnyObject) {
        
        
        exerArray.removeAll()
        exerArray = ["Bicycle crunches",
            "Cable crunches",
            "Crunches",
            "Crunches",
            "Killer ups",
            "Leg raises",
            "Leg raises",
            "Leg raises",
            "Leg raises",
            "MAchine crunches",
            "Reverse crunches",
            "Side twist",
            "Sit ups",
            "Sit ups",
            "Twisting crunches",
            "Twisting sit up",
            "Twisting sit up",
            "Vertical leg",
            "Russian twists",
            "side bend",
            "Side bends",
            "Side bends",
            "Side bends",
            "Side Crunches"]
        
        exerPicArray = ["abs_out_0.png","logo.png","logo.png","abs_out_3.png","abs_out_4.png","abs_out_5.png","abs_out_6.png","abs_out_7.png","abs_out_8.png","logo.png","abs_out_10.png","abs_out_11.png","logo.png","logo.png","abs_out_14.png","logo.png","logo.png","logo.png","abs_out_18.png","logo.png","logo.png","logo.png","logo.png","logo.png"]
        
        exerPicInArray = ["abs0.jpg","logo.png","logo.png","abs3.jpg","abs4.jpg","abs5.jpg","abs6.jpg","abs7.jpg","abs8.jpg","logo.png","abs10.jpg","abs11.jpg","logo.png","logo.png","abs14.jpg","logo.png","logo.png","logo.png","abs18.jpg","logo.png","logo.png","logo.png","logo.png","logo.png"]
        
        exerSubtitleArray = ["",
            "kneeling",
            "",
            "with legs",
            "",
            "flat",
            "hanging",
            "incline","parallel bar",
            "",
            "",
            "lying",
            "",
            "incline",
            "",
            "",
            "incline",
            "crunches",
            "", "","barbell","cable",
            "dumbbell",""]
        
        
        exerType = "abs/"
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
       UINavigationBar.appearance().setBackgroundImage(UIImage(named: "bar_database.jpg")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
        
        var navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = UIColor.whiteColor()
        navigationBarAppearace.barTintColor = UIColor.whiteColor()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //var DestViewController : ExercisesTableViewController = segue.destinationViewController as ExercisesTableViewController
        //DestViewController.test = "hello"
        
        
        
      var navigationController = segue.destinationViewController as! UINavigationController
      var DestViewController = navigationController.viewControllers[0] as! ExercisesTableViewController
      DestViewController.exerArrayPassed = exerArray
      DestViewController.exerArrayPicPassed = exerPicArray
        DestViewController.exerArrayPicInPassed = exerPicInArray
      DestViewController.exerSubtitleArrayPassed = exerSubtitleArray
      DestViewController.exerTypePassed = exerType
        

        
        
    }

}
