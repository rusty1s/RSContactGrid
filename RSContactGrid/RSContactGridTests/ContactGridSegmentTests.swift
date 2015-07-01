//
//  ContactGridSegmentTests.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 30.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import XCTest
import RSContactGrid

class ContactGridSegmentTests: XCTestCase {
    
    func testSegment() {
        var segment = ContactGrid.Segment(x: 0, y: 0)
        XCTAssertEqual(segment.x, 0)
        XCTAssertEqual(segment.y, 0)
        XCTAssertEqual(segment.frame, CGRect(x: 0, y: 0, width: 20, height: 20))
        
        XCTAssertEqual(segment.remainingEdges.count, 4)
        XCTAssertEqual(segment.edgesWithContentBody.count, 0)
        XCTAssertEqual(segment.edgesWithContactBody.count, 0)
        XCTAssertEqual(segment.deletedEdges.count, 0)
        
        let edge = ContactGrid.Segment.Edge(value: .Left, contentBody: nil, contactBody: "foo")
        segment.remainingEdges.insert(edge)
        XCTAssertEqual(segment.remainingEdges.count, 4)
        XCTAssertEqual(segment.edgesWithContentBody.count, 0)
        XCTAssertEqual(segment.edgesWithContactBody.count, 1)
        XCTAssertEqual(segment.deletedEdges.count, 0)
        
        segment.remainingEdges.removeFirst()
        XCTAssertEqual(segment.remainingEdges.count, 3)
        XCTAssertEqual(segment.edgesWithContentBody.count, 0)
        XCTAssertLessThanOrEqual(segment.edgesWithContactBody.count, 1)
        XCTAssertEqual(segment.deletedEdges.count, 1)
        
        var newSegment = ContactGrid.Segment(x: 0, y: 0)
        XCTAssertEqual(segment.hashValue, newSegment.hashValue)
        XCTAssertEqual(segment, newSegment)
        
        newSegment = ContactGrid.Segment(x: 1, y: 0)
        XCTAssertNotEqual(segment.hashValue, newSegment.hashValue)
        XCTAssertLessThan(segment, newSegment)
    }
}
