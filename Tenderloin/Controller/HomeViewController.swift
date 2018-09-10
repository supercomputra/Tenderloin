//
//  HomeViewController.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 10/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let searchBar: TenderloinSearchBar = {
        let field = TenderloinSearchBar()
        return field
    }()
    
    let tenderloinSearchTitle: UILabel = {
        let label = UILabel(text: "Tenderloin Search", font: UIFont.systemFont(ofSize: 24.0, weight: .semibold))
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    var stackView: UIStackView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
        
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = TokopediaColor.main
        stackView = UIStackView(arrangedSubviews: [tenderloinSearchTitle, searchBar], axis: .vertical, distribution: .fillProportionally)
        view.addSubview(stackView)
        searchBar.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        stackView.spacing = 16.0
        stackView.matchSuperviewWidth(withPadding: 32.0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        hideNavigationBar()
        searchBar.delegate = self
        guard let navigationController = navigationController else {
            fatalError("""
                TenderloinViewController doesn't have a navigationController.
                Make sure the TenderloinViewController has been set as a root of a UINavigationController.
                """
            )
        }
        let navigationBarHeight = navigationController.navigationBar.frame.size.height
        stackView.matchSuperviewTopAnchor(withPadding: 2 * navigationBarHeight)
    }
    
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        pushToTenderloinViewController()
        return true
    }
    
    func hideNavigationBar() {
        guard let navigationController = navigationController else {
            fatalError("""
                TenderloinViewController doesn't have a navigationController.
                Make sure the TenderloinViewController has been set as a root of a UINavigationController.
                """
            )
        }
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.view.backgroundColor = .clear
    }
    
    func pushToTenderloinViewController() {
        let networkController = NetworkController()
        let layout = UICollectionViewFlowLayout()
        let viewController = TenderloinViewController(networkController: networkController, layout: layout)
        viewController.keyword = searchBar.text
        guard let navigationController = self.navigationController else {
            fatalError()
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
