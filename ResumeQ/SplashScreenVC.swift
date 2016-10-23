//
//  SplashScreenVC.swift
//  ResumeQ
//
//  Created by Ben Cootner on 10/23/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import UIKit
import AVFoundation

class SplashScreenVC: UIViewController {

    @IBOutlet var companyButton: UIButton!
    @IBOutlet var studentButton: UIButton!
    
    @IBOutlet var info1: UILabel!
    @IBOutlet var info2: UILabel!
    @IBOutlet var info3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        info1.alpha = 0
        info2.alpha = 0
        info3.alpha = 0

        let path = Bundle.main.path(forResource: "background", ofType: "mov")
        let player = AVPlayer(url: NSURL(fileURLWithPath: path!) as URL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.addSublayer(playerLayer)
        player.seek(to: kCMTimeZero)
        player.play()
        
        self.view.bringSubview(toFront: companyButton)
        self.view.bringSubview(toFront: studentButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 3, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.info1.alpha = 1
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 3.5, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.info2.alpha = 1
            }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 4, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.info3.alpha = 1
            }, completion: nil)
    }
    
    @IBAction func studentClicked(_ sender: AnyObject) {
        UserDefaults.standard.set(true, forKey: "isStudent")
        UserDefaults.standard.synchronize()
        GoogleAuth.shared.signin(vc: self, completion: {
            self.performSegue(withIdentifier: "showStudent", sender: self)
        })
    }
    @IBAction func companyClicked(_ sender: AnyObject) {
        UserDefaults.standard.set(false, forKey: "isStudent")
        UserDefaults.standard.synchronize()
        GoogleAuth.shared.signin(vc: self, completion: {
            self.performSegue(withIdentifier: "showCompany", sender: self)
        })
        
    }
}
