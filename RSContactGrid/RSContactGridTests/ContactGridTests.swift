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
        var grid1 = Grid<SquareTile<Bool, Bool>>()
        grid1.detectContactedTilesOfPath([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)], closedPath: true, allowInsertingTiles: false) { $0.data.contact = true }
        
        XCTAssert(grid1.isEmpty)
        grid1.insertAtX(0, y: 0)
        grid1.insertAtX(1, y: 0)
        grid1.detectContactedTilesOfPath([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)], closedPath: true, allowInsertingTiles: false) { $0.data.contact = true }
        
        XCTAssertFalse(grid1.isEmpty)
        XCTAssertEqual(grid1.count, 2)
        XCTAssert(grid1[0,0] != nil)
        XCTAssertNotNil(grid1[0,0]!.data.contact)
        XCTAssertEqual(grid1[0,0]!.data.contact!, true)
        XCTAssert(grid1[1,0] != nil)
        XCTAssertNotNil(grid1[1,0]!.data.contact)
        XCTAssertEqual(grid1[1,0]!.data.contact!, true)
    }
    
    func testAddPolygonInTriangularGrid() {
        
        var grid = Grid<TriangularTile<Bool, Bool>>()
        grid.detectContactedTilesOfPath([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
        
        XCTAssertEqual(grid.count, 7)
        XCTAssert(grid[-1,0] != nil)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,0] != nil)
        XCTAssert(grid[2,0] != nil)
        XCTAssert(grid[-1,1] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[1,1] != nil)
        
        grid.removeAll()
        grid.detectContactedTilesOfPath([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 30), CGPoint(x: 30, y: 30), CGPoint(x: 30, y: 0)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
        
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
        grid.detectContactedTilesOfPath([CGPoint(x: 15, y: 10), CGPoint(x: 30, y: 25), CGPoint(x: 45, y: 10)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
        
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
        grid.detectContactedTilesOfPath([CGPoint(x: 0, y: 0), CGPoint(x: 30, y: 30), CGPoint(x: 60, y: 0)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
        
        XCTAssertEqual(grid.count, 10)
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
        var grid = Grid<SquareTile<Bool, Bool>>()
        grid.detectContactedTilesOfPath([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
 
        XCTAssertEqual(grid.count, 3)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[1,0] != nil)
        
        grid.removeAll()
        grid.detectContactedTilesOfPath([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 30), CGPoint(x: 30, y: 30), CGPoint(x: 30, y: 0)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
        
        XCTAssertEqual(grid.count, 4)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[1,1] != nil)
        XCTAssert(grid[1,0] != nil)
        
        grid.removeAll()
        grid.detectContactedTilesOfPath([CGPoint(x: 15, y: 10), CGPoint(x: 30, y: 25), CGPoint(x: 45, y: 10)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
        
        XCTAssertEqual(grid.count, 4)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,1] != nil)
        XCTAssert(grid[2,0] != nil)
        XCTAssert(grid[1,0] != nil)
        
        grid.removeAll()
        grid.detectContactedTilesOfPath([CGPoint(x: 0, y: 0), CGPoint(x: 30, y: 30), CGPoint(x: 60, y: 0)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
        
        XCTAssertEqual(grid.count, 4)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,1] != nil)
        XCTAssert(grid[2,0] != nil)
        XCTAssert(grid[1,0] != nil)
    }
    
    func testAddPolygonInRotatedSquareGrid() {
        var grid = Grid<RotatedSquareTile<Bool, Bool>>()
        grid.detectContactedTilesOfPath([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }

        XCTAssertEqual(grid.count, 7)
        XCTAssert(grid[-1,-1] != nil)
        XCTAssert(grid[0,-1] != nil)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,0] != nil)
        XCTAssert(grid[-1,1] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[0,2] != nil)
        
        grid.removeAll()
        grid.detectContactedTilesOfPath([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 30), CGPoint(x: 30, y: 30), CGPoint(x: 30, y: 0)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
        
        XCTAssertEqual(grid.count, 12)
        XCTAssert(grid[-1,-1] != nil)
        XCTAssert(grid[0,-1] != nil)
        XCTAssert(grid[1,-1] != nil)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,0] != nil)
        XCTAssert(grid[-1,1] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[1,1] != nil)
        XCTAssert(grid[0,2] != nil)
        XCTAssert(grid[1,2] != nil)
        XCTAssert(grid[-1,3] != nil)
        XCTAssert(grid[0,3] != nil)

        grid.removeAll()
        grid.detectContactedTilesOfPath([CGPoint(x: 15, y: 10), CGPoint(x: 30, y: 25), CGPoint(x: 45, y: 10)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
        
        XCTAssertEqual(grid.count, 6)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,0] != nil)
        XCTAssert(grid[2,0] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[1,1] != nil)
        XCTAssert(grid[1,2] != nil)

        grid.removeAll()
        grid.detectContactedTilesOfPath([CGPoint(x: 0, y: 0), CGPoint(x: 30, y: 30), CGPoint(x: 60, y: 0)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
    
        XCTAssertEqual(grid.count, 10)
        XCTAssert(grid[-1,-1] != nil)
        XCTAssert(grid[0,-1] != nil)
        XCTAssert(grid[1,-1] != nil)
        XCTAssert(grid[2,-1] != nil)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,0] != nil)
        XCTAssert(grid[2,0] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[1,1] != nil)
        XCTAssert(grid[1,2] != nil)
    }
    
    func testAddPolygonInHexagonalGrid() {
        var grid = Grid<HexagonalTile<Bool, Bool>>()
        grid.detectContactedTilesOfPath([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
        
        XCTAssertEqual(grid.count, 6)
        XCTAssert(grid[-1,-1] != nil)
        XCTAssert(grid[0,-1] != nil)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[-1,1] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[0,2] != nil)
        
        grid.removeAll()
        grid.detectContactedTilesOfPath([CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 30), CGPoint(x: 30, y: 30), CGPoint(x: 30, y: 0)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
        
        XCTAssertEqual(grid.count, 10)
        XCTAssert(grid[-1,-1] != nil)
        XCTAssert(grid[0,-1] != nil)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,0] != nil)
        XCTAssert(grid[-1,1] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[0,2] != nil)
        XCTAssert(grid[1,2] != nil)
        XCTAssert(grid[-1,3] != nil)
        XCTAssert(grid[0,3] != nil)
        
        grid.removeAll()
        grid.detectContactedTilesOfPath([CGPoint(x: 15, y: 10), CGPoint(x: 30, y: 25), CGPoint(x: 45, y: 10)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
        
        XCTAssertEqual(grid.count, 4)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,0] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[1,2] != nil)
        
        grid.removeAll()
        grid.detectContactedTilesOfPath([CGPoint(x: 0, y: 0), CGPoint(x: 30, y: 30), CGPoint(x: 60, y: 0)], closedPath: true, allowInsertingTiles: true) { $0.data.contact = true }
        
        XCTAssertEqual(grid.count, 8)
        XCTAssert(grid[-1,-1] != nil)
        XCTAssert(grid[0,-1] != nil)
        XCTAssert(grid[1,-1] != nil)
        XCTAssert(grid[0,0] != nil)
        XCTAssert(grid[1,0] != nil)
        XCTAssert(grid[0,1] != nil)
        XCTAssert(grid[1,1] != nil)
        XCTAssert(grid[1,2] != nil)
    }
}
