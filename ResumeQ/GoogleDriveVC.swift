//
//  GoogleDriveVC.swift
//  ResumeQ
//
//  Created by Calvin Rose on 10/22/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import Foundation
import GoogleAPIClient
import UIKit
import Alamofire

class GoogleDriveVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var searchBar = UISearchBar()
    
    var files: [GTLDriveFile] = []
    var searchedFiles: [GTLDriveFile] = []
    var googleModel: GoogleDriveModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
       
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        tableView.refreshControl?.tintColor = UIColor.gray
        tableView.refreshControl?.beginRefreshing()
        loadData()
    }

    override func viewWillLayoutSubviews() {
        searchBar.frame = CGRect(x: 0, y: 30, width: UIScreen.main.bounds.width, height: 40.0)
        self.view.addSubview(searchBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func loadData() {
        
        func onPage(files: [GTLDriveFile]) {
            if self.files.isEmpty {
                self.files = files
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            print("loading...")
        }
        
        func onComplete(files: [GTLDriveFile]) {
            self.files = files
            DispatchQueue.main.async {
                self.searchedFiles = files
                self.searchBar.text = nil
                self.searchBar.resignFirstResponder()
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
                
            }
            print("done.")
        }
        
        GoogleAuth.shared.signin(vc: self, completion: {
            self.googleModel = GoogleAuth.shared.getDriveModel(onComplete: onComplete, onPage: onPage)
            self.googleModel!.load()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK: Table view  delegate and data source functions 

extension GoogleDriveVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drivecell", for: indexPath) as! DriveCell
        cell.filenameLabel.text = searchedFiles[indexPath.row].name
        //Thumbnail not working -- Thanks Google!
        //        let url = NSURL(string: files[indexPath.row].thumbnailLink )
        //        if let url = url as? URL,
        //            let data = NSData(contentsOf: url) as? Data {
        //            cell.thumbnailImg.image = UIImage(data: data)
        //        }
       return cell
    }
 
    
    func upload(data: Data, file: GTLDriveFile, mime: String, complete: (String) -> Void) {
        print("Mime: \(mime)")
    Alamofire.request("https://resumeq.herokuapp.com/resume_submit_json", method: .post, parameters: [:], encoding: data.base64EncodedString(), headers: [:]).responseString {
            response in
            print(response.result.value!)
            complete(response.result.value!)
        }
        //        Alamofire.post(
//            multipartFormData: { multipartFormData in
//                multipartFormData.append(data, withName: "resume", mimeType: mime)
//            },
//            to: "https://resumeq.herokuapp.com/resume_submit_mobile",
//            encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.response{ response in
//                        print(response)
//                    }
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//            }
//        )
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let file = searchedFiles[indexPath.row]
        let alert = UIAlertController(title: "Upload \(file.name ?? "")?", message: "Are you sure you want to upload this file?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            //Upload file to server, generate id and create QR code
            if let model = self.googleModel {
                model.getFileContents(file: file, completion: {
                    data, mime in
                    print("\(data)")
                    // Upload the data in a blob
                    self.upload(data: data, file: file, mime: mime, complete: {
                        id in
                        let resumeId = id
                        UserDefaults.standard.set(resumeId, forKey: "ResumeString")
                        UserDefaults.standard.synchronize()
                    })
                })
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}

extension GoogleDriveVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedFiles.removeAll()
        let searchText = searchBar.text?.uppercased()
        if(searchText == ""){
            searchedFiles = files
        }
        else{
            for file in files{
                let searchableText = file.searchableStrings()
                let searchableStrings = searchableText.map{$0.uppercased()}
                for string in searchableStrings {
                    if(string.range(of: searchText ?? "") != nil) {
                        searchedFiles.append(file)
                        break
                    }
                }
            }
        }
        tableView.reloadData()
    }
}
