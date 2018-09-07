//
//  ShopTests.swift
//  TenderloinTests
//
//  Created by Zulwiyoza Putra on 08/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import XCTest
@testable import Tenderloin

class ShopTests: XCTestCase {
    
    var shop: Shop?
    
    override func setUp() {
        super.setUp()
        shop = Shop(name: "Samsung Cemerlang", isGold: true)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShopNotNil() {
        XCTAssertNotNil(shop)
    }
    
    func testShopHasValidAttribute() {
        guard let shop = shop else { return }
        XCTAssertNotNil(shop.name)
        XCTAssertEqual(shop.name, "Samsung Cemerlang")
        XCTAssertNotNil(shop.isGold)
        XCTAssertTrue(shop.isGold)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
