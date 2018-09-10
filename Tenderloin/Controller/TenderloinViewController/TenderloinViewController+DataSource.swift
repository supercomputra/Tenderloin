//
//  TenderloinViewController+DataSource.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 09/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import Foundation

extension TenderloinViewController {
    typealias GetProductsCompletionHandler = ((_ products: [Product]?) -> Void)?
    
    func getProducts(startingIndex: Int = 0, completionHandler: GetProductsCompletionHandler = nil) {
        let isWholeSale = UserDefaults.standard.object(forKey: "isWholeSale") as! Bool
        // WIP: Work in progress for gold merchant filter
        // TODO: Handle whether a shop has Gold Merchant Badge or not
        // let isGoldMerchant = UserDefaults.standard.object(forKey: "isGoldMerchant") as! Bool
        let isOfficialStore = UserDefaults.standard.object(forKey: "isOfficialStore") as! Bool
        let minPrice = UserDefaults.standard.object(forKey: "minPrice") ?? 0
        let maxPrice = UserDefaults.standard.object(forKey: "maxPrice") ?? 0
        let numberOfGolds = 2

        networkController.searchProducts(key: self.keyword ?? "Philips", minPrice: "\(minPrice)", maxPrice: "\(maxPrice)", isWholesale: isWholeSale, isOfficial: isOfficialStore, golds: numberOfGolds, startingIndex: startingIndex, items: 10) { (products: [Product]?, errorMessage: String?) in
            if let errorMessage = errorMessage, errorMessage != "" {
                if let handler = completionHandler {
                    handler(nil)
                }
            }
            
            if let products = products {
                if let handler = completionHandler {
                    DispatchQueue.global(qos: .userInitiated).async {
                        var productsWithImage: [Product] = []
                        let downloadGroup = DispatchGroup()
                        for product in products {
                            downloadGroup.enter()
                            self.networkController.downloadImage(imageURI: product.imageURI, completionHandler: { (data: Data?, errorMessage: String?) in
                                if let data = data {
                                    var product = product
                                    product.imageData = data
                                    productsWithImage.append(product)
                                }
                                downloadGroup.leave()
                            })
                        }
                        downloadGroup.wait()
                        DispatchQueue.main.async {
                            handler(productsWithImage)
                        }
                    }
                }
            } else {
                if let handler = completionHandler {
                    handler(nil)
                }
            }
        }
    }
}
