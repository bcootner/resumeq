//
//  ExplainerVC.swift
//  ResumeQ
//
//  Created by Ben Cootner on 10/23/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import UIKit

class ExplainerVC: UIViewController {
    
    @IBOutlet var gotitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gotitButton.layer.cornerRadius = 11.0
        gotitButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func gotIt(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
