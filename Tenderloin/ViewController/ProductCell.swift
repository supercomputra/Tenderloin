//
//  ProductCell.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 07/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    var product: Product? {
        didSet {
            setUp()
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
    }
}

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
    
    private func setUp() {
        guard product != nil else {
            return
        }
        let stackView = UIStackView(arrangedSubviews: [imageView, getInfoView()], axis: .horizontal)
        contentView.addSubview(stackView)
        stackView.matchSuperviewSize(withPadding: 16.0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
