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
        let filterBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(presentFilterView))
        filterBarButtonItem.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = filterBarButtonItem
        navigationItem.title = title
        let textAttr = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.titleTextAttributes = textAttr
        navigationController.navigationBar.barTintColor = TokopediaColor.main
    }
    
    @objc private func presentFilterView() {
        let containerView = UIView(frame: UIScreen.main.bounds)
        containerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0)
        let window = UIApplication.shared.keyWindow!
        containerView.addSubview(filterView)
        window.addSubview(containerView)
        filterView.frame = CGRect(x: 8, y: UIScreen.main.bounds.height, width: containerView.frame.width - 16, height: FilterView.height)

        UIView.animate(withDuration: 0.3, animations: {
            containerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.6)
            self.filterView.frame.origin.y -= (FilterView.height + 8)
        })
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
        collectionView.backgroundColor = TokopediaColor.background
    }
}
