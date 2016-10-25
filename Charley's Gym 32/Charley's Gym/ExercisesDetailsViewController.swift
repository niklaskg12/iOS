//
//  ExercisesDetailsViewController.swift
//  Charley's Gym
//
//  Created by IMac on 5/4/15.
//  Copyright (c) 2015 iSync. All rights reserved.
//

import UIKit

class ExercisesDetailsViewController: UIViewController {

    var titlePassed: String = ""
    var detailsPassed: String = ""
    var imagePassed: String = ""
    var exerTypePassed: String = ""
    
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var imagePic: UIImageView!
    
    @IBOutlet var detailsText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Show Title
        titleLabel.text = titlePassed
        
        
        // Show Details
        detailsText.text = detailsPassed
        
        
        // Show Image
        var imageName = UIImage(named: "exercises/\(exerTypePassed)\(imagePassed)")
        imagePic.image = imageName
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
