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
        guard let superview = superview else {
            fatalError("The view doesn't have superview")
        }
        topAnchor.constraint(equalTo: superview.topAnchor, constant: padding).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding).isActive = true
        leftAnchor.constraint(equalTo: superview.leftAnchor, constant: padding).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -padding).isActive = true
    }
}


extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: UILayoutConstraintAxis, spacing: CGFloat = 16.0) {
        self.init()
        self.distribution = .fillEqually
        self.spacing = spacing
        self.axis = axis
        for view in arrangedSubviews {
            self.addArrangedSubview(view)
        }
    }
}
