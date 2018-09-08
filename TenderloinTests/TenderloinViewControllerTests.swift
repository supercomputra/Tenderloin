//
//  TenderloinViewControllerTests.swift
//  TenderloinViewControllerTests
//
//  Created by Zulwiyoza Putra on 07/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import XCTest
@testable import Tenderloin

class TenderloinViewControllerTests: XCTestCase {
    
    var viewController: TenderloinViewController?
    
    override func setUp() {
        super.setUp()
        let networkController = NetworkController()
        viewController = TenderloinViewController(networkController: networkController, layout: UICollectionViewFlowLayout())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewControllerNotNil() {
        XCTAssertNotNil(viewController)
    }
    
    func testGetProductsRequestSuccess() {
        let expect = expectation(description: "Success getting products")
        viewController!.getProducts { (products: [Product]?) in
            XCTAssertNotNil(products)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 3) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    
    func testCollectionViewHasCorrectInset() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
