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
        return Shop(id: 1, name: "Samsung Cemerlang")
    }()
    var product: Product?
    
    override func setUp() {
        super.setUp()
        product = Product(id: 1, name: "Samsung", price: "Rp 32.000", uri: "https://product.com", shop: shop, imageURI: "", badges: [BadgeType.gold, BadgeType.official])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProductHasValidAttribute() {
        guard let product = product else { fatalError() }
        XCTAssertNotNil(product.id)
        XCTAssertEqual(product.id, 1)
        XCTAssertNotNil(product.name)
        XCTAssertEqual(product.name, "Samsung")
        XCTAssertNotNil(product.price)
        XCTAssertEqual(product.price, "Rp 32.000")
        XCTAssertNotNil(product.uri)
        XCTAssertEqual(product.uri, "https://product.com")
        XCTAssertNotNil(product.imageURI)
        XCTAssertEqual(product.imageURI, "")
        XCTAssertNotNil(product.shop)
        XCTAssertNotNil(product.badges)
        XCTAssertEqual(product.badges, [BadgeType.gold, BadgeType.official])
    }
    
    func testProductIsDecodable() {
        let dict: [String: Any] = [
            "id": 1,
            "name": "Samsung",
            "price": "Rp 32.000",
            "uri": "https://product.com",
            "image_uri": "",
            "badges": [],
            "shop": [
                "id": 1,
                "name": "Samsung Cemerlang"
            ]
        ]
        let data = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let product = try! JSONDecoder().decode(Product.self, from: data)
        XCTAssertNotNil(product.id)
        XCTAssertEqual(product.id, dict["id"] as! Int)
        XCTAssertNotNil(product.name)
        XCTAssertEqual(product.name, dict["name"] as! String)
        XCTAssertNotNil(product.price)
        XCTAssertEqual(product.price, dict["price"] as! String)
        XCTAssertNotNil(product.imageURI)
        XCTAssertEqual(product.imageURI, dict["image_uri"] as! String)
        XCTAssertNotNil(product.shop)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
