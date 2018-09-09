//
//  UICollectionViewCell+setShadow.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 09/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

extension UIView {
    func setShadow(_ corners: UIRectCorner = [], radius: CGFloat = 0, withShadow: Bool = true) {
        guard let superview = superview else {
            fatalError("""
                The view doesn't have superview.
                Make sure the view has been added as a subview to another view.
                """
            )
        }
        var path: CGPath?
        
        if corners == [] {
            path = UIBezierPath(rect: bounds).cgPath
        } else {
            path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        }
        
        if withShadow {
            superview.layer.masksToBounds = false
            superview.layer.shadowColor = UIColor.gray.cgColor
            superview.layer.shadowOffset = CGSize(width: 0, height: 0)
            superview.layer.shadowRadius = 2.0
            superview.layer.shadowOpacity = 0.5
            superview.layer.shadowPath = path!
        }
        
        let mask = CAShapeLayer()
        mask.path = path!
        self.layer.mask = mask
    }
}
