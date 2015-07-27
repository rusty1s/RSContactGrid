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
        XCTAssertEqual(element3.vertices, [CGPoint(x: 20, y: 40), CGPoint(x: 40, y: 40), CGPoint(x: 30, y: 20)])
        
        let element4 = TriangularElement<String, String>(x: -1, y: 1)
        XCTAssertEqual(element4.x, -1)
        XCTAssertEqual(element4.y, 1)
        XCTAssertEqual(element4.frame, CGRect(x: -10, y: 20, width: 20, height: 20))
        XCTAssertEqual(element4.center, CGPoint(x: 0, y: 30))
        XCTAssertEqual(element4.vertices.count, 3)
        XCTAssertEqual(element4.vertices, [CGPoint(x: -10, y: 20), CGPoint(x: 0, y: 40), CGPoint(x: 10, y: 20)])
        
        let element5 = TriangularElement<String, String>(x: -3, y: 1)
        XCTAssertEqual(element5.x, -3)
        XCTAssertEqual(element5.y, 1)
        XCTAssertEqual(element5.frame, CGRect(x: -30, y: 20, width: 20, height: 20))
        XCTAssertEqual(element5.center, CGPoint(x: -20, y: 30))
        XCTAssertEqual(element5.vertices.count, 3)
        XCTAssertEqual(element5.vertices, [CGPoint(x: -30, y: 20), CGPoint(x: -20, y: 40), CGPoint(x: -10, y: 20)])
        
        let element6 = TriangularElement<String, String>(x: -3, y: 0)
        XCTAssertEqual(element6.x, -3)
        XCTAssertEqual(element6.y, 0)
        XCTAssertEqual(element6.frame, CGRect(x: -30, y: 0, width: 20, height: 20))
        XCTAssertEqual(element6.center, CGPoint(x: -20, y: 10))
        XCTAssertEqual(element6.vertices.count, 3)
        XCTAssertEqual(element6.vertices, [CGPoint(x: -30, y: 20), CGPoint(x: -10, y: 20), CGPoint(x: -20, y: 0)])
        
        let elements: Set<TriangularElement<String, String>> = TriangularElement<String, String>.elementsInRect(CGRect(x: 10, y: 10, width: 40, height: 20))
        XCTAssertEqual(elements.count, 12)
        XCTAssert(elements.contains(TriangularElement<String, String>(x: 0, y: 0)))
        XCTAssert(elements.contains(TriangularElement<String, String>(x: 1, y: 0)))
        XCTAssert(elements.contains(TriangularElement<String, String>(x: 2, y: 0)))
        XCTAssert(elements.contains(TriangularElement<String, String>(x: 3, y: 0)))
        XCTAssert(elements.contains(TriangularElement<String, String>(x: 4, y: 0)))
        XCTAssert(elements.contains(TriangularElement<String, String>(x: 5, y: 0)))
        XCTAssert(elements.contains(TriangularElement<String, String>(x: 0, y: 1)))
        XCTAssert(elements.contains(TriangularElement<String, String>(x: 1, y: 1)))
        XCTAssert(elements.contains(TriangularElement<String, String>(x: 2, y: 1)))
        XCTAssert(elements.contains(TriangularElement<String, String>(x: 3, y: 1)))
        XCTAssert(elements.contains(TriangularElement<String, String>(x: 4, y: 1)))
        XCTAssert(elements.contains(TriangularElement<String, String>(x: 5, y: 1)))
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
        
        let element3 = SquareElement<String, String>(x: -1, y: -1)
        XCTAssertEqual(element3.x, -1)
        XCTAssertEqual(element3.y, -1)
        XCTAssertEqual(element3.frame, CGRect(x: -20, y: -20, width: 20, height: 20))
        XCTAssertEqual(element3.center, CGPoint(x: -10, y: -10))
        XCTAssertEqual(element3.vertices.count, 4)
        XCTAssertEqual(element3.vertices, [CGPoint(x: -20, y: -20), CGPoint(x: -20, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: -20)])
        
        let elements: Set<SquareElement<String, String>> = SquareElement<String, String>.elementsInRect(CGRect(x: 10, y: 10, width: 40, height: 20))
        XCTAssertEqual(elements.count, 6)
        XCTAssert(elements.contains(SquareElement<String, String>(x: 0, y: 0)))
        XCTAssert(elements.contains(SquareElement<String, String>(x: 1, y: 0)))
        XCTAssert(elements.contains(SquareElement<String, String>(x: 2, y: 0)))
        XCTAssert(elements.contains(SquareElement<String, String>(x: 0, y: 1)))
        XCTAssert(elements.contains(SquareElement<String, String>(x: 1, y: 1)))
        XCTAssert(elements.contains(SquareElement<String, String>(x: 1, y: 1)))
    }
    
    func testRotatedSquareElement() {
        let element1 = RotatedSquareElement<String, String>(x: 0, y: 0)
        XCTAssertEqual(element1.x, 0)
        XCTAssertEqual(element1.y, 0)
        XCTAssertEqual(element1.frame, CGRect(x: 0, y: 0, width: 20, height: 20))
        XCTAssertEqual(element1.center, CGPoint(x: 10, y: 10))
        XCTAssertEqual(element1.vertices.count, 4)
        XCTAssertEqual(element1.vertices, [CGPoint(x: 0, y: 10), CGPoint(x: 10, y: 20), CGPoint(x: 20, y: 10), CGPoint(x: 10, y: 0)])
        
        let element2 = RotatedSquareElement<String, String>(x: 0, y: 1)
        XCTAssertEqual(element2.x, 0)
        XCTAssertEqual(element2.y, 1)
        XCTAssertEqual(element2.frame, CGRect(x: 10, y: 10, width: 20, height: 20))
        XCTAssertEqual(element2.center, CGPoint(x: 20, y: 20))
        XCTAssertEqual(element2.vertices.count, 4)
        XCTAssertEqual(element2.vertices, [CGPoint(x: 10, y: 20), CGPoint(x: 20, y: 30), CGPoint(x: 30, y: 20), CGPoint(x: 20, y: 10)])
        
        let element3 = RotatedSquareElement<String, String>(x: 2, y: 3)
        XCTAssertEqual(element3.x, 2)
        XCTAssertEqual(element3.y, 3)
        XCTAssertEqual(element3.frame, CGRect(x: 50, y: 30, width: 20, height: 20))
        XCTAssertEqual(element3.center, CGPoint(x: 60, y: 40))
        XCTAssertEqual(element3.vertices.count, 4)
        XCTAssertEqual(element3.vertices, [CGPoint(x: 50, y: 40), CGPoint(x: 60, y: 50), CGPoint(x: 70, y: 40), CGPoint(x: 60, y: 30)])
        
        let element4 = RotatedSquareElement<String, String>(x: -2, y: 0)
        XCTAssertEqual(element4.x, -2)
        XCTAssertEqual(element4.y, 0)
        XCTAssertEqual(element4.frame, CGRect(x: -40, y: 0, width: 20, height: 20))
        XCTAssertEqual(element4.center, CGPoint(x: -30, y: 10))
        XCTAssertEqual(element4.vertices.count, 4)
        XCTAssertEqual(element4.vertices, [CGPoint(x: -40, y: 10), CGPoint(x: -30, y: 20), CGPoint(x: -20, y: 10), CGPoint(x: -30, y: 0)])
        
        let element5 = RotatedSquareElement<String, String>(x: -1, y: 1)
        XCTAssertEqual(element5.x, -1)
        XCTAssertEqual(element5.y, 1)
        XCTAssertEqual(element5.frame, CGRect(x: -10, y: 10, width: 20, height: 20))
        XCTAssertEqual(element5.center, CGPoint(x: 0, y: 20))
        XCTAssertEqual(element5.vertices.count, 4)
        XCTAssertEqual(element5.vertices, [CGPoint(x: -10, y: 20), CGPoint(x: 0, y: 30), CGPoint(x: 10, y: 20), CGPoint(x: 0, y: 10)])
        
        let element6 = RotatedSquareElement<String, String>(x: -1, y: -1)
        XCTAssertEqual(element6.x, -1)
        XCTAssertEqual(element6.y, -1)
        XCTAssertEqual(element6.frame, CGRect(x: -10, y: -10, width: 20, height: 20))
        XCTAssertEqual(element6.center, CGPoint(x: 0, y: 0))
        XCTAssertEqual(element6.vertices.count, 4)
        XCTAssertEqual(element6.vertices, [CGPoint(x: -10, y: 0), CGPoint(x: 0, y: 10), CGPoint(x: 10, y: 0), CGPoint(x: 0, y: -10)])
        
        let elements: Set<RotatedSquareElement<String, String>> = RotatedSquareElement<String, String>.elementsInRect(CGRect(x: 10, y: 10, width: 40, height: 20))
        XCTAssertEqual(elements.count, 12)
        XCTAssert(elements.contains(RotatedSquareElement<String, String>(x: 0, y: 0)))
        XCTAssert(elements.contains(RotatedSquareElement<String, String>(x: 1, y: 0)))
        XCTAssert(elements.contains(RotatedSquareElement<String, String>(x: 2, y: 0)))
        XCTAssert(elements.contains(RotatedSquareElement<String, String>(x: 0, y: 1)))
        XCTAssert(elements.contains(RotatedSquareElement<String, String>(x: 1, y: 1)))
        XCTAssert(elements.contains(RotatedSquareElement<String, String>(x: 2, y: 1)))
        XCTAssert(elements.contains(RotatedSquareElement<String, String>(x: 0, y: 2)))
        XCTAssert(elements.contains(RotatedSquareElement<String, String>(x: 1, y: 2)))
        XCTAssert(elements.contains(RotatedSquareElement<String, String>(x: 2, y: 2)))
        XCTAssert(elements.contains(RotatedSquareElement<String, String>(x: 0, y: 3)))
        XCTAssert(elements.contains(RotatedSquareElement<String, String>(x: 1, y: 3)))
        XCTAssert(elements.contains(RotatedSquareElement<String, String>(x: 2, y: 3)))
    }
    
    func testHexagonalElement() {
        let element1 = HexagonalElement<String, String>(x: 0, y: 0)
        XCTAssertEqual(element1.x, 0)
        XCTAssertEqual(element1.y, 0)
        XCTAssertEqual(element1.frame, CGRect(x: 0, y: 0, width: 20, height: 20))
        XCTAssertEqual(element1.center, CGPoint(x: 10, y: 10))
        XCTAssertEqual(element1.vertices.count, 6)
        XCTAssertEqual(element1.vertices, [CGPoint(x: 0, y: 10), CGPoint(x: 5, y: 20), CGPoint(x: 15, y: 20), CGPoint(x: 20, y: 10), CGPoint(x: 15, y: 0), CGPoint(x: 5, y: 0)])
        
        let element2 = HexagonalElement<String, String>(x: 0, y: 1)
        XCTAssertEqual(element2.x, 0)
        XCTAssertEqual(element2.y, 1)
        XCTAssertEqual(element2.frame, CGRect(x: 15, y: 10, width: 20, height: 20))
        XCTAssertEqual(element2.center, CGPoint(x: 25, y: 20))
        XCTAssertEqual(element2.vertices.count, 6)
        XCTAssertEqual(element2.vertices, [CGPoint(x: 15, y: 20), CGPoint(x: 20, y: 30), CGPoint(x: 30, y: 30), CGPoint(x: 35, y: 20), CGPoint(x: 30, y: 10), CGPoint(x: 20, y: 10)])
        
        let element3 = HexagonalElement<String, String>(x: 2, y: 3)
        XCTAssertEqual(element3.x, 2)
        XCTAssertEqual(element3.y, 3)
        XCTAssertEqual(element3.frame, CGRect(x: 75, y: 30, width: 20, height: 20))
        XCTAssertEqual(element3.center, CGPoint(x: 85, y: 40))
        XCTAssertEqual(element3.vertices.count, 6)
        XCTAssertEqual(element3.vertices, [CGPoint(x: 75, y: 40), CGPoint(x: 80, y: 50), CGPoint(x: 90, y: 50), CGPoint(x: 95, y: 40), CGPoint(x: 90, y: 30), CGPoint(x: 80, y: 30)])
        
        let elements: Set<HexagonalElement<String, String>> = HexagonalElement<String, String>.elementsInRect(CGRect(x: 10, y: 10, width: 40, height: 20))
        XCTAssertEqual(elements.count, 8)
        XCTAssert(elements.contains(HexagonalElement<String, String>(x: 0, y: 0)))
        XCTAssert(elements.contains(HexagonalElement<String, String>(x: 1, y: 0)))
        XCTAssert(elements.contains(HexagonalElement<String, String>(x: 0, y: 1)))
        XCTAssert(elements.contains(HexagonalElement<String, String>(x: 1, y: 1)))
        XCTAssert(elements.contains(HexagonalElement<String, String>(x: 0, y: 2)))
        XCTAssert(elements.contains(HexagonalElement<String, String>(x: 1, y: 2)))
        XCTAssert(elements.contains(HexagonalElement<String, String>(x: 0, y: 3)))
        XCTAssert(elements.contains(HexagonalElement<String, String>(x: 1, y: 3)))
    }
}
