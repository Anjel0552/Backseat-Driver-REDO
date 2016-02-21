//
//  ViewController.swift
//  Backseat Driver
//
//  Created by Anjel Villafranco on 11/30/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit
import MapKit
import Parse


class MapViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {

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
    
    @IBOutlet weak var myMapView: MKMapView!
    
    let lManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                
                print("this shit is working!")
                
            }
        }
        
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
        
    }
    
    var speed: CLLocationSpeed! {
        
        didSet {
            
            mph = speed * 2.23694
            print(mph)

            // set hidden based on mph
        }
        
    }
    
    var mph: Double = 0 {
        
        didSet {
            
        speedLabel.text = "\(Int(mph))"
            
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

}
