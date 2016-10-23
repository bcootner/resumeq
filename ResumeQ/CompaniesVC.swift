//
//  SecondViewController.swift
//  ResumeQ
//
//  Created by Ben Cootner on 10/21/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import UIKit

class CompaniesVC: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var selectedCompany = Company()
    var searchedItems = [Company]()
    var allItems = [Company]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        tableView.refreshControl?.tintColor = UIColor.gray
        
        //Company.addCompany(name: "Microsoft", description: "", link: "www.microsoft.com/apply", tags: ["C# Coder", "Andriod","Backend"])
        
        //Company.getCompanies()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData() {
        Company.getDemoCompanies { (success, companies) in
            self.tableView.refreshControl?.endRefreshing()
            if success {
                allItems = companies
                searchedItems = allItems
                tableView.reloadData()
            }
        }

    }
}

//MARK: Table View Delegate and DataSource Methods

extension CompaniesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! companyCell
        cell.logoView.image = searchedItems[indexPath.row].logo
        cell.nameLabel.text = searchedItems[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCompany = searchedItems[indexPath.row]
        self.performSegue(withIdentifier: "moreDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "moreDetail" {
            if let destination_VC = segue.destination as? MoreDetailVC {
            destination_VC.company = selectedCompany
            }
        }
    }
    
}

//MARK Search bar delegate methods 

extension CompaniesVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedItems.removeAll()
        let searchText = searchBar.text?.uppercased()
        if(searchText == ""){
            searchedItems = allItems
        }
        else{
            for company in allItems{
                let searchableText = company.searchableStrings()
                let searchableStrings = searchableText.map{$0.uppercased()}
                for string in searchableStrings {
                    if(string.range(of: searchText ?? "") != nil) {
                        searchedItems.append(company)
                        break
                    }
                }
            }
        }
        tableView.reloadData()
    }
}

