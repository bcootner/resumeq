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
        let tempArray = [name ?? "", description ?? ""]
        return tempArray + (tags ?? [String]())
    }
    
    class func getCompanies() {
        Alamofire.request("https://resumeq.herokuapp.com/getallcollections").responseJSON { (response) in
            print(response)
        }
    }
    class func getDemoCompanies(completion: (Bool, [Company]) -> Void) {
    
        let comp1 = Company()
        comp1.logo = UIImage(named: "microsoftLogo.jpg")
        comp1.name = "Microsoft"
        comp1.description = "Microsoft was founded in 1975. Our mission is to enable people and businesses throughout the world to realize their full potential by creating technology that transforms the way people work, play, and communicate. We develop and market software, services, and hardware devices that deliver new opportunities, greater convenience, and enhanced value to people's lives. We do business worldwide and have offices in more than 100 countries."
        comp1.tags = ["Computer Engineer", "Full Stack Engineer", "Hololens Developer", "C# Coder"]
        comp1.link = "https://careers.microsoft.com/help/apply"
        
        let comp2 = Company()
        comp2.logo = UIImage(named: "AmazonLogo.png")
        comp2.name = "Amazon"
        comp2.description = "Amazon.com often referred to as simply Amazon, is an American electronic commerce and cloud computing company with headquarters in Seattle, Washington. It is the largest Internet-based retailer in the world by total sales and market capitalization.[14] Amazon.com started as an online bookstore, later diversifying to sell DVDs, Blu-rays, CDs, video downloads/streaming, MP3 downloads/streaming, audiobook downloads/streaming, software, video games, electronics, apparel, furniture, food, toys and jewelry."
        comp2.tags = ["Web Designer", "PR Manager", "Male Voice Actor", "Full Stack", "Mobile Developer"]
        comp2.link = "http://www.amazon.com/jobs"
        
        
        let comp3 = Company()
        comp3.logo = UIImage(named: "ubisoftLogo.jpg")
        comp3.name = "Ubisoft"
        comp3.description = "Ubisoft Entertainment is a French computer and videogame developer and publisher with headquarters in Montreuil-sous-Bois, France. It was founded in 1986 by five brothers, of which Yves Guillemot serves as chairman and CEO. The company consists of 26 studios spread across 18 countries. As of 2011, it was the third most valuable independent videogame publisher in the world, and the second largest in terms of in-house development staff with over 6,900 staff worldwide. Ubisoft also ranked 26th on the list of the largest software companies in the world. Their most famous games and franchises are, The Prince of Persia: The Sands of Time series, Rayman franchise, Assassin's Creed franchise, Brothers in Arms and the Tom Clancy franchise which includes the Rainbow Six, Ghost Recon and Splinter Cell series."
        comp3.tags = ["Game Developer", "Full Stack Engineer", "Hololens Developer"]
        comp3.link = "https://www.ubisoft.com/en-US/careers/experience.aspx"
        
        completion(true, [comp1,comp2, comp3])
        
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
