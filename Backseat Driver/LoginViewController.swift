//
//  LoginViewController.swift
//  Backseat Driver
//
//  Created by Anjel Villafranco on 11/30/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit
import LocalAuthentication
import Parse

var foundParent: PFObject?
var foundChild: PFObject?
var kidName: String!

class LoginViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        let nav = self.navigationController?.navigationBar
        
        nav?.tintColor = UIColor.whiteColor()
        nav?.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        nav?.shadowImage = UIImage()
        nav?.translucent = true
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        
        let image = UIImage(named: "logosmall")
        
        imageView.image = image
        
        navigationItem.titleView = imageView
    }
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        
        
        PFUser.logInWithUsernameInBackground(self.usernameField.text!, password: self.passwordField.text!) { (user, error) in
            
            
            if user != nil {
                
                var query = PFQuery(className:"Parent")
                query.whereKey("user", equalTo:user!)
                query.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    
                    if let foundParent = objects?.first {
                        
                        parent = foundParent
                        
                        print(parent)
                        
                        var query = PFQuery(className:"Child")
                        query.whereKey("parent", equalTo:foundParent)
                        query.findObjectsInBackgroundWithBlock {
                            (objects: [PFObject]?, error: NSError?) -> Void in
                            
                            if let foundChild = objects?.first {
                                
                                child = foundChild
                                
                                print("the child\(foundChild) has been found")
                                
                                kidName = child!["name"] as? String
                                
                                print("what's up Homie!!\(kidName)")
                                
                            }
                            
                        }
                        
                        let mainSB = UIStoryboard(name: "Main", bundle: nil)
                        
                        let POCVC = mainSB.instantiateViewControllerWithIdentifier("POC") as?
                        POCViewController
                        
                        self.navigationController?.presentViewController(POCVC!, animated: true, completion: nil)
                        
                        print("Logged in")
                        
                        
                    } else {
                        
                        print("not logged in")
                        
                    }
                    
                }
              
    func viewDidLoad() {
            super.viewDidLoad()
                    
                self.navigationController?.navigationBarHidden = false
                    
                }
                
    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
                    // Dispose of any resources that can be recreated.

                }
            }
        }
    }
}