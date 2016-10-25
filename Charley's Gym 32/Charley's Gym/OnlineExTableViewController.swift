//
//  OnlineExTableViewController.swift
//  Charley's Gym
//
//  Created by IMac on 5/11/15.
//  Copyright (c) 2015 iSync. All rights reserved.
//

import UIKit

class OnlineExTableViewController: UITableViewController {

    var titlesArrayPassed:[String] = []
    var detailsArrayPassed : [String] = []
    var photoNameArrayPassed : [NSData] = []
    var cash = ""
    
    
    
    @IBAction func backBtn(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "bar_charlysgym.jpg")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)

    }
    
    @IBOutlet var backBtn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = backBtn
        self.navigationItem.rightBarButtonItem = nil
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return titlesArrayPassed.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var Cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        Cell.textLabel?.text = titlesArrayPassed[indexPath.row]
        var imageName = UIImage(data: (photoNameArrayPassed[indexPath.row]))
        
        Cell.imageView?.image = imageName
        return Cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        var DestViewController : OnlineDetailsViewController = segue.destinationViewController as! OnlineDetailsViewController
        
        
        var indexPath = self.tableView.indexPathForSelectedRow()
        
        var obj = indexPath!.row
        
        
        DestViewController.titlePassed = titlesArrayPassed [obj]
        DestViewController.detailsPassed = detailsArrayPassed [obj]
        var imageName = UIImage(data: (photoNameArrayPassed[obj]))
        DestViewController.imageView?.image = imageName
        
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }


}
