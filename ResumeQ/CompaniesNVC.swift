//
//  CompaniesNVC.swift
//  ResumeQ
//
//  Created by Ben Cootner on 10/23/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import UIKit

class CompaniesNVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillLayoutSubviews() {
        self.navigationBar.barTintColor = UIColor(colorLiteralRed: 0.82, green: 0.39, blue: 0.35, alpha: 1.0)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
