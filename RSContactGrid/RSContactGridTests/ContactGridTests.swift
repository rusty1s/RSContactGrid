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
    
    func testAddPolygon() {
        var grid1 = Grid<SquareElement>()
        grid1.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)], allowInsertingElements: false) { var element = $0; element.contact = true; return element }
        
        XCTAssert(grid1.isEmpty)
        
        grid1.insertAtX(0, y: 0)
        grid1.insertAtX(1, y: 0)
        grid1.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)], allowInsertingElements: false) { var element = $0; element.contact = true; return element }
        
        XCTAssertFalse(grid1.isEmpty)
        XCTAssertEqual(grid1.count, 2)
        XCTAssert(grid1[0,0] != nil)
        XCTAssertNotNil(grid1[0,0]!.contact)
        XCTAssertEqual(grid1[0,0]!.contact as! Bool, true)
        XCTAssert(grid1[1,0] != nil)
        XCTAssertNotNil(grid1[1,0]!.contact)
        XCTAssertEqual(grid1[1,0]!.contact as! Bool, true)
        
        // disabled
    }
    
    func testAddPolygonInSquareGrid() {
        var grid1 = Grid<SquareElement>()
        grid1.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)], allowInsertingElements: true) { var element = $0; element.contact = true; return element }
        
        XCTAssertFalse(grid1.isEmpty)
        XCTAssertEqual(grid1.count, 4)
        XCTAssert(grid1[0,0] != nil)
        XCTAssertNotNil(grid1[0,0]!.contact)
        XCTAssertEqual(grid1[0,0]!.contact as! Bool, true)
        XCTAssert(grid1[0,1] != nil)
        XCTAssertNotNil(grid1[0,1]!.contact)
        XCTAssertEqual(grid1[0,1]!.contact as! Bool, true)
        XCTAssert(grid1[1,1] != nil)
        XCTAssertNotNil(grid1[1,1]!.contact)
        XCTAssertEqual(grid1[1,1]!.contact as! Bool, true)
        XCTAssert(grid1[1,0] != nil)
        XCTAssertNotNil(grid1[1,0]!.contact)
        XCTAssertEqual(grid1[1,0]!.contact as! Bool, true)
        
        
        
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
        
        /*grid.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 30, y: 30), CGPoint(x: 60, y: 0)]) { (segment: ContactGrid.Segment, var edge: ContactGrid.Segment.Edge) in
            edge.contactBody = true
        }*/
    }
}
