//
//  SwiftTestTests.swift
//  SwiftTestTests
//
//  Created by Ranjan on 25/12/17.
//  Copyright © 2017 Ranjan. All rights reserved.
//

import XCTest
@testable import SwiftTest

class SwiftTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test_title_in_news() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewC = storyboard.instantiateInitialViewController() as! ViewController
        viewC.newsCollection.append(NewsModal.init(mainHeadline: "1", subHeadline: "2", author: "3", date: "4"))
        let newsX = viewC.newsCollection.first
        XCTAssertEqual("1", newsX?.mainHeadline)
        XCTAssertEqual("2", newsX?.subHeadline)
        XCTAssertEqual("3", newsX?.author)
        XCTAssertEqual("4", newsX?.date)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
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
