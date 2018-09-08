//
//  BadgeTests.swift
//  TenderloinTests
//
//  Created by Zulwiyoza Putra on 08/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import XCTest

class BadgeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGoldBadgeTypeHasValidAttribute() {
        let gold = BadgeType.gold
        XCTAssertEqual(gold.getBadge().title, "Gold Merchant")
        XCTAssertEqual(gold.getBadge().imageURI, "https://ecs7.tokopedia.net/img/gold-active-large.png")
        XCTAssertTrue(gold.getBadge().show)
    }
    
    func testOfficialBadgeTypeHasValidAttribute() {
        let gold = BadgeType.official
        XCTAssertEqual(gold.getBadge().title, "Official Store")
        XCTAssertEqual(gold.getBadge().imageURI, "https://ecs7.tokopedia.net/img/official_store/badge_official.png")
        XCTAssertTrue(gold.getBadge().show)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
