//
//  ViewController.swift
//  Backseat Driver
//
//  Created by Anjel Villafranco on 11/30/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit
import MapKit
import MessageUI

class MapViewController: UIViewController, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate {
    
    
    @IBOutlet weak var myMapView: MKMapView!
    
    let lManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // need to ask for location
        lManager.requestWhenInUseAuthorization()
        
        lManager.delegate = self
        
        // Show pretty blue dot
        myMapView.showsUserLocation = true
        
        //        lManager.startUpdatingLocation()
        
        lManager.requestLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            
            print(location.coordinate.latitude, location.coordinate.longitude)
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print(error)
    }
    
    @IBAction func callButton(sender: UIButton) {
        
        //        guard let phoneNumber = numberField.text else { return }
        
        
        let url:NSURL = NSURL(string: "tel://9565458321")!
        UIApplication.sharedApplication().openURL(url)
        
        //        print(phoneNumber)
    }
    
    
    @IBAction func messageButton(sender: AnyObject) {
        
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = ""
        messageVC.recipients = ["9565458321"]
        messageVC.messageComposeDelegate = self
        
        self.presentViewController(messageVC, animated: false, completion: nil)
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
        switch (result.rawValue) {
            
        case MessageComposeResultCancelled.rawValue:
            
            print("Message was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
            
        case MessageComposeResultFailed.rawValue:
            
            print("Message failed")
            self.dismissViewControllerAnimated(true, completion: nil)
            
        case MessageComposeResultSent.rawValue:
            
            print("Message was sent")
            self.dismissViewControllerAnimated(true, completion: nil)
        
        default:
            
            break;
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackTranslucent
        nav?.tintColor = UIColor.clearColor()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        
        let image = UIImage(named: "appleswifticon")
        imageView.image = image
        
        navigationItem.titleView = imageView
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
}

