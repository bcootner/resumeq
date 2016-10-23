//
//  Company.swift
//  ResumeQ
//
//  Created by Ben Cootner on 10/22/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class Company {
    
    var logo: UIImage?
    var name: String?
    var description: String?
    var tags: [String]?
    var link: String?
    
    
    func searchableStrings() -> [String] {
        return tags ?? [String]() + [name ?? "", description ?? ""]
    }
    
    class func getCompanies() {
        Alamofire.request("https://resumeq.herokuapp.com/getallcollections").responseJSON { (response) in
            print(response)
        }
    }
    
    class func addCompany(name: String, description: String, link: String, tags: [String]) {
        let paramters: Parameters =
        [
            "name": name,
            "description": description,
            "link": link,
            "tags": tags
        ]
        
        Alamofire.request("https://resumeq.herokuapp.com/makecollection", method: .post, parameters: paramters, encoding: JSONEncoding.default)
        
    }
    
}
