//
//  MainModel.swift
//  ResumeQ
//
//  Created by Ben Cootner on 10/23/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import Foundation


class MainModel {
    
    class var SharedInstance: MainModel {
        struct Static {
            static let instance: MainModel = MainModel()
        }
        return Static.instance  
    }
    
}
