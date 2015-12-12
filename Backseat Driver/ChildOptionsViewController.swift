//
//  ChildOptionsViewController.swift
//  Backseat Driver
//
//  Created by Anjel Villafranco on 12/7/15.
//  Copyright © 2015 Anjel Villafranco. All rights reserved.
//

import UIKit

class ChildOptionsViewController: UIViewController {

    
    @IBAction func logoutpressed(sender: AnyObject) {
        
        let childSB = UIStoryboard(name: "Child", bundle: nil)
        
        let ChildLoginVC = childSB.instantiateViewControllerWithIdentifier("childlogin") as?
        ChildLoginViewController
        
        self.navigationController?.presentViewController(ChildLoginVC!, animated: true, completion: nil)
        
        
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
