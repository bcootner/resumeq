//
//  GoogleDriveModel.swift
//  ResumeQ
//
//  Created by Calvin Rose on 10/22/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import Foundation
import GoogleAPIClient
import GTMOAuth2

class GoogleDriveModel: NSObject {
    
    var nextPage: String? = nil
    var files: [GTLDriveFile] = []
    let onComplete: ([GTLDriveFile]) -> Void
    let service: GTLServiceDrive
    let onPage: ([GTLDriveFile]) -> Void
    private let driveQuery = "nextPageToken, files(id, name, mimeType, webContentLink)"
    
    init(service: GTLServiceDrive, complete: @escaping ([GTLDriveFile]) -> Void, onPage: @escaping ([GTLDriveFile]) -> Void) {
        self.service = service
        self.onPage = onPage
        onComplete = complete
    }
    
    func load() {
        // first fetch
        let query = GTLQueryDrive.queryForFilesList()!
        query.fields = driveQuery
        query.pageSize = 350
        service.executeQuery(
            query,
            delegate: self,
            didFinish: #selector(fetch(ticket:fileList:error:))
        )
    }
    
    func getFileContents(file: GTLDriveFile, completion: @escaping (Data) -> Void) {
        let id = file.identifier.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        print(id)
        let url = file.webContentLink ?? "https://www.googleapis.com/drive/v2/files/\(id!)?alt=media"
        let fetcher = service.fetcherService.fetcher(with: URL(string: url)!)
        fetcher.beginFetch(completionHandler: {
            data, error in
            if (error == nil) {
                completion(data!)
            } else {
                print("error\(error!)")
            }
        })
    }
    
    @objc func fetch(ticket: GTLServiceTicket,
                     fileList: GTLDriveFileList,
                     error: Error) {
        self.onPage(fileList.files as! [GTLDriveFile])
        if (fileList.files != nil) {
            for file in fileList.files as! [GTLDriveFile] {
                files.append(file)
            }
        }
        if let nextToken = fileList.nextPageToken {
            let query = GTLQueryDrive.queryForFilesList()!
            query.fields = driveQuery
            query.pageSize = 1000
            query.pageToken = nextToken
            service.executeQuery(
                query,
                delegate: self,
                didFinish: #selector(fetch(ticket:fileList:error:))
            )
        } else {
            return onComplete(files)
        }
        
    }
}
