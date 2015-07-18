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
    
    func testElement() {
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
        
        let element2 = SquareElement<String, String>(x: 2, y: 2, content: "content", contact: "contact")
        XCTAssertEqual(element2.x, 2)
        XCTAssertEqual(element2.y, 2)
        XCTAssertNotNil(element2.content)
        XCTAssertEqual(element2.content!, "content")
        XCTAssertNotNil(element2.contact)
        XCTAssertEqual(element2.contact!, "contact")
    }
    
    func testSquareElement() {
        let element1 = SquareElement<String, String>(x: 0, y: 0)
        XCTAssertEqual(element1.x, 0)
        XCTAssertEqual(element1.y, 0)
        XCTAssertEqual(element1.frame, CGRect(x: 0, y: 0, width: 20, height: 20))
        XCTAssertEqual(element1.center, CGPoint(x: 10, y: 10))
        XCTAssertEqual(element1.vertices.count, 4)
        XCTAssertEqual(element1.vertices, [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)])
        
        let element2 = SquareElement<String, String>(x: 2, y: 2)
        XCTAssertEqual(element2.x, 2)
        XCTAssertEqual(element2.y, 2)
        XCTAssertEqual(element2.frame, CGRect(x: 40, y: 40, width: 20, height: 20))
        XCTAssertEqual(element2.center, CGPoint(x: 50, y: 50))
        XCTAssertEqual(element2.vertices.count, 4)
        XCTAssertEqual(element2.vertices, [CGPoint(x: 40, y: 40), CGPoint(x: 40, y: 60), CGPoint(x: 60, y: 60), CGPoint(x: 60, y: 40)])
        
        let elements1: Set<SquareElement<String, String>> = SquareElement<String, String>.elementsInRect(CGRect(x: 0, y: 0, width: 20, height: 20))
        XCTAssertEqual(elements1.count, 4)
        XCTAssert(elements1.contains(SquareElement<String, String>(x: 0, y: 0)))
        XCTAssert(elements1.contains(SquareElement<String, String>(x: 1, y: 0)))
        XCTAssert(elements1.contains(SquareElement<String, String>(x: 0, y: 1)))
        XCTAssert(elements1.contains(SquareElement<String, String>(x: 1, y: 1)))
        
        let elements2: Set<SquareElement<String, String>> = SquareElement<String, String>.elementsInRect(CGRect(x: 10, y: 10, width: 30, height: 30))
        XCTAssertEqual(elements1.count, 4)
        XCTAssert(elements2.contains(SquareElement<String, String>(x: 0, y: 0)))
        XCTAssert(elements2.contains(SquareElement<String, String>(x: 1, y: 0)))
        XCTAssert(elements2.contains(SquareElement<String, String>(x: 0, y: 1)))
        XCTAssert(elements2.contains(SquareElement<String, String>(x: 1, y: 1)))
    }
    
    func testTriangularElement() {
        let element1 = TriangularElement<String, String>(x: 0, y: 0)
        XCTAssertEqual(element1.x, 0)
        XCTAssertEqual(element1.y, 0)
        XCTAssertEqual(element1.frame, CGRect(x: 0, y: 0, width: 20, height: 20))
        XCTAssertEqual(element1.center, CGPoint(x: 10, y: 10))
        XCTAssertEqual(element1.vertices.count, 3)
        XCTAssertEqual(element1.vertices, [CGPoint(x: 0, y: 0), CGPoint(x: 10, y: 20), CGPoint(x: 20, y: 0)])
        
        let element2 = TriangularElement<String, String>(x: 1, y: 1)
        XCTAssertEqual(element2.x, 1)
        XCTAssertEqual(element2.y, 1)
        XCTAssertEqual(element2.frame, CGRect(x: 10, y: 20, width: 20, height: 20))
        XCTAssertEqual(element2.center, CGPoint(x: 20, y: 30))
        XCTAssertEqual(element2.vertices.count, 3)
        XCTAssertEqual(element2.vertices, [CGPoint(x: 10, y: 20), CGPoint(x: 20, y: 40), CGPoint(x: 30, y: 20)])
        
        let element3 = TriangularElement<String, String>(x: 2, y: 1)
        XCTAssertEqual(element3.x, 2)
        XCTAssertEqual(element3.y, 1)
        XCTAssertEqual(element3.frame, CGRect(x: 20, y: 20, width: 20, height: 20))
        XCTAssertEqual(element3.center, CGPoint(x: 30, y: 30))
        XCTAssertEqual(element3.vertices.count, 3)
        XCTAssertEqual(element3.vertices, [CGPoint(x: 30, y: 20), CGPoint(x: 20, y: 40), CGPoint(x: 40, y: 40)])
        
        let elements1: Set<TriangularElement<String, String>> = TriangularElement<String, String>.elementsInRect(CGRect(x: 0, y: 0, width: 20, height: 20))
        XCTAssertEqual(elements1.count, 7)
        XCTAssert(elements1.contains(TriangularElement<String, String>(x: -1, y: 0)))
        XCTAssert(elements1.contains(TriangularElement<String, String>(x: 0, y: 0)))
        XCTAssert(elements1.contains(TriangularElement<String, String>(x: 1, y: 0)))
        XCTAssert(elements1.contains(TriangularElement<String, String>(x: 2, y: 0)))
        XCTAssert(elements1.contains(TriangularElement<String, String>(x: -1, y: 1)))
        XCTAssert(elements1.contains(TriangularElement<String, String>(x: 0, y: 1)))
        XCTAssert(elements1.contains(TriangularElement<String, String>(x: 1, y: 1)))

        let elements2: Set<TriangularElement<String, String>> = TriangularElement<String, String>.elementsInRect(CGRect(x: 10, y: 10, width: 30, height: 30))
        XCTAssertEqual(elements2.count, 8)
        XCTAssert(elements2.contains(TriangularElement<String, String>(x: -1, y: 0)))
        XCTAssert(elements2.contains(TriangularElement<String, String>(x: 0, y: 0)))
        XCTAssert(elements2.contains(TriangularElement<String, String>(x: 1, y: 0)))
        XCTAssert(elements2.contains(TriangularElement<String, String>(x: 2, y: 0)))
        XCTAssert(elements2.contains(TriangularElement<String, String>(x: -1, y: 1)))
        XCTAssert(elements2.contains(TriangularElement<String, String>(x: 0, y: 1)))
        XCTAssert(elements2.contains(TriangularElement<String, String>(x: 1, y: 1)))
        XCTAssert(elements2.contains(TriangularElement<String, String>(x: 2, y: 1)))
    }
}
