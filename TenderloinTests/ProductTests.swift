//
//  ProductTests.swift
//  TenderloinTests
//
//  Created by Zulwiyoza Putra on 08/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import XCTest
@testable import Tenderloin

class ProductTests: XCTestCase {
    
    private let shop = {
        return Shop(name: "Samsung Cemerlang", isGold: true)
    }()
    var product: Product?
    
    override func setUp() {
        super.setUp()
        product = Product(name: "Samsung", price: "Rp 32.000", shop: shop)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProductNotNil() {
        XCTAssertNotNil(product)
    }
    
    func testProductHasValidAttribute() {
        guard let product = product else { return }
        XCTAssertNotNil(product.name)
        XCTAssertEqual(product.name, "Samsung")
        XCTAssertNotNil(product.price)
        XCTAssertEqual(product.price, "Rp 32.000")
        XCTAssertNotNil(product.shop)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
