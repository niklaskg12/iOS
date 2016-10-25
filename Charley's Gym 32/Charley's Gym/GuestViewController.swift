//
//  GuestViewController.swift
//  Charley's Gym
//
//  Created by IMac on 4/26/15.
//  Copyright (c) 2015 iSync. All rights reserved.
//

import UIKit
import Foundation

class GuestViewController: UIViewController {
    

    
    var titlesArray:[String] = []
    var detailsArray : [String] = []
    var photoNameArray : [NSData] = []
    var cash = ""
    
    // WorkOut
    @IBAction func workoutImg(sender: AnyObject) {
        
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "bar_workout.jpg")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
        
        
        if cash != "workout" {
            
        //check interntet connection
        if Reachability.isConnectedToNetwork() == true {
            println("Internet connection OK")
            cash = "workout"
            var jsunResult = getJSON("http://internationalnewscenter.com/android/mainnews.php")

            //let storeJSONFromApi = parseJSON(getJSON("http://internationalnewscenter.com/android/mainnews.php"))
            //println(storeJSONFromApi)
            
            let jsonResult = parseJSON(jsunResult) as NSDictionary
            var items = [[String:String]()]
            
            var item:AnyObject
            
            
            
            for var i = 0; i < jsonResult["products"]!.count; i++ {
                
                items.append([String:String]())
                
                item = jsonResult["products"]![i] as! NSDictionary
                
                items[i]["id"] = item ["id"] as! NSString as String
                items[i]["title"] = item ["title"] as! NSString as String
                items[i]["picture"] = item ["picture"] as! NSString as String
                items[i]["details"] = item ["details"] as! NSString as String
                
                self.titlesArray.append(items [i] ["title"]!)
                self.detailsArray.append(items [i] ["details"]!)
                
                //if items[i] ["picture"] == "http://internationalnewscenter.com/android/admin/" {
                    //self.photoNameArray.append("logo.jpg")
                //} else {
                    var temp = downloadImage(items [i] ["picture"]!)
                    self.photoNameArray.append(temp)
                //}
                
                println(self.titlesArray [i])
                println(self.detailsArray [i])
                println(self.photoNameArray [i])
            }
            
          
            
            
            
            
        } else {
            
            //alert
            let alertView = UIAlertView(title: "Oops!", message: "Internet connection FAILED", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
        }
            
    }
        
        
        
        
  }
    
    
    
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary{
        var error: NSError?
        var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
        
        return boardsDictionary
   

    }
    
    
    
    
    
    @IBAction func workoutText(sender: AnyObject) {
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "bar_workout.jpg")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
    }
    
    
    
    
    @IBAction func tipsImg(sender: AnyObject) {
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "bar_tips.jpg")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
    }
    @IBAction func tipsText(sender: AnyObject) {
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "bar_tips.jpg")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
    }
    
    
    
    
    
    @IBAction func dietImg(sender: AnyObject) {
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "bar_diet.jpg")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)

    }
    @IBAction func dietText(sender: AnyObject) {
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "bar_diet.jpg")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
    }
    
    
    
    @IBOutlet var nav: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "bar_charlysgym.jpg")!.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .Stretch), forBarMetrics: .Default)
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "OnlineExTableViewController")
        {
        var navigationController = segue.destinationViewController as! UINavigationController
        var DestViewController = navigationController.viewControllers[0] as! OnlineExTableViewController
        DestViewController.titlesArrayPassed = titlesArray
        DestViewController.detailsArrayPassed = detailsArray
        DestViewController.photoNameArrayPassed = photoNameArray
        
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    
    
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



//check connection

import Foundation
import SystemConfiguration

public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)).takeRetainedValue()
        }
        
        var flags: SCNetworkReachabilityFlags = 0
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
            return false
        }
        
        let isReachable = (flags & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection) ? true : false
    }
    
}
