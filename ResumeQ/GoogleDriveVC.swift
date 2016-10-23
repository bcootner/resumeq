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

class GoogleDriveVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var files: [GTLDriveFile] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadData() {
        
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
                self.tableView.reloadData()
            }
            print("done.")
        }
        
        GoogleAuth.shared.signin(vc: self, completion: {
            let model = GoogleAuth.shared.getDriveModel(onComplete: onComplete, onPage: onPage)
            model.load()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension GoogleDriveVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "drivecell", for: indexPath) as! DriveCell
        cell.filenameLabel.text = files[indexPath.row].name
        return cell
    }
    
}
