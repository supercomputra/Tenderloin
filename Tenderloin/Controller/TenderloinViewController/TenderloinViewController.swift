//
//  TenderloinViewController.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 07/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import UIKit
import SafariServices

class TenderloinViewController: UICollectionViewController {
    let cellIdentifier = "ProductCell"
    
    var keyword: String?
    
    var networkController: NetworkController!
    
    private var isEndOfTheResult = false
    
    let filterView = FilterView()
    
    let noProductsFoundLabel = UILabel(text: "No Products Found", font: UIFont.systemFont(ofSize: 16.0))
    
    var products: [Product]? {
        didSet {
            DispatchQueue.main.async {
                guard self.products != nil, self.products?.count != 0 else {
                    self.setNoProductsFoundLabel()
                    return
                }
                
                guard let collectionView = self.collectionView else {
                    fatalError("""
                        TenderloinViewController doesn't have a collectionView.
                        Make sure TenderloinViewController subclasses UICollectionViewContrller
                        """
                    )
                }
                collectionView.reloadData()
            }
        }
    }
    
    
    
    init(networkController: NetworkController, layout: UICollectionViewFlowLayout) {
        super.init(collectionViewLayout: layout)
        self.networkController = networkController
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

protocol TenderloinViewControllerSetupDelegate {
    func setFilter(_ view: FilterView, reset: Bool)
}

extension TenderloinViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let products = self.products else {
            return 0
        }
        if section == 0 {
            if products.count < 10 {
                return products.count
            } else {
                return 10
            }
        } else {
            if products.count % 10 == 0 {
                return 10
            } else {
                return products.count % 10
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProductCell
        guard let products = products else {
            return cell
        }
        
        let productIndex = indexPath.section * 10 + indexPath.row
        let product = products[productIndex]
        cell.product = product
        if indexPath.row == 0 {
            cell.position = .top
        } else if indexPath.row == 9 {
            cell.position = .bottom
        } else {
            if products.count % 10 == indexPath.row + 1 {
                cell.position = .bottom
            } else {
                cell.position = .middle
            }
        }
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let products = self.products else {
            return 0
        }
        if products.count < 10 {
            return 1
        } else {
            return products.count / 10
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let products = self.products else {
            return
        }
        let productIndex = indexPath.section * 10 + indexPath.row
        let url = NSURL(string: products[productIndex].uri)
        let controller = SFSafariViewController(url: url! as URL)
        self.present(controller, animated: true, completion: nil)
    }
}

extension TenderloinViewController {
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let products = self.products else {
            return
        }
        
        let productIndex = indexPath.section * 10 + indexPath.row
        
        guard productIndex == products.count - 1 else {
            return
        }
        
        if indexPath.row == 9 {
            getProducts(startingIndex: products.count) { (extraProducts: [Product]?) in
                if self.products != nil {
                    guard let extraProducts = extraProducts else {
                        self.products = nil
                        return
                    }
                    self.products! += extraProducts
                }
            }
        }
    }
}

extension TenderloinViewController: TenderloinViewControllerSetupDelegate {
    func setFilter(_ view: FilterView, reset: Bool = false) {
        if !reset {
            let wholeSaleSwitcher = view.wholsaleFilterView.arrangedSubviews[1] as! UISwitch
            let isWholeSale = wholeSaleSwitcher.isOn
            UserDefaults.standard.set(isWholeSale, forKey: "isWholeSale")
            
            let goldMerchantSwitcher = view.goldMerchantFilterView.arrangedSubviews[1] as! UISwitch
            let isGoldMerchant = goldMerchantSwitcher.isOn
            UserDefaults.standard.set(isGoldMerchant, forKey: "isGoldMerchant")
            
            let officialStoreSwitcher = view.officialStoreFilterView.arrangedSubviews[1] as! UISwitch
            let isOfficialStore = officialStoreSwitcher.isOn
            UserDefaults.standard.set(isOfficialStore, forKey: "isOfficialStore")
            
            let maxPrice = Int(view.pricingFilterView!.pricingSlider.upperValue)
            let minPrice = Int(view.pricingFilterView!.pricingSlider.lowerValue)
            
            UserDefaults.standard.set(maxPrice, forKey: "maxPrice")
            UserDefaults.standard.set(minPrice, forKey: "minPrice")
        } else {
            UserDefaults.standard.set(false, forKey: "isWholeSale")
            let wholeSaleSwitcher = view.wholsaleFilterView.arrangedSubviews[1] as! UISwitch
            wholeSaleSwitcher.isOn = false
            
            UserDefaults.standard.set(false, forKey: "isGoldMerchant")
            let goldMerchantSwitcher = view.goldMerchantFilterView.arrangedSubviews[1] as! UISwitch
            goldMerchantSwitcher.isOn = false
            
            UserDefaults.standard.set(false, forKey: "isOfficialStore")
            let officialStoreSwitcher = view.officialStoreFilterView.arrangedSubviews[1] as! UISwitch
            officialStoreSwitcher.isOn = false
            
            let minPriceNumberLabel = view.pricingFilterView?.minPriceStackView.arrangedSubviews[1] as? UILabel
            minPriceNumberLabel?.text = "Rp 0"
            UserDefaults.standard.set(0, forKey: "minPrice")
            view.pricingFilterView!.pricingSlider.upperValue = 10000000
            
            view.pricingFilterView!.pricingSlider.lowerValue = 0
            let maxPriceNumberLabel = view.pricingFilterView?.maxPriceStackView.arrangedSubviews[1] as? UILabel
            maxPriceNumberLabel?.text = "Rp 10000000"
            UserDefaults.standard.set(10000000, forKey: "maxPrice")
        }
        products = nil
        collectionView?.reloadData()
        resetProducts()
    }
}







