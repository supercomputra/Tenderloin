//
//  FilterViewController.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 09/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    private var initialTouchPoint: CGPoint = {
        let screenHeight = UIScreen.main.bounds.height
        let inset = screenHeight - (screenHeight * 2 / 3)
        return CGPoint(x: 0, y: screenHeight - inset)
    }()
    
    let headerView: UIStackView = {
        let filterLabel = UILabel(text: "Filter", font: UIFont.systemFont(ofSize: 20.0, weight: .medium))
        let resetButton = UIButton(type: UIButtonType.custom)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.blue, for: .normal)
        return UIStackView(arrangedSubviews: [filterLabel, resetButton], axis: .horizontal, distribution: .equalSpacing)
    }()
    
    let pricingSettingView: UIStackView = {
        let minPriceLabel = UILabel(text: "Minimum Price", font: UIFont.systemFont(ofSize: 16.0, weight: .regular))
        let minPriceNumberLabel = UILabel(text: "Rp 0", font: UIFont.systemFont(ofSize: 16.0, weight: .medium))
        let minPriceStackView = UIStackView(arrangedSubviews: [minPriceLabel, minPriceNumberLabel], axis: .vertical, distribution: .fillProportionally)
        
        let maxPriceLabel = UILabel(text: "Maximum Price", font: UIFont.systemFont(ofSize: 16.0, weight: .regular))
        maxPriceLabel.textAlignment = .right
        let maxPriceNumberLabel = UILabel(text: "Rp 10.000.000", font: UIFont.systemFont(ofSize: 16.0, weight: .medium))
        maxPriceNumberLabel.textAlignment = .right
        let maxPriceStackView = UIStackView(arrangedSubviews: [maxPriceLabel, maxPriceNumberLabel], axis: .vertical, distribution: .fillProportionally)
        
        let pricingSettingLabel = UIStackView(arrangedSubviews: [minPriceStackView, maxPriceStackView], axis: .horizontal, distribution: .fillEqually)
        return pricingSettingLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let stackView = UIStackView(arrangedSubviews: [headerView, pricingSettingView], axis: .vertical, distribution: .fillProportionally)
        self.addSubview(stackView)
        stackView.matchSuperviewWidth(withPadding: 16.0)
        stackView.matchSuperviewTopAnchor(withPadding: 16.0)
        stackView.spacing = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        addGestureRecognizer(panGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Work in Progress
    // TODO: Fix this animation
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.window)
        let initialPoint = CGPoint(x: 0, y: UIScreen.main.bounds.height - (UIScreen.main.bounds.height * 2 / 3))
        if sender.state == UIGestureRecognizerState.began {
            initialTouchPoint = CGPoint(x: 0, y: touchPoint.y - initialTouchPoint.y)
        } else if sender.state == UIGestureRecognizerState.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: frame.size.width, height: frame.size.height - initialTouchPoint.y + touchPoint.y)
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.superview?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0)
                    self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: self.frame.size.width, height: self.frame.size.height)
                }) { _ in
                    self.superview?.removeFromSuperview()
                }
            } else {
                initialTouchPoint = initialPoint
                UIView.animate(withDuration: 0.3, animations: {
                    self.frame = CGRect(x: 0, y: initialPoint.y, width: self.frame.size.width, height: self.frame.size.height)
                })
            }
        }
    }
}
