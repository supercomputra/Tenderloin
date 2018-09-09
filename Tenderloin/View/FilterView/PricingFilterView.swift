//
//  PricingFilterView.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 09/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit
import WARangeSlider

class PricingFilterView: UIView {
    
    public var pricingSlider: RangeSlider?
    
    private var minPriceStackView: UIStackView = {
        let minPriceLabel = UILabel(text: "Minimum Price", font: UIFont.systemFont(ofSize: 16.0, weight: .regular))
        let minPriceNumberLabel = UILabel(text: "Rp 0", font: UIFont.systemFont(ofSize: 20.0, weight: .medium))
        let minPriceStackView = UIStackView(arrangedSubviews: [minPriceLabel, minPriceNumberLabel], axis: .vertical, distribution: .fillProportionally)
        minPriceStackView.spacing = 8
        return minPriceStackView
    }()
    
    private var maxPriceStackView: UIStackView = {
        let maxPriceLabel = UILabel(text: "Maximum Price", font: UIFont.systemFont(ofSize: 16.0, weight: .regular))
        maxPriceLabel.textAlignment = .right
        let maxPriceNumberLabel = UILabel(text: "Rp 10000000", font: UIFont.systemFont(ofSize: 20.0, weight: .medium))
        maxPriceNumberLabel.textAlignment = .right
        let maxPriceStackView = UIStackView(arrangedSubviews: [maxPriceLabel, maxPriceNumberLabel], axis: .vertical, distribution: .fillProportionally)
        maxPriceStackView.spacing = 8
        return maxPriceStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let pricingIndicatorStackView = UIStackView(arrangedSubviews: [minPriceStackView, maxPriceStackView], axis: .horizontal, distribution: .fillEqually)
        pricingSlider = RangeSlider(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 64.0))
        pricingSlider?.minimumValue = 0.0
        pricingSlider?.maximumValue = 10000000.0
        pricingSlider?.lowerValue = 0
        pricingSlider?.upperValue = 10000000
        pricingSlider!.addTarget(self, action: #selector(onSliderValChanged(sender:forEvent:)), for: .valueChanged)
        pricingSlider?.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [pricingIndicatorStackView, pricingSlider!], axis: .vertical, distribution: .fillProportionally)
        addSubview(stackView)
        
        stackView.matchSuperviewSize()
        stackView.spacing = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func onSliderValChanged(sender: Any, forEvent event: UIEvent) {
        let slider = sender as! RangeSlider
        let minPriceNumberLabel = minPriceStackView.arrangedSubviews[1] as! UILabel
        minPriceNumberLabel.text = "Rp \(Int(slider.lowerValue))"
        
        let maxPriceNumberLabel = maxPriceStackView.arrangedSubviews[1] as! UILabel
        maxPriceNumberLabel.text = "Rp \(Int(slider.upperValue))"
    }
}
