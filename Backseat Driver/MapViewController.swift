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
import Parse

class MapViewController: UIViewController, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var childChossen: UILabel! 
        
    @IBOutlet weak var speedLabel: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        
        let nav = self.navigationController?.navigationBar
        
        nav?.tintColor = UIColor.whiteColor()
        nav?.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        nav?.shadowImage = UIImage()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        
        let image = UIImage(named: "logosmall")
        
        imageView.image = image
        
        navigationItem.titleView = imageView
        
    }
    
    @IBOutlet weak var myMapView: MKMapView! {
    
        didSet {
            
            myMapView.mapType = .Standard
            myMapView.zoomEnabled = true
            self.myMapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true);
            self.myMapView.showAnnotations(self.myMapView.annotations, animated: true)

        }
        
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
        
        if let point = child?["location"] as? PFGeoPoint {
            
            // create annotation and add to map
            
            let coord = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = coord
            
            self.myMapView.addAnnotation(annotation)
            
        }
        
        guard let child1 = child?["name"] as? String else { return }
        
        childChossen.text! = "\(child1)'s Location"
        
        func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let userLoction: CLLocation = locations[0]
            let latitude = userLoction.coordinate.latitude
            let longitude = userLoction.coordinate.longitude
            let latDelta: CLLocationDegrees = 0.05
            let lonDelta: CLLocationDegrees = 0.05
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            self.myMapView.setRegion(region, animated: true)
            self.myMapView.showsUserLocation = true
            
        }
        
    }
    
    var speed: CLLocationSpeed! {
        
        didSet {
            
            mph = speed * 2.23694
            print(mph)
            
            if speed < 75 {
                
                print("Slow the FUCK DOWN")
                
            }
            // set hidden based on mph
        }
        
    }
    
    var mph: Double = 0 {
        
        didSet {
            
            speedLabel.text = "\(Int(mph))"
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            
            print(location.coordinate.latitude, location.coordinate.longitude)
            speed = location.speed
            
        }
        
    }
    
    
    
    @IBAction func pressedLogout(sender: AnyObject) {
        
        PFUser.logOut()
        
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        
        let ChoiceVC = mainSB.instantiateViewControllerWithIdentifier("Choice") as?
        UINavigationController
        
        self.navigationController?.presentViewController(ChoiceVC!, animated: true, completion: nil)
        
        print("Logged Out")
        
    }
    
    @IBAction func callButton(sender: UIButton) {
        
        guard let childNumber = parent?["childPhone"] as? String else { return }
        
        let url:NSURL = NSURL(string: "tel://\(childNumber)")!
        UIApplication.sharedApplication().openURL(url)
        
        print(childNumber)
        
    }
    
    @IBAction func messageButton(sender: AnyObject) {
        
        guard let childNumberSMS = parent?["childPhone"] as? String else { return }
        
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = ""
        messageVC.recipients = ["\(childNumberSMS)"]
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
}

