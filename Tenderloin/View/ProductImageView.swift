//
//  ProductImageView.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 09/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

class ProductImageView: UIImageView {
    
    init(data: Data) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        image = UIImage(data: data)
        contentMode = .scaleAspectFill
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        clipsToBounds = true
        backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        matchRatio(ratio: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
