//
//  SFSafariViewController.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 10/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import SafariServices

extension SFSafariViewController {
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .default
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
}
