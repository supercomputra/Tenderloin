//
//  ViewConstraintLayout.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 07/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

extension UIView {
    func matchSuperviewSize(withPadding padding: CGFloat = 0) {
        matchSuperviewWidth(withPadding: padding)
        matchSuperviewHeight(withPadding: padding)
    }
    
    func matchRatio(ratio: CGFloat) {
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio).isActive = true
    }
    
    func matchSuperviewHeight(withPadding padding: CGFloat = 0) {
        guard let superview = superview else {
            fatalError("""
                The view doesn't have superview.
                Make sure the view has been added as a subview to another view.
                """
            )
        }
        topAnchor.constraint(equalTo: superview.topAnchor, constant: padding).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding).isActive = true
    }
    
    func matchSuperviewWidth(withPadding padding: CGFloat = 0) {
        guard let superview = superview else {
            fatalError("""
                The view doesn't have superview.
                Make sure the view has been added as a subview to another view.
                """
            )
        }
        leftAnchor.constraint(equalTo: superview.leftAnchor, constant: padding).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -padding).isActive = true
    }
}
