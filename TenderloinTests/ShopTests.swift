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
        shop = Shop(id: 1, name: "Samsung Cemerlang")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShopHasValidAttribute() {
        guard let shop = shop else { fatalError() }
        XCTAssertNotNil(shop.name)
        XCTAssertEqual(shop.name, "Samsung Cemerlang")
        
    }
    
    func testShopIsDecodable() {
        let dict: [String: Any] = [
            "id": 1,
            "name": "Samsung Cemerlang"
        ]
        let data = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let shop = try! JSONDecoder().decode(Shop.self, from: data)
        XCTAssertNotNil(shop.id)
        XCTAssertEqual(shop.id, 1)
        XCTAssertNotNil(shop.name)
        XCTAssertEqual(shop.name, "Samsung Cemerlang")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
