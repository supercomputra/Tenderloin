//
//  ProductInfoStackView.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 09/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

class ProductInfoStackView: UIStackView {
    
    private var product: Product
    
    init(frame: CGRect, product: Product) {
        self.product = product
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        axis = .vertical
        spacing = 16.0
        distribution = .fillProportionally
        let productNameLabel = UILabel(text: product.name, font: UIFont.systemFont(ofSize: 16.0, weight: .medium))
        let productShopNameLabel = UILabel(text: "by \(product.shop.name)", font: UIFont.systemFont(ofSize: 12.0))
        productShopNameLabel.textColor = UIColor.gray
        let headerView = UIStackView(arrangedSubviews: [productNameLabel, productShopNameLabel], axis: .vertical, distribution: .fillProportionally)
        let priceLabel = UILabel(text: product.price, font: UIFont.systemFont(ofSize: 18.0, weight: .bold))
        priceLabel.textColor = TokopediaColor.action
        addArrangedSubview(headerView)
        addArrangedSubview(priceLabel)
    }
    
    convenience init(product: Product) {
        self.init(frame: UIScreen.main.bounds, product: product)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
