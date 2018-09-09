//
//  ProductCell.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 07/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

public enum ProductCellPosition {
    case top
    case bottom
    case middle
}

class ProductCell: UICollectionViewCell {
    var product: Product? {
        didSet {
            setUp()
        }
    }
    
    var position: ProductCellPosition? {
        didSet {
            setShadowBasedOnPosition()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        position = nil
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
    }
}

extension ProductCell {
    fileprivate func setShadowBasedOnPosition() {
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
    
    fileprivate func setUp() {
        guard let product = product else {
            fatalError("""
                Product is found nil.
                Please never call getInfoView from outside of didSet method of product attribute.
                """
            )
        }
        
        guard let productImageData = product.imageData else {
            fatalError("""
                Product imageData is found nil.
                Please make sure imageData has been downloaded before passed into ProductCell.
                """
            )
        }
        
        let imageView = ProductImageView(data: productImageData)
        let productInfoView = ProductInfoStackView(product: product)
        let stackView = UIStackView(arrangedSubviews: [imageView, productInfoView], axis: .horizontal, distribution: .fillProportionally)
        contentView.addSubview(stackView)
        contentView.layer.masksToBounds = true
        contentView.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        stackView.matchSuperviewSize(withPadding: 16.0)
        stackView.spacing = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
}
