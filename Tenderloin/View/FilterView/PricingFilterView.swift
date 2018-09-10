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
    
    public var pricingSlider: RangeSlider = {
        let slider = RangeSlider(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64.0))
        slider.minimumValue = 0.0
        slider.maximumValue = 10000000.0
        let minPrice = UserDefaults.standard.object(forKey: "minPrice") as? Int ?? 0
        slider.lowerValue = Double(minPrice)
        let maxPrice = UserDefaults.standard.object(forKey: "maxPrice") as? Int ?? 10000000
        slider.upperValue = Double(maxPrice)
        slider.upperValue = 10000000
        slider.trackHighlightTintColor = TokopediaColor.main
        return slider
    }()
    
    var minPriceStackView: UIStackView = {
        let minPriceLabel = UILabel(text: "Min Price", font: UIFont.systemFont(ofSize: 14.0, weight: .regular))
        let minPrice = UserDefaults.standard.object(forKey: "minPrice") as? Int ?? 0
        let minPriceNumberLabel = UILabel(text: "Rp \(minPrice)", font: UIFont.systemFont(ofSize: 18.0, weight: .medium))
        minPriceNumberLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        let minPriceStackView = UIStackView(arrangedSubviews: [minPriceLabel, minPriceNumberLabel], axis: .vertical, distribution: .fillProportionally)
        minPriceStackView.spacing = 8
        return minPriceStackView
    }()
    
    var maxPriceStackView: UIStackView = {
        let maxPriceLabel = UILabel(text: "Max Price", font: UIFont.systemFont(ofSize: 14.0, weight: .regular))
        maxPriceLabel.textAlignment = .right
        let maxPrice = UserDefaults.standard.object(forKey: "maxPrice") as? Int ?? 10000000
        let maxPriceNumberLabel = UILabel(text: "Rp \(maxPrice)", font: UIFont.systemFont(ofSize: 18.0, weight: .medium))
        maxPriceNumberLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        maxPriceNumberLabel.textAlignment = .right
        let maxPriceStackView = UIStackView(arrangedSubviews: [maxPriceLabel, maxPriceNumberLabel], axis: .vertical, distribution: .fillProportionally)
        maxPriceStackView.spacing = 8
        return maxPriceStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pricingSlider.addTarget(self, action: #selector(onSliderValChanged(sender:forEvent:)), for: .valueChanged)
        pricingSlider.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        
        let pricingIndicatorStackView = UIStackView(arrangedSubviews: [minPriceStackView, maxPriceStackView], axis: .horizontal, distribution: .fillEqually)
        let stackView = UIStackView(arrangedSubviews: [pricingIndicatorStackView, pricingSlider], axis: .vertical, distribution: .fillProportionally)
        addSubview(stackView)
        pricingIndicatorStackView.matchSuperviewWidth()
        stackView.matchSuperviewSize()
        pricingIndicatorStackView.translatesAutoresizingMaskIntoConstraints = false
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
