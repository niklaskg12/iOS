//
//  OnlineDetailsViewController.swift
//  Charley's Gym
//
//  Created by IMac on 5/12/15.
//  Copyright (c) 2015 iSync. All rights reserved.
//

import UIKit

class OnlineDetailsViewController: UIViewController {
    
    
    var dictValue = Dictionary<String, String>()
    
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var detailsTextView: UITextView!
    
    
    var titlePassed: String = ""
    var detailsPassed: String = ""
    var imagePassed: String = ""
    var exerTypePassed: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titlePassed

        detailsTextView.text = detailsPassed
        
        //imageView.image =  UIImage(contentsOfFile: imagePassed)
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
    
    func downloadImage (urlString: String) -> NSData {
        let logo = NSURL (string: "http://internationalnewscenter.com//android//admin//attached//alalam_635671021164325394_25f_4x3.jpg")
        let url = NSURL(string: urlString)
        if (url != nil) {
            if let data = NSData(contentsOfURL: url!) {
                //make sure your image in this url does exist, otherwise unwrap in a if let check
                return data
            } else {
                return NSData(contentsOfURL: logo!)!
            }
        } else {
            return NSData(contentsOfURL: logo!)!
        }
    }
}
