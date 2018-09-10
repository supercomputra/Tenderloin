//
//  FilterViewController.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 09/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    static let height: CGFloat = 438
    static let padding: CGFloat = 8

    private var initialTouchPoint: CGPoint?
    
    var tenderloinViewControllerSetupDelegate: TenderloinViewControllerSetupDelegate!
    
    let headerView: UIStackView = {
        let filterLabel = UILabel(text: "Filter", font: UIFont.systemFont(ofSize: 24.0, weight: .bold))
        let resetButton = UIButton(type: UIButtonType.custom)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        resetButton.setTitleColor(TokopediaColor.main, for: .normal)
        return UIStackView(arrangedSubviews: [filterLabel, resetButton], axis: .horizontal, distribution: .equalSpacing)
    }()
    
    let gestureView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 16))
        return view
    }()
    
    private let bottomWhiteSpace: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 16))
        return view
    }()
    
    var pricingFilterView: PricingFilterView?
    
    var wholsaleFilterView: UIStackView = {
        let label = UILabel(text: "Wholesale", font: UIFont.systemFont(ofSize: 18, weight: .regular))
        let switcher = UISwitch(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        switcher.onTintColor = TokopediaColor.main
        let isWholesale = UserDefaults.standard.object(forKey: "isWholesale") as? Bool ?? false
        switcher.isOn = isWholesale
        let view = UIStackView(arrangedSubviews: [label, switcher], axis: .horizontal, distribution: .equalSpacing)
        view.alignment = .center
        view.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        return view
    }()
    
    var goldMerchantFilterView: UIStackView = {
        let label = UILabel(text: "Gold Merchant", font: UIFont.systemFont(ofSize: 18, weight: .regular))
        let switcher = UISwitch(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        switcher.onTintColor = TokopediaColor.main
        let isGoldMerchant = UserDefaults.standard.object(forKey: "isGoldMerchant") as? Bool ?? false
        switcher.isOn = isGoldMerchant
        let view = UIStackView(arrangedSubviews: [label, switcher], axis: .horizontal, distribution: .equalSpacing)
        view.alignment = .center
        view.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        return view
    }()
    
    var officialStoreFilterView: UIStackView = {
        let label = UILabel(text: "Official Store", font: UIFont.systemFont(ofSize: 18, weight: .regular))
        let switcher = UISwitch(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let isOfficialStore = UserDefaults.standard.object(forKey: "isOfficialStore") as? Bool ?? false
        switcher.isOn = isOfficialStore
        let view = UIStackView(arrangedSubviews: [label, switcher], axis: .horizontal, distribution: .equalSpacing)
        view.alignment = .center
        
        view.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        return view
    }()
    
    private var applyButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = TokopediaColor.action
        button.layer.cornerRadius = 8.0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pricingFilterView = PricingFilterView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let controlsStackView = UIStackView(arrangedSubviews: [pricingFilterView!, wholsaleFilterView, goldMerchantFilterView, officialStoreFilterView], axis: .vertical, distribution: .fillProportionally)
        controlsStackView.spacing = 24.0
        let contentStackView = UIStackView(arrangedSubviews: [headerView, controlsStackView, applyButton], axis: .vertical, distribution: .fillProportionally)
        contentStackView.spacing = 24.0
        let stackView = UIStackView(arrangedSubviews: [gestureView, contentStackView, bottomWhiteSpace], axis: .vertical, distribution: .equalSpacing)
        applyButton.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        applyButton.addTarget(self, action: #selector(apply), for: .touchUpInside)
        addSubview(stackView)
        gestureView.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
        bottomWhiteSpace.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        stackView.spacing = 0
        stackView.matchSuperviewWidth(withPadding: 24.0)
        stackView.matchSuperviewTopAnchor(withPadding: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        gestureView.addGestureRecognizer(panGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 16.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func apply() {
        tenderloinViewControllerSetupDelegate.setFilter(self, reset: false)
        animateToDismiss()
    }
    
    @objc private func reset() {
        tenderloinViewControllerSetupDelegate.setFilter(self, reset: true)
        animateToDismiss()
    }
    
    private func animateToDismiss() {
        guard let superview = self.superview else {
            fatalError("""
                    The view doesn't have superview.
                    Could not animate if the FilterView doesn't have superview.
                    """
            )
        }
        UIView.animate(withDuration: 0.3, animations: {
            superview.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0)
            self.frame = CGRect(x: FilterView.padding, y: UIScreen.main.bounds.height, width: self.frame.size.width, height: self.frame.size.height)
        }) { _ in
            superview.removeFromSuperview()
        }
    }
    
    private func bounceBackToInitialPosition(completionHandler: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: FilterView.padding, y: UIScreen.main.bounds.height - FilterView.height - 8, width: self.frame.size.width, height: FilterView.height)
        }) { _ in
            guard let handler = completionHandler else {
                return
            }
            handler()
        }
    }
    
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.superview)
        
        if sender.state == UIGestureRecognizerState.began {
            initialTouchPoint = CGPoint(x: touchPoint.x, y: touchPoint.y)
        } else if sender.state == UIGestureRecognizerState.changed {
            guard self.initialTouchPoint != nil else { return }
            if touchPoint.y <= UIScreen.main.bounds.height - FilterView.height  {
                frame = CGRect(x: FilterView.padding, y: touchPoint.y, width: frame.size.width, height: UIScreen.main.bounds.height - touchPoint.y - FilterView.padding)
            } else {
                frame = CGRect(x: FilterView.padding, y: touchPoint.y, width: frame.size.width, height: FilterView.height)
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            guard let initialTouchPoint = self.initialTouchPoint else { return }
            if touchPoint.y - initialTouchPoint.y > 100 {
                animateToDismiss()
            } else {
                bounceBackToInitialPosition {
                    self.initialTouchPoint = nil
                }
            }
        }
    }
}
