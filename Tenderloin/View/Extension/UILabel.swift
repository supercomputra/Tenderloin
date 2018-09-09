//
//  UILabel.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 09/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont = UIFont.systemFont(ofSize: 16)) {
        self.init()
        self.text = text
        self.font = font
    }
}
