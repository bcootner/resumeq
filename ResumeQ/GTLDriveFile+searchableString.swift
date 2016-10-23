//
//  GTLDriveFile+searchableString.swift
//  ResumeQ
//
//  Created by Ben Cootner on 10/23/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import Foundation
import GoogleAPIClient

extension GTLDriveFile {
    func searchableStrings() -> [String]{
        return [self.name]
    }
}
