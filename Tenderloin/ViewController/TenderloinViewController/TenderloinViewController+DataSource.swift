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
    
    func getProducts(completionHandler: GetProductsCompletionHandler = nil) {
        networkController.searchProducts(key: "Philips", minPrice: "0", maxPrice: "10000", isWholesale: false, isOfficial: true, golds: 3, startingIndex: 0, items: 30) { (products: [Product]?, errorMessage: String?) in
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
            }
        }
    }
}
