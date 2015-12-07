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
        
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        
        let ChoiceVC = mainSB.instantiateViewControllerWithIdentifier("Choice") as?
        UINavigationController
        
        self.navigationController?.presentViewController(ChoiceVC!, animated: true, completion: nil)
        
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
