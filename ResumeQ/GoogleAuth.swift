//
//  GoogleAuth.swift
//  ResumeQ
//
//  Created by Calvin Rose on 10/22/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import Foundation
import UIKit
import GoogleAPIClient
import GTMOAuth2

class GoogleAuth: NSObject {
    
    static let shared = GoogleAuth()
    
    private let kKeychainItemName = "Drive API"
    private let kClientID = "1087563397670-pbiom5cltnfaeui9qbq8l43a8s6botl3.apps.googleusercontent.com"
    private let scopes = [kGTLAuthScopeDrive]
    
    let service = GTLServiceDrive()
    private var completion: ((Void) -> Void)? = nil
    
    override init() {
        if let auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychain(
            forName: kKeychainItemName,
            clientID: kClientID,
            clientSecret: nil) {
            service.authorizer = auth
        }
    }
    
    func signin(vc: UIViewController, completion: @escaping (Void)->Void) {
        self.completion = nil
        if (service.authorizer != nil) && service.authorizer.canAuthorize! {
            completion()
        } else {
            self.completion = completion
            vc.present(
                createAuthController(),
                animated: true,
                completion: nil
            )
        }
    }
    
    func getDriveModel(onComplete: @escaping ([GTLDriveFile]) -> Void, onPage: @escaping ([GTLDriveFile]) -> Void) -> GoogleDriveModel {
        return GoogleDriveModel(service: service, complete: onComplete, onPage: onPage)
    }
    
    // Creates the auth controller for authorizing access to Drive API
    private func createAuthController() -> GTMOAuth2ViewControllerTouch {
        let scopeString = scopes.joined(separator: " ")
        return GTMOAuth2ViewControllerTouch(
            scope: scopeString,
            clientID: kClientID,
            clientSecret: nil,
            keychainItemName: kKeychainItemName,
            delegate: self,
            finishedSelector: #selector(onComplete(vc:finishedWithAuth:error:))
        )
    }
    
    // Handle completion of the authorization process, and update the Drive API
    // with the new credentials.
    @objc func onComplete(vc : UIViewController,
                        finishedWithAuth authResult : GTMOAuth2Authentication, error : NSError?) {
        if let error = error {
            service.authorizer = nil
            showAlert(vc: vc, title: "Authentication Error", message: error.localizedDescription)
            return
        }
        service.authorizer = authResult
        vc.dismiss(animated: true, completion: self.completion)
    }
    
    // Helper for showing an alert
    private func showAlert(vc: UIViewController, title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    
}
