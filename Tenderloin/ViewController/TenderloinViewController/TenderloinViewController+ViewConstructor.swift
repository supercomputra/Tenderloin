//
//  TenderloinViewController+ViewConstructor.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 09/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

extension TenderloinViewController {
    func setUp() {
        setNavigationController()
        setCollectionView()
        getProducts { (products: [Product]?) in
            self.products = products
        }
    }
    
    private func setNavigationController(withTitle title: String = "Home") {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        guard appDelegate.window != nil else {
            print("""
                The app delegate window is remaining nil.
                Please set the window in AppDelegate to present a viewController.
                Ignore this if you are on unit test.
                """
            )
            return
        }
        guard let navigationController = navigationController else {
            fatalError("""
                TenderloinViewController doesn't have a navigationController.
                Make sure the TenderloinViewController has been set as a root of a UINavigationController.
                """
            )
        }
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.title = title
    }
    
    private func setCollectionView() {
        guard let collectionView = collectionView else {
            fatalError("""
                TenderloinViewController doesn't have a collectionView.
                Make sure TenderloinViewController subclasses UICollectionViewContrller
                """
            )
        }
        
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSpacing: CGFloat = 16.0
        let itemsInOneLine: CGFloat = 1
        let width = UIScreen.main.bounds.size.width - itemSpacing * CGFloat(itemsInOneLine + 1)
        let height: CGFloat = 128
        flow.sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
        flow.itemSize = CGSize(width: floor(width/itemsInOneLine), height: height)
        flow.minimumInteritemSpacing = 16
        flow.minimumLineSpacing = 8
        
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
