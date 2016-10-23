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
        
        let comp4 = Company()
        comp4.logo = UIImage(named: "illlogo.png")
        comp4.name = "Illumina"
        comp4.description = "Since the launch of our first Infinium BeadChip in 2005, Illumina has innovated robust, economical, and scalable microarray solutions for an ever increasing range of applications. Powered by industry-leading BeadArray and Infinium assay technologies, our comprehensive suite of microarrays delivers exceptional data quality and genomic coverage to accelerate both targeted and whole genome studies."
        comp4.tags = ["Biomedical Engineer", "Chemistry Major", "Web Designer", "Human Test Subject", "Computer Enginerr"]
        comp4.link = "http://www.illumina.com/company/careers/search-jobs.html"

        
        let comp5 = Company()
        comp5.logo = UIImage(named: "googleimg.png")
        comp5.name = "Google"
        comp5.description = "Since the beginning, we’ve focused on providing the best user experience possible. Whether we’re designing a new Internet browser or a new tweak to the look of the homepage, we take great care to ensure that they will ultimately serve you, rather than our own internal goal or bottom line."
        comp5.tags = ["Computer Engineer", "Computer Science", "Web Developer", "Andriod Developer", "Backend Developer"]
        comp5.link = "https://www.google.com/about/careers/how-we-hire/apply/"

        
        let comp6 = Company()
        comp6.logo = UIImage(named: "capitalimg.png")
        comp6.name = "Capital One"
        comp6.description = "Capital One Financial Corporation is an American bank holding company specializing in credit cards, home loans, auto loans, banking and savings products. Wikipedia"
        comp6.tags = ["Cybersecurity", "Backend developer", "Math majors"]
        comp6.link = "https://www.capitalonecareers.com/"

        
        let comp7 = Company()
        comp7.logo = UIImage(named: "gitimg.png")
        comp7.name = "Github"
        comp7.description = "GitHub is a web-based Git repository hosting service. It offers all of the distributed version control and source code management (SCM) functionality of Git as well as adding its own features. It provides access control and several collaboration features such as bug tracking, feature requests, task management, and wikis for every project."
        comp7.tags = ["Backend developer", "Web Developer", "Server Developer"]
        comp7.link = "https://github.com/about/jobs"

        
        let comp8 = Company()
        comp8.logo = UIImage(named: "apple.png")
        comp8.name = "Apple"
        comp8.description = "Apple Inc. is an American multinational technology company headquartered in Cupertino, California, that designs, develops, and sells consumer electronics, computer software, and online services. Its hardware products include the iPhone smartphone, the iPad tablet computer, the Mac personal computer, the iPod portable media player, the Apple Watch smartwatch, and the Apple TV digital media player. Apple's consumer software includes the macOS and iOS operating systems, the iTunes media player, the Safari web browser, and the iLife and iWork creativity and productivity suites. Its online services include the iTunes Store, the iOS App Store and Mac App Store, Apple Music, and iCloud."
        comp8.tags = ["Computer Engineer", "Electrical Engineer", "iOS Developer", "Computer Science"]
        comp8.link = "http://www.apple.com/jobs/us/"

        
        let comp9 = Company()
        comp9.logo = UIImage(named: "namec.png")
        comp9.name = "Namecheap"
        comp9.description = "In the year 2000, a man named Richard Kirkendall founded a company called Namecheap, with the idea that the average people of the internet deserved value-priced domains and stellar service. These days, Namecheap is a leading ICANN-accredited domain name registrar and web hosting company. We're happy to report: Namecheap has about 2 million customers and more than 5 million domains under management."
        comp9.tags = ["Web Developers", "Dev Ops", "Linux"]
        comp9.link = "https://www.namecheap.com/careers.aspx"

        let comp10 = Company()
        comp10.logo = UIImage(named: "zyp.png")
        comp10.name = "Zyp"
        comp10.description = "A home cleaning is now just a swipe away! Zyp provides an on-demand, area-specific home cleaning service. Zyp will come clean only what you want cleaned, removing all hourly minimums and high prices that are standard throughout the residential cleaning industry."
        comp10.tags = ["Computer Engineer", "Cleaning Professionals", "PR Manager", "Web Designer", "Campus Rep"]
        comp10.link = "https://zypapp.com/jobs"
        
        let comp11 = Company()
        comp11.logo = UIImage(named: "raytheon.png")
        comp11.name = "Raytheon"
        comp11.description = "If you want to use your talent to make the world a safer place, Raytheon is the place to pursue a career. After all, you’ll be part of a dynamic and diverse global team that’s working together to solve some of the most demanding challenges on the planet. Whatever your area of interest and expertise, you’ll play an integral role in creating sophisticated systems and platforms that will help redefine defense and government electronics, space exploration, information technology, cyber security and more."
        comp11.tags = ["Computer Engineer", "Full Stack Engineer", "Acounting"]
        comp11.link = "https://jobs.raytheon.com/"

    
        completion(true, [comp1,comp2, comp3, comp4, comp5,comp6,comp7,comp8,comp9,comp10, comp11])
        
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
