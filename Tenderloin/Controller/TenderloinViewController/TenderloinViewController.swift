//
//  TenderloinViewController.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 07/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

class TenderloinViewController: UICollectionViewController {
    let cellIdentifier = "ProductCell"
    
    var networkController: NetworkController!
    
    let filterView = FilterView()
    
    var products: [Product]? {
        didSet {
            DispatchQueue.main.async {
                guard let collectionView = self.collectionView else {
                    fatalError("""
                        TenderloinViewController doesn't have a collectionView.
                        Make sure TenderloinViewController subclasses UICollectionViewContrller
                        """
                    )
                }
                collectionView.reloadData()
            }
        }
    }
    
    
    
    init(networkController: NetworkController, layout: UICollectionViewFlowLayout) {
        super.init(collectionViewLayout: layout)
        self.networkController = networkController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

extension TenderloinViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let products = products else {
            return 0
        }
        return products.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProductCell
        guard let products = products else {
            return cell
        }
        let product = products[indexPath.row]
        cell.product = product
        if indexPath.row == 0 {
            cell.position = .top
        } else if indexPath.row == products.count - 1 {
            cell.position = .bottom
        } else {
            cell.position = .middle
        }
        return cell
    }
}





