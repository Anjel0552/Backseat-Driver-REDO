//
//  POCViewController.swift
//  Backseat Driver
//
//  Created by Anjel Villafranco on 12/6/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit

class POCViewController: UIViewController {
    
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

    
    @IBAction func childPressed(sender: AnyObject) {
        
        let childSB = UIStoryboard(name: "Child", bundle: nil)
        
        let ChildLoginVC = childSB.instantiateViewControllerWithIdentifier("childlogin") as?
        ChildLoginViewController
        
        self.navigationController?.presentViewController(ChildLoginVC!, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBarHidden = false
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
