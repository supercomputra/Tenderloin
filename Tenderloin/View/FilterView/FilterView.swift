//
//  FilterViewController.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 09/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    static let topMargin = UIScreen.main.bounds.height * 1 / 3

    private var initialTouchPoint: CGPoint?
    
    let headerView: UIStackView = {
        let filterLabel = UILabel(text: "Filter", font: UIFont.systemFont(ofSize: 24.0, weight: .bold))
        let resetButton = UIButton(type: UIButtonType.custom)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.blue, for: .normal)
        return UIStackView(arrangedSubviews: [filterLabel, resetButton], axis: .horizontal, distribution: .equalSpacing)
    }()
    
    let gestureView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 16))
        return view
    }()
    
    private var pricingFilterView: PricingFilterView?
    
    private var wholsaleFilterView: UIStackView = {
        let wholesaleLabel = UILabel(text: "Wholesale", font: UIFont.systemFont(ofSize: 16, weight: .regular))
        let wholeSaleSwitch = UISwitch(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let view = UIStackView(arrangedSubviews: [wholesaleLabel, wholeSaleSwitch], axis: .horizontal, distribution: .equalSpacing)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pricingFilterView = PricingFilterView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let contentStackView = UIStackView(arrangedSubviews: [headerView, pricingFilterView!, wholsaleFilterView], axis: .vertical, distribution: .fillProportionally)
        contentStackView.spacing = 32.0
        let stackView = UIStackView(arrangedSubviews: [gestureView, contentStackView], axis: .vertical, distribution: .fillProportionally)
        let contentView = UIView()
        addSubview(contentView)
        contentView.matchSuperviewSize()
        contentView.addSubview(stackView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        gestureView.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        stackView.spacing = 0
        stackView.matchSuperviewWidth(withPadding: 16.0)
        stackView.matchSuperviewTopAnchor(withPadding: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        gestureView.addGestureRecognizer(panGesture)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.superview)
        
        if sender.state == UIGestureRecognizerState.began {
            initialTouchPoint = CGPoint(x: touchPoint.x, y: touchPoint.y)
        } else if sender.state == UIGestureRecognizerState.changed {
            guard let initialTouchPoint = self.initialTouchPoint else { return }
            frame = CGRect(x: 0, y: touchPoint.y, width: frame.size.width, height: UIScreen.main.bounds.height - FilterView.topMargin + touchPoint.y + initialTouchPoint.y)
            
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            guard let initialTouchPoint = self.initialTouchPoint else { return }
            
            if touchPoint.y - initialTouchPoint.y > 100 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.superview?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0)
                    self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: self.frame.size.width, height: self.frame.size.height)
                }) { _ in
                    self.superview?.removeFromSuperview()
                }
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.frame = CGRect(x: 0, y: FilterView.topMargin, width: self.frame.size.width, height: UIScreen.main.bounds.height - FilterView.topMargin)
                }) { _ in
                    self.initialTouchPoint = nil
                }
            }
        }
    }
}
