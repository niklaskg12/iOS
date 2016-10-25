//
//  ProgramViewController.swift
//  Charley's Gym
//
//  Created by IMac on 5/9/15.
//  Copyright (c) 2015 iSync. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "bar_program.jpg")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)

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
