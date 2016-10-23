//
//  GoogleSigninVC.swift
//  ResumeQ
//
//  Created by Calvin Rose on 10/22/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import Foundation
import GoogleAPIClient
import GTMOAuth2
import UIKit
import QRCode

class MyQRCodeController: UIViewController {

    @IBOutlet weak var qrView: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set QrView to a random qrcode for now
        let qr = QRCode("https://www.example.com")
        qrView.image = qr?.image

    }
    
    // When the view appears, ensure that the Drive API service is authorized
    // and perform API calls
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
