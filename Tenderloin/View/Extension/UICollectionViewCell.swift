//
//  UICollectionViewCell+setShadow.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 09/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    func setShadow(_ corners: UIRectCorner = [], radius: CGFloat = 0, withShadow: Bool = true) {
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
}
