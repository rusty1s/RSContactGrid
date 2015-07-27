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
    
    func testAddPolygonInTriangularGrid() {
        
        var grid = Grid<TriangularElement<Bool, Bool>>()
        grid.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)], allowInsertingElements: true) { var element = $0; element.contact = true; return element }
        
        XCTAssertEqual(grid.count, 7)
        XCTAssert(grid[-1,0] != nil)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,0] != nil)
        XCTAssert(grid[2,0] != nil)
        XCTAssert(grid[-1,1] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[1,1] != nil)
        
        grid.removeAll()
        grid.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 30), CGPoint(x: 30, y: 30), CGPoint(x: 30, y: 0)], allowInsertingElements: true) { var element = $0; element.contact = true; return element }
        
        XCTAssertEqual(grid.count, 10)
        XCTAssert(grid[-1,0] != nil)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,0] != nil)
        XCTAssert(grid[2,0] != nil)
        XCTAssert(grid[3,0] != nil)
        XCTAssert(grid[-1,1] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[1,1] != nil)
        XCTAssert(grid[2,1] != nil)
        XCTAssert(grid[3,1] != nil)
        
        grid.removeAll()
        grid.addPolygon([CGPoint(x: 15, y: 10), CGPoint(x: 30, y: 25), CGPoint(x: 45, y: 10)], allowInsertingElements: true) { var element = $0; element.contact = true; return element }
        
        XCTAssertEqual(grid.count, 8)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,0] != nil)
        XCTAssert(grid[2,0] != nil)
        XCTAssert(grid[3,0] != nil)
        XCTAssert(grid[4,0] != nil)
        XCTAssert(grid[1,1] != nil)
        XCTAssert(grid[2,1] != nil)
        XCTAssert(grid[2,1] != nil)
        
        grid.removeAll()
        grid.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 30, y: 30), CGPoint(x: 60, y: 0)], allowInsertingElements: true) { var element = $0; element.contact = true; return element }
        
        XCTAssertEqual(grid.count, 10)
        print(grid)
        XCTAssert(grid[-1,0] != nil)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,0] != nil)
        XCTAssert(grid[2,0] != nil)
        XCTAssert(grid[3,0] != nil)
        XCTAssert(grid[4,0] != nil)
        XCTAssert(grid[5,0] != nil)
        XCTAssert(grid[1,1] != nil)
        XCTAssert(grid[2,1] != nil)
        XCTAssert(grid[3,1] != nil)
    }
    
    func testAddPolygonInSquareGrid() {
        var grid = Grid<SquareElement<Bool, Bool>>()
        grid.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)], allowInsertingElements: true) { var element = $0; element.contact = true; return element }
 
        XCTAssertEqual(grid.count, 3)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[1,0] != nil)
        
        grid.removeAll()
        grid.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 30), CGPoint(x: 30, y: 30), CGPoint(x: 30, y: 0)], allowInsertingElements: true) { var element = $0; element.contact = true; return element }
        
        XCTAssertEqual(grid.count, 4)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[1,1] != nil)
        XCTAssert(grid[1,0] != nil)
        
        grid.removeAll()
        grid.addPolygon([CGPoint(x: 15, y: 10), CGPoint(x: 30, y: 25), CGPoint(x: 45, y: 10)], allowInsertingElements: true) { var element = $0; element.contact = true; return element }
        
        XCTAssertEqual(grid.count, 4)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,1] != nil)
        XCTAssert(grid[2,0] != nil)
        XCTAssert(grid[1,0] != nil)
        
        grid.removeAll()
        grid.addPolygon([CGPoint(x: 0, y: 0), CGPoint(x: 30, y: 30), CGPoint(x: 60, y: 0)], allowInsertingElements: true) { var element = $0; element.contact = true; return element }
        
        XCTAssertEqual(grid.count, 4)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,1] != nil)
        XCTAssert(grid[2,0] != nil)
        XCTAssert(grid[1,0] != nil)
    }
}
