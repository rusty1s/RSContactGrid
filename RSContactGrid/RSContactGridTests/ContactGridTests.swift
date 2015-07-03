//
//  ContactGridTests.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 30.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import XCTest
import RSContactGrid

class ContactGridTests: XCTestCase {
    
    var grid: ContactGrid!
    
    override func setUp() {
        super.setUp()
        
        grid = ContactGrid()
    }
    
    func testAddPolygon() {
        /*grid.addPolygon([CGPoint(x: 15, y: 10), CGPoint(x: 30, y: 25), CGPoint(x: 45, y: 10)]) { (segment: ContactGrid.Segment, var edge: ContactGrid.Segment.Edge) in
            edge.contactBody = true
        }*/
        
        /*XCTAssertEqual(grid.count, 4)
        XCTAssert(grid[0, 0] != nil)
        XCTAssert(grid[1, 0] != nil)
        XCTAssert(grid[1, 1] != nil)
        XCTAssert(grid[2, 0] != nil)
        XCTAssertEqual(grid[0, 0]!.edgesWithContactBody.count, 1)
        XCTAssertEqual(Set(grid[0, 0]!.edgesWithContactBody.map { $0.value }), Set([ContactGrid.Segment.Edge.Value.Right]))
        XCTAssertEqual(grid[1, 0]!.edgesWithContactBody.count, 3)
        XCTAssertEqual(Set(grid[1, 0]!.edgesWithContactBody.map { $0.value }), Set([ContactGrid.Segment.Edge.Value.Left, .Right, .Top]))
        XCTAssertEqual(grid[2, 0]!.edgesWithContactBody.count, 1)
        XCTAssertEqual(Set(grid[2, 0]!.edgesWithContactBody.map { $0.value }), Set([ContactGrid.Segment.Edge.Value.Left]))
        XCTAssertEqual(grid[1, 1]!.edgesWithContactBody.count, 1)
        XCTAssertEqual(Set(grid[1, 1]!.edgesWithContactBody.map { $0.value }), Set([ContactGrid.Segment.Edge.Value.Bottom]))*/
        
        grid.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 30, y: 30), CGPoint(x: 60, y: 0)]) { (segment: ContactGrid.Segment, var edge: ContactGrid.Segment.Edge) in
            edge.contactBody = true
        }
    }
}
