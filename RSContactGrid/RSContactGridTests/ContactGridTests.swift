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
        var grid1 = Grid<SquareElement<Bool, Bool>>()
        grid1.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)], allowInsertingElements: false) { return $0 }
        
        XCTAssert(grid1.isEmpty)
        grid1.insertAtX(0, y: 0)
        grid1.insertAtX(1, y: 0)
        grid1.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)], allowInsertingElements: false) { var element = $0; element.contact = true; return element }
        
        XCTAssertFalse(grid1.isEmpty)
        XCTAssertEqual(grid1.count, 2)
        XCTAssert(grid1[0,0] != nil)
        XCTAssertNotNil(grid1[0,0]!.contact)
        XCTAssertEqual(grid1[0,0]!.contact!, true)
        XCTAssert(grid1[1,0] != nil)
        XCTAssertNotNil(grid1[1,0]!.contact)
        XCTAssertEqual(grid1[1,0]!.contact!, true)
    }
    
    func testAddPolygonInSquareGrid() {
        var grid1 = Grid<SquareElement<Bool, Bool>>()
        grid1.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)], allowInsertingElements: true) { var element = $0; element.contact = true; return element }
        
        XCTAssertFalse(grid1.isEmpty)
        XCTAssertEqual(grid1.count, 4)
        XCTAssert(grid1[0,0] != nil)
        XCTAssertNotNil(grid1[0,0]!.contact)
        XCTAssertEqual(grid1[0,0]!.contact!, true)
        XCTAssert(grid1[0,1] != nil)
        XCTAssertNotNil(grid1[0,1]!.contact)
        XCTAssertEqual(grid1[0,1]!.contact!, true)
        XCTAssert(grid1[1,1] != nil)
        XCTAssertNotNil(grid1[1,1]!.contact)
        XCTAssertEqual(grid1[1,1]!.contact!, true)
        XCTAssert(grid1[1,0] != nil)
        XCTAssertNotNil(grid1[1,0]!.contact)
        XCTAssertEqual(grid1[1,0]!.contact!, true)
        
        var grid2 = Grid<SquareElement<Bool, Bool>>()
        grid2.addPolygon([CGPoint(x: 15, y: 10), CGPoint(x: 30, y: 25), CGPoint(x: 45, y: 10)], allowInsertingElements: true) { var element = $0; element.contact = true; return element }
        
        XCTAssertFalse(grid2.isEmpty)
        XCTAssertEqual(grid2.count, 4)
        XCTAssert(grid2[0,0] != nil)
        XCTAssertNotNil(grid2[0,0]!.contact)
        XCTAssertEqual(grid2[0,0]!.contact!, true)
        XCTAssert(grid2[1,1] != nil)
        XCTAssertNotNil(grid2[1,1]!.contact)
        XCTAssertEqual(grid2[1,1]!.contact!, true)
        XCTAssert(grid2[2,0] != nil)
        XCTAssertNotNil(grid2[2,0]!.contact)
        XCTAssertEqual(grid2[2,0]!.contact!, true)
        XCTAssert(grid2[1,0] != nil)
        XCTAssertNotNil(grid2[1,0]!.contact)
        XCTAssertEqual(grid2[1,0]!.contact!, true)
        
        var grid3 = Grid<SquareElement<Bool, Bool>>()
        grid3.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 30, y: 30), CGPoint(x: 60, y: 0)], allowInsertingElements: true) { var element = $0; element.contact = true; return element }
        
        XCTAssertFalse(grid3.isEmpty)
        XCTAssertEqual(grid3.count, 6)
        XCTAssert(grid3[0,0] != nil)
        XCTAssertNotNil(grid3[0,0]!.contact)
        XCTAssertEqual(grid3[0,0]!.contact!, true)
        XCTAssert(grid3[1,1] != nil)
        XCTAssertNotNil(grid3[1,1]!.contact)
        XCTAssertEqual(grid3[1,1]!.contact!, true)
        XCTAssert(grid3[2,1] != nil)
        XCTAssertNotNil(grid3[2,1]!.contact)
        XCTAssertEqual(grid3[2,1]!.contact!, true)
        XCTAssert(grid3[2,0] != nil)
        XCTAssertNotNil(grid3[2,0]!.contact)
        XCTAssertEqual(grid3[2,0]!.contact!, true)
        XCTAssert(grid3[3,0] != nil)
        XCTAssertNotNil(grid3[3,0]!.contact)
        XCTAssertEqual(grid3[3,0]!.contact!, true)
        XCTAssert(grid3[1,0] != nil)
        XCTAssertNotNil(grid3[1,0]!.contact)
        XCTAssertEqual(grid3[1,0]!.contact!, true)
    }
}
