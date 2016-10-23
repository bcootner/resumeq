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
        
        Company.getCompanies()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData() {
        
    }
}

//MARK: Table View Delegate and DataSource Methods

extension CompaniesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! companyCell
        if indexPath.row == 0 {
            cell.logoView.image = UIImage(named: "microsoftLogo.jpg")
            cell.nameLabel.text = "Microsoft"
            return cell
            
        } else if indexPath.row == 1 {
            cell.logoView.image = UIImage(named: "AmazonLogo.png")
            cell.nameLabel.text = "Amazon"
            return cell
        } else  {
            cell.logoView.image = UIImage(named: "ubisoftLogo.jpg")
            cell.nameLabel.text = "Ubisoft"
            return cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "moreDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "moreDetail" {
            if let destination_VC = segue.destination as? MoreDetailVC {
            let testComp = Company()
            testComp.name = "Microsoft"
            testComp.logo = UIImage(named: "microsoftLogo.jpg")
            testComp.description = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
            testComp.tags = ["Full Stack Engineer", "iOS Dev", "Andriod Dev", "PR Manager"]
            destination_VC.company = testComp
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

