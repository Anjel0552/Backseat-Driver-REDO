//
//  JoinViewController.swift
//  Backseat Driver
//
//  Created by Anjel Villafranco on 11/30/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit
import Parse

class JoinViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func registerButtonPressed(sender: UIButton) {
        
//        guard let username = usernameField.text else { return }
//
//        guard let password = passwordField.text else { return }
//
//        guard let email = emailField.text else { return }
        
        let user = PFUser()
        
        user.username = usernameField.text!
        
        user.password = passwordField.text!
        
        user.email = emailField.text!
        
        user.signUpInBackgroundWithBlock {
            
            (succeeded: Bool, error) -> Void in
            if error == nil {
                
                print("Joined")
                
            } else {
                
                let errorString = error!.userInfo["error"] as? NSString
                
                print(errorString)
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        
    }
    
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
        
        func didReceiveMemoryWarning() {
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
}
