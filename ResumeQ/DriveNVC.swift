//
//  DriveNVC.swift
//  ResumeQ
//
//  Created by Ben Cootner on 10/23/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import UIKit

class DriveNVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if(UserDefaults.standard.object(forKey: "ResumeString") == nil) {
            self.performSegue(withIdentifier: "explain", sender: self)
        }
    }
    
    override func viewWillLayoutSubviews() {
        self.navigationBar.barTintColor = UIColor(colorLiteralRed: 0.82, green: 0.39, blue: 0.35, alpha: 1.0)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
