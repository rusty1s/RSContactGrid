//
//  GridElementTests.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 30.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import XCTest
import RSContactGrid

class GridElementTests: XCTestCase {
    
    func testSquareElement() {
        var element1 = SquareElement<String, String>(x: 0, y: 0)
        XCTAssertEqual(element1.x, 0)
        XCTAssertEqual(element1.y, 0)
        XCTAssertNil(element1.content)
        XCTAssertNil(element1.contact)
        element1.content = "content"
        XCTAssertNotNil(element1.content)
        XCTAssertEqual(element1.content!, "content")
        element1.contact = "contact"
        XCTAssertNotNil(element1.contact)
        XCTAssertEqual(element1.contact!, "contact")
        XCTAssertEqual(element1.frame, CGRect(x: 0, y: 0, width: 20, height: 20))
        XCTAssertEqual(element1.center, CGPoint(x: 10, y: 10))
        XCTAssertEqual(element1.vertices.count, 4)
        XCTAssertEqual(element1.vertices, [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)])
        
        let element2 = SquareElement<String, String>(x: 2, y: 2, content: "content", contact: "contact")
        XCTAssertEqual(element2.x, 2)
        XCTAssertEqual(element2.y, 2)
        XCTAssertNotNil(element2.content)
        XCTAssertEqual(element2.content!, "content")
        XCTAssertNotNil(element2.contact)
        XCTAssertEqual(element2.contact!, "contact")
        XCTAssertEqual(element2.frame, CGRect(x: 40, y: 40, width: 20, height: 20))
        XCTAssertEqual(element2.center, CGPoint(x: 50, y: 50))
        XCTAssertEqual(element2.vertices.count, 4)
        XCTAssertEqual(element2.vertices, [CGPoint(x: 40, y: 40), CGPoint(x: 40, y: 60), CGPoint(x: 60, y: 60), CGPoint(x: 60, y: 40)])
    }
}
