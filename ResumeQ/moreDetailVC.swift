//
//  moreDetailVC.swift
//  ResumeQ
//
//  Created by Ben Cootner on 10/22/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import UIKit

class moreDetailVC: UIViewController {

    var company: Company?
    
    @IBOutlet var imageView: UIImageView!

    @IBOutlet var descriptionView: UITextView!
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = company?.logo
        descriptionView.text = company?.description
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.collectionView.flashScrollIndicators()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//MARK Collection View 
extension moreDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return company?.tags?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! tagCell
        cell.textLabel.text = company?.tags?[indexPath.row]
        return cell
    }
    
  
}

