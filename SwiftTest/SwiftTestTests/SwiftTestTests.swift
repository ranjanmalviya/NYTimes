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
    
    var sessionUnderTest: URLSession!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
        
    }
    
    func testTitleINews() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewC = storyboard.instantiateInitialViewController() as! ViewController
        viewC.newsCollection.append(NewsModal.init(mainHeadline: "1", subHeadline: "2", author: "3", date: "4"))
        let newsX = viewC.newsCollection.first
        XCTAssertEqual("1", newsX?.mainHeadline)
        XCTAssertEqual("2", newsX?.subHeadline)
        XCTAssertEqual("3", newsX?.author)
        XCTAssertEqual("4", newsX?.date)
    }
    
    
    
    // Asynchronous test: success fast, failure slow
    func testValidCallToNyTimesGetsHTTPStatusCode200() {
        // given
        let url = URL(string:"http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=")
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 150, handler: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
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
