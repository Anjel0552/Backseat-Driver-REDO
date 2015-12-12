//
//  FamilyInfoViewController.swift
//  Backseat Driver
//
//  Created by Anjel Villafranco on 12/11/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit
import Parse

class FamilyInfoViewController: UIViewController {

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
    
    @IBOutlet weak var familyName: UITextField!
    
    @IBOutlet weak var childOneName: UITextField!
    
    @IBOutlet weak var parentPhoneNumber: UITextField!
    
    @IBOutlet weak var childPhoneNumber: UITextField!
    
   
    @IBAction func pressedComplete(sender: AnyObject) {
   
    
        let parent: PFObject = PFObject(className: "Parent")
            
            parent["childPhone"] = childPhoneNumber.text
            
            parent["familyname"] = familyName.text
        
        let child: PFObject = PFObject(className: "Child")
        
            child["parentPhone"] = parentPhoneNumber.text
        
            child["name"] = childOneName.text
        
            child["parent"] = parent
            
        parent.saveInBackgroundWithBlock({ (success, error) -> Void in
            
            
            child.saveInBackgroundWithBlock({ (success, error) -> Void in
                
                print("both saved")
                
            })
            
        })
        
        

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
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

