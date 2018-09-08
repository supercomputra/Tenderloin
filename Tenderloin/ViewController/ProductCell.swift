//
//  ProductCell.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 07/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

enum ProductCellPosition {
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
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        position = nil
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
    }
}
