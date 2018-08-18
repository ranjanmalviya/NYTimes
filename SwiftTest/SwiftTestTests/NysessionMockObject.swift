//
//  NysessionMockObject.swift
//  SwiftTestTests
//
//  Created by Ranjan on 18/08/18.
//  Copyright © 2018 Ranjan. All rights reserved.
//

import XCTest
@testable import SwiftTest

class NysessionMockObject: XCTestCase {
    
    var controllerUnderTest: ViewController!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controllerUnderTest = storyboard.instantiateInitialViewController() as! ViewController
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "nytimes", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        let url = URL(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=d84bea1f0a9d42378053ccd767456b83")
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
        
        controllerUnderTest.defaultSession = sessionMock
        

    }
    
    // Fake URLSession with DHURLSession protocol and stubs
    func testResultsAndParsesData() {
        // given
        let promise = expectation(description: "Status code: 200")
        
        
        let url = URL(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=")
        let dataTask = controllerUnderTest?.defaultSession.dataTask(with: url!) {
            data, response, error in
            // if HTTP request is successful, call updateSearchResults(_:) which parses the response data into Tracks
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    promise.fulfill()
                    self.controllerUnderTest?.updateNewsData(data)
                }
            }
        }
        dataTask?.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
    }

    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        controllerUnderTest = nil
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
