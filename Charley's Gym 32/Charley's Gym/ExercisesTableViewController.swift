//
//  ExercisesTableViewController.swift
//  Charley's Gym
//
//  Created by IMac on 4/29/15.
//  Copyright (c) 2015 iSync. All rights reserved.
//

import UIKit

class ExercisesTableViewController: UITableViewController {
    
    
    var exerArrayPassed = [String]()
    var exerArrayPicPassed = [String]()
    var exerArrayPicInPassed = [String]()
    var exerSubtitleArrayPassed = [String]()
    var exerTypePassed: String = ""
    
    
    
    
    
    @IBAction func backBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


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
        return exerArrayPassed.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var Cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        Cell.textLabel?.text = exerArrayPassed[indexPath.row]
        Cell.detailTextLabel?.text = exerSubtitleArrayPassed[indexPath.row]
        var imageName = UIImage(named: "exercises/\(exerTypePassed)\(exerArrayPicPassed[indexPath.row])")
        
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
        
       // var indexPath : NSArray = exerArrayPassed.indexPathsForSelectedItems()

        var DestViewController : ExercisesDetailsViewController = segue.destinationViewController as! ExercisesDetailsViewController
        
        
          var indexPath = self.tableView.indexPathForSelectedRow()
        
            var obj = indexPath!.row

                
            DestViewController.titlePassed = exerArrayPassed [obj]
            DestViewController.imagePassed = exerArrayPicInPassed [obj]
            DestViewController.exerTypePassed = exerTypePassed
        
        
        
        //////////////////////////// Text Files
        
        var err: NSError?
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource("exercises/\(exerTypePassed)details\(obj)", ofType: "txt")
        let content = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)

            var text = content
            
            
            DestViewController.detailsPassed = text!
            
        
        
        
        
        
        
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
  
}
