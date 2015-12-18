//
//  ChildOptionsViewController.swift
//  Backseat Driver
//
//  Created by Anjel Villafranco on 12/7/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit
import MapKit
import Parse

class ChildOptionsViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
  
    @IBAction func drivingModePressed(sender: AnyObject) {
        
        self.showAlertController("Now in Driving Mode🚗")
        
    }
    
    @IBOutlet weak var mySpeedTitle: UILabel!
    
    @IBAction func callParent(sender: AnyObject) {
        
        let url:NSURL = NSURL(string: "tel://7705805597")!
        UIApplication.sharedApplication().openURL(url)
        
    }
    
    
    @IBOutlet weak var childSpeed: UILabel!
    
    @IBAction func logoutpressed(sender: AnyObject) {
        
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        
        let ChoiceVC = mainSB.instantiateViewControllerWithIdentifier("Choice") as?
        UINavigationController
        
        self.navigationController?.presentViewController(ChoiceVC!, animated: true, completion: nil)
        
        print("Logged Out")
    }
    
    let lManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // need to ask for location
        lManager.requestWhenInUseAuthorization()
        
        lManager.delegate = self
        
        // Show pretty blue dot
        // myMapView.showsUserLocation = true
        
        lManager.startUpdatingLocation()
        
    }
    
    
    func showAlertController(message: String) {
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
        
        presentViewController(alertController, animated: true, completion:  nil) 
        
    }
    
    //    func showAlertController(message: String) {
    //        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
    //        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
    //        presentViewController(alertController, animated: true, completion: nil)
    //    }
    //
    
    var speed: CLLocationSpeed! {
        
        didSet {
            
            mph = speed * 2.236934
            print(mph)
            
            // set hidden based on mph
        }
        
    }
    
    var mph: Double = 0 {
        
        didSet {
            
            childSpeed.text = "\(Int(mph))"
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            
            print(location.coordinate.latitude, location.coordinate.longitude)
            speed = location.speed
            
            let point = PFGeoPoint(location: location)
            child?["location"] = point
            child?.saveInBackground()
            
            print(point) 
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print(error)
        
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
        if motion == .MotionShake {
            
            self.mySpeedTitle.text = "Shaken, not stirred"
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
