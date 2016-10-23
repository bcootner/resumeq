//
//  Company.swift
//  ResumeQ
//
//  Created by Ben Cootner on 10/22/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import Foundation
import UIKit

class Company {
    
     var logo: UIImage?
     var name: String?
     var description: String?
     var tags: [String]?
    
    func searchableStrings() -> [String] {
        return tags ?? [String]() + [name ?? "", description ?? ""]
    }
    
}
