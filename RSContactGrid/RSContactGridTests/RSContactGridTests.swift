//
//  RSContactGridTests.swift
//  RSContactGridTests
//
//  Created by Matthias Fey on 22.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import XCTest

class RSContactGridTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let array = Array<Int>()
        print(array)
        print(array.debugDescription)
        
        let set = Set<Int>()
        print(set)
        print(set.debugDescription)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
