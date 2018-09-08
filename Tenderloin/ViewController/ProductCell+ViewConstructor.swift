//
//  ProductCell+ViewConstructor.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 08/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

extension ProductCell {
    private func getLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        return label
    }
    
    private func getInfoView() -> UIStackView {
        guard let product = product else {
            fatalError("""
                Product is found nil.
                Please never call getInfoView from outside of didSet method of product attribute.
                """
            )
        }
        let nameLabel = getLabel(product.name)
        let shopNameLabel = getLabel(product.shop.name)
        let priceLabel = getLabel(product.price)
        let infoView = UIStackView(arrangedSubviews: [nameLabel, shopNameLabel, priceLabel], axis: .vertical)
        return infoView
    }
    
    private func setShadow() {
        contentView.layer.cornerRadius = 8.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.5
        layer.cornerRadius = contentView.layer.cornerRadius
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    func setUp() {
        guard product != nil else {
            return
        }
        let stackView = UIStackView(arrangedSubviews: [imageView, getInfoView()], axis: .horizontal)
        contentView.addSubview(stackView)
        stackView.matchSuperviewSize(withPadding: 16.0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setShadow()
    }
}
