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
    
    func test_title_in_Cell() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let login = storyboard.instantiateInitialViewController() as! ViewController
        login.newsCollection.append(NewsModal.init(mainHeadline: "1", subHeadline: "2", author: "3", date: "4"))
        
        login.listView.reloadData()
        let cell = login.listView.cellForRow(at:IndexPath(row: 0, section: 0) ) as! NyViewCell
        XCTAssertEqual("1", cell.mainLabel!.text!)
        XCTAssertEqual("2", cell.subLabel!.text!)
        XCTAssertEqual("3", cell.authorLabel!.text!)
        XCTAssertEqual("4", cell.dateLabel!.text!)
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
