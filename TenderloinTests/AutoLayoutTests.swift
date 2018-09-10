//
//  AutoLayoutTests.swift
//  TenderloinTests
//
//  Created by Zulwiyoza Putra on 07/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import XCTest
@testable import Tenderloin

class AutoLayoutTests: XCTestCase {
    
    var stackView: UIStackView?
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Test Label"
        return label
    }()
    
    override func setUp() {
        super.setUp()
        stackView = UIStackView(arrangedSubviews: [label])
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStackViewHasArrangedSubviews() {
        guard let stackView = stackView else { fatalError() }
        XCTAssertNotNil(stackView.arrangedSubviews.count)
        XCTAssertEqual(stackView.arrangedSubviews, [label])
    }
    
    func testStackViewHasCustomizedAxis() {
        let horizontalStackView = UIStackView(arrangedSubviews: [label], axis: .horizontal, distribution: .fill)
        
        XCTAssertEqual(horizontalStackView.axis, .horizontal)
        let verticalStackView = UIStackView(arrangedSubviews: [label], axis: .vertical, distribution: .fill)
        XCTAssertEqual(verticalStackView.axis, .vertical)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
