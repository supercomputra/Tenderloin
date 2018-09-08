//
//  ProductCell+ViewConstructor.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 08/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

extension ProductCell {
    
    private func getImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(data: (product?.imageData)!)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8.0
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        imageView.matchRatio(ratio: 1)
        return imageView
    }
    
    private func getInfoView() -> UIStackView {
        guard let product = product else {
            fatalError("""
                Product is found nil.
                Please never call getInfoView from outside of didSet method of product attribute.
                """
            )
        }
        let nameLabel = UILabel(text: product.name)
        nameLabel.numberOfLines = 0
        
        let shopNameLabel = UILabel(text: "by " + product.shop.name, font: UIFont.systemFont(ofSize: 12))
        shopNameLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        let priceLabel = UILabel(text: product.price, font: UIFont.systemFont(ofSize: 20))
        
        let headerView = UIStackView(arrangedSubviews: [nameLabel, shopNameLabel], axis: .vertical, spacing: 2)
        let infoView = UIStackView(arrangedSubviews: [headerView, priceLabel], axis: .vertical)
        return infoView
    }
    
    func setShadowBasedOnPosition() {
        guard let position = position else { return }
        let radius: CGFloat = 8.0
        switch position {
        case .top:
            setShadow([.topLeft, .topRight], radius: radius)
        case .bottom:
            setShadow([.bottomLeft, .bottomRight], radius: radius)
        default:
            setShadow()
        }
    }
    
    private func setShadow(_ corners: UIRectCorner = [], radius: CGFloat = 0, withShadow: Bool = true) {
        var path: CGPath?
        
        if corners == [] {
            path = UIBezierPath(rect: bounds).cgPath
        } else {
            path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        }
        
        if withShadow {
            layer.masksToBounds = false
            layer.shadowColor = UIColor.gray.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowRadius = 2.0
            layer.shadowOpacity = 0.5
            layer.shadowPath = path!
        }
        
        let mask = CAShapeLayer()
        mask.path = path!
        contentView.layer.mask = mask

    }
    
    func setUp() {
        guard product != nil else {
            return
        }
        let imageView = getImageView()
        let stackView = UIStackView(arrangedSubviews: [imageView, getInfoView()], axis: .horizontal)
        contentView.addSubview(stackView)
        stackView.matchSuperviewSize(withPadding: 16.0)
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.masksToBounds = true
        contentView.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
