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
    
    private let exportMimes = [
        "application/vnd.google-apps.document"
    ]
    
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
    
    func getFileContents(file: GTLDriveFile, completion: @escaping (Data, String) -> Void) {
        let id = file.identifier.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        print(id)
        print(file.mimeType)
        var url: String = ""
        var mime: String = ""
        if exportMimes.contains(file.mimeType) {
            mime = "application/pdf"
            url = "https://www.googleapis.com/drive/v3/files/\(id!)/export?alt=media&mimeType=application/pdf"
        } else {
            mime = file.mimeType!
            url = "https://www.googleapis.com/drive/v3/files/\(id!)?alt=media"
        }
        if let realURL = URL(string: url) {
            let fetcher = service.fetcherService.fetcher(with: realURL)
            fetcher.beginFetch(completionHandler: {
                data, error in
                if (error == nil) {
                    print("Success! \(data)")
                    completion(data!, mime)
                } else {
                    print("error\(error!)")
                }
            })
        } else {
            print("Could not make url: \(url)")
        }
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
