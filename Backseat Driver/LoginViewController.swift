//
//  LoginViewController.swift
//  Backseat Driver
//
//  Created by Anjel Villafranco on 11/30/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBAction func touchID(sender: AnyObject) {

            let context = LAContext()
            var error: NSError?
            
            // check if Touch ID is available
            if context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Authenticate with Touch ID"
                context.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
                    {(success: Bool, error: NSError?) in
                        
                        if success {
                            
                            self.showAlertController("Touch ID Authentication Succeeded")
                        }
                        else {
                            
                            self.showAlertController("Touch ID Authentication Failed")
                        }
                })
            }
                
            else {
                showAlertController("Touch ID not available")
            }
        }
        
        func showAlertController(message: String) {
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
}

