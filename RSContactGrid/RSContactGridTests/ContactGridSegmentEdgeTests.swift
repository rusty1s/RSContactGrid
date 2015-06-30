//
//  ContactGridSegmentEdgeTests.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 30.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import XCTest
import RSContactGrid

class ContactGridSegmentEdgeTests: XCTestCase {
    
    func testEdge() {
        let edge1 = ContactGrid.Segment.Edge(value: .Left)
        let edge2 = ContactGrid.Segment.Edge(value: .Top, content: nil, contactedObject: "foo")
        let edge3 = ContactGrid.Segment.Edge(rawValue: 1)
        let edge4 = ContactGrid.Segment.Edge(rawValue: 5)
        
        XCTAssert(edge3 != nil)
        XCTAssert(edge4 == nil)
        
        XCTAssertEqual(edge1.hashValue, edge3!.hashValue)
        XCTAssertEqual(edge1, edge3!)
        XCTAssertNotEqual(edge1.hashValue, edge2.hashValue)
        XCTAssertNotEqual(edge1, edge2)
        
        XCTAssert(!edge1.hasContent)
        XCTAssert(!edge1.contacted)
        XCTAssert(!edge2.hasContent)
        XCTAssert(edge2.contacted)
        
        XCTAssertEqual(ContactGrid.Segment.Edge.allValues.count, 4)
        XCTAssertEqual(ContactGrid.Segment.Edge.allValues, Set([.Left, .Top, .Right, .Bottom]))
    }
}
