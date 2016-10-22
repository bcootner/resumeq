//
//  Resume.swift
//  ResumeQ
//
//  Created by Ben Cootner on 10/21/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Resume {

    //Unique id for resume
    private var id: String?
    
    init (qrId: String) {
        id = qrId
    }
    
    func sendRequest(completion: @escaping (Bool, URL?) -> Void) {
        if let id = id?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent("resume.pdf")
                return (fileURL, .removePreviousFile)
            }
            Alamofire.download("https://resumeq.herokuapp.com/resume/" + id + ".pdf", to: destination).response { response in
                print(response.temporaryURL)
                print(response.destinationURL)
                completion(true,response.destinationURL)
            }
        }
    }


    
}
