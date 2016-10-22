//
//  GoogleSigninVC.swift
//  ResumeQ
//
//  Created by Calvin Rose on 10/22/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import Foundation
import GoogleSignIn
import GGLSignIn
import UIKit

class GoogleSigninController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enable google drive access
        let driveScope = "https://www.googleapis.com/auth/drive.readonly"
        GIDSignIn.sharedInstance().scopes.append(driveScope)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
    
}
