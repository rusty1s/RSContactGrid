//
//  GridtileTests.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 30.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import XCTest
import RSContactGrid

class GridtileTests: XCTestCase {
    
    func testTile() {
        let tile1 = SquareTile<String, String>(x: 0, y: 0)
        XCTAssertEqual(tile1.x, 0)
        XCTAssertEqual(tile1.y, 0)
        XCTAssertNil(tile1.data.content)
        XCTAssertNil(tile1.data.contact)
        tile1.data.content = "content"
        XCTAssertNotNil(tile1.data.content)
        XCTAssertEqual(tile1.data.content!, "content")
        tile1.data.contact = "contact"
        XCTAssertNotNil(tile1.data.contact)
        XCTAssertEqual(tile1.data.contact!, "contact")
        
        let tile2 = SquareTile<String, String>(x: 2, y: 2)
        XCTAssertEqual(tile2.x, 2)
        XCTAssertEqual(tile2.y, 2)
    }
    
    func testTriangularTile() {
        let tile1 = TriangularTile<String, String>(x: 0, y: 0)
        XCTAssertEqual(tile1.x, 0)
        XCTAssertEqual(tile1.y, 0)
        XCTAssertEqual(tile1.frame, CGRect(x: 0, y: 0, width: 20, height: 20))
        XCTAssertEqual(tile1.center, CGPoint(x: 10, y: 10))
        XCTAssertEqual(tile1.vertices.count, 3)
        XCTAssertEqual(tile1.vertices, [CGPoint(x: 0, y: 0), CGPoint(x: 10, y: 20), CGPoint(x: 20, y: 0)])
        
        let tile2 = TriangularTile<String, String>(x: 1, y: 1)
        XCTAssertEqual(tile2.x, 1)
        XCTAssertEqual(tile2.y, 1)
        XCTAssertEqual(tile2.frame, CGRect(x: 10, y: 20, width: 20, height: 20))
        XCTAssertEqual(tile2.center, CGPoint(x: 20, y: 30))
        XCTAssertEqual(tile2.vertices.count, 3)
        XCTAssertEqual(tile2.vertices, [CGPoint(x: 10, y: 20), CGPoint(x: 20, y: 40), CGPoint(x: 30, y: 20)])
        
        let tile3 = TriangularTile<String, String>(x: 2, y: 1)
        XCTAssertEqual(tile3.x, 2)
        XCTAssertEqual(tile3.y, 1)
        XCTAssertEqual(tile3.frame, CGRect(x: 20, y: 20, width: 20, height: 20))
        XCTAssertEqual(tile3.center, CGPoint(x: 30, y: 30))
        XCTAssertEqual(tile3.vertices.count, 3)
        XCTAssertEqual(tile3.vertices, [CGPoint(x: 20, y: 40), CGPoint(x: 40, y: 40), CGPoint(x: 30, y: 20)])
        
        let tile4 = TriangularTile<String, String>(x: -1, y: 1)
        XCTAssertEqual(tile4.x, -1)
        XCTAssertEqual(tile4.y, 1)
        XCTAssertEqual(tile4.frame, CGRect(x: -10, y: 20, width: 20, height: 20))
        XCTAssertEqual(tile4.center, CGPoint(x: 0, y: 30))
        XCTAssertEqual(tile4.vertices.count, 3)
        XCTAssertEqual(tile4.vertices, [CGPoint(x: -10, y: 20), CGPoint(x: 0, y: 40), CGPoint(x: 10, y: 20)])
        
        let tile5 = TriangularTile<String, String>(x: -3, y: 1)
        XCTAssertEqual(tile5.x, -3)
        XCTAssertEqual(tile5.y, 1)
        XCTAssertEqual(tile5.frame, CGRect(x: -30, y: 20, width: 20, height: 20))
        XCTAssertEqual(tile5.center, CGPoint(x: -20, y: 30))
        XCTAssertEqual(tile5.vertices.count, 3)
        XCTAssertEqual(tile5.vertices, [CGPoint(x: -30, y: 20), CGPoint(x: -20, y: 40), CGPoint(x: -10, y: 20)])
        
        let tile6 = TriangularTile<String, String>(x: -3, y: 0)
        XCTAssertEqual(tile6.x, -3)
        XCTAssertEqual(tile6.y, 0)
        XCTAssertEqual(tile6.frame, CGRect(x: -30, y: 0, width: 20, height: 20))
        XCTAssertEqual(tile6.center, CGPoint(x: -20, y: 10))
        XCTAssertEqual(tile6.vertices.count, 3)
        XCTAssertEqual(tile6.vertices, [CGPoint(x: -30, y: 20), CGPoint(x: -10, y: 20), CGPoint(x: -20, y: 0)])
        
        let tiles: Set<TriangularTile<String, String>> = TriangularTile<String, String>.tilesInRect(CGRect(x: 10, y: 10, width: 40, height: 20))
        XCTAssertEqual(tiles.count, 12)
        XCTAssert(tiles.contains(TriangularTile<String, String>(x: 0, y: 0)))
        XCTAssert(tiles.contains(TriangularTile<String, String>(x: 1, y: 0)))
        XCTAssert(tiles.contains(TriangularTile<String, String>(x: 2, y: 0)))
        XCTAssert(tiles.contains(TriangularTile<String, String>(x: 3, y: 0)))
        XCTAssert(tiles.contains(TriangularTile<String, String>(x: 4, y: 0)))
        XCTAssert(tiles.contains(TriangularTile<String, String>(x: 5, y: 0)))
        XCTAssert(tiles.contains(TriangularTile<String, String>(x: 0, y: 1)))
        XCTAssert(tiles.contains(TriangularTile<String, String>(x: 1, y: 1)))
        XCTAssert(tiles.contains(TriangularTile<String, String>(x: 2, y: 1)))
        XCTAssert(tiles.contains(TriangularTile<String, String>(x: 3, y: 1)))
        XCTAssert(tiles.contains(TriangularTile<String, String>(x: 4, y: 1)))
        XCTAssert(tiles.contains(TriangularTile<String, String>(x: 5, y: 1)))
    }
    
    func testSquareTile() {
        let tile1 = SquareTile<String, String>(x: 0, y: 0)
        XCTAssertEqual(tile1.x, 0)
        XCTAssertEqual(tile1.y, 0)
        XCTAssertEqual(tile1.frame, CGRect(x: 0, y: 0, width: 20, height: 20))
        XCTAssertEqual(tile1.center, CGPoint(x: 10, y: 10))
        XCTAssertEqual(tile1.vertices.count, 4)
        XCTAssertEqual(tile1.vertices, [CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 20), CGPoint(x: 20, y: 20), CGPoint(x: 20, y: 0)])
        
        let tile2 = SquareTile<String, String>(x: 2, y: 2)
        XCTAssertEqual(tile2.x, 2)
        XCTAssertEqual(tile2.y, 2)
        XCTAssertEqual(tile2.frame, CGRect(x: 40, y: 40, width: 20, height: 20))
        XCTAssertEqual(tile2.center, CGPoint(x: 50, y: 50))
        XCTAssertEqual(tile2.vertices.count, 4)
        XCTAssertEqual(tile2.vertices, [CGPoint(x: 40, y: 40), CGPoint(x: 40, y: 60), CGPoint(x: 60, y: 60), CGPoint(x: 60, y: 40)])
        
        let tile3 = SquareTile<String, String>(x: -1, y: -1)
        XCTAssertEqual(tile3.x, -1)
        XCTAssertEqual(tile3.y, -1)
        XCTAssertEqual(tile3.frame, CGRect(x: -20, y: -20, width: 20, height: 20))
        XCTAssertEqual(tile3.center, CGPoint(x: -10, y: -10))
        XCTAssertEqual(tile3.vertices.count, 4)
        XCTAssertEqual(tile3.vertices, [CGPoint(x: -20, y: -20), CGPoint(x: -20, y: 0), CGPoint(x: 0, y: 0), CGPoint(x: 0, y: -20)])
        
        let tiles: Set<SquareTile<String, String>> = SquareTile<String, String>.tilesInRect(CGRect(x: 10, y: 10, width: 40, height: 20))
        XCTAssertEqual(tiles.count, 6)
        XCTAssert(tiles.contains(SquareTile<String, String>(x: 0, y: 0)))
        XCTAssert(tiles.contains(SquareTile<String, String>(x: 1, y: 0)))
        XCTAssert(tiles.contains(SquareTile<String, String>(x: 2, y: 0)))
        XCTAssert(tiles.contains(SquareTile<String, String>(x: 0, y: 1)))
        XCTAssert(tiles.contains(SquareTile<String, String>(x: 1, y: 1)))
        XCTAssert(tiles.contains(SquareTile<String, String>(x: 1, y: 1)))
    }
    
    func testRotatedSquareTile() {
        let tile1 = RotatedSquareTile<String, String>(x: 0, y: 0)
        XCTAssertEqual(tile1.x, 0)
        XCTAssertEqual(tile1.y, 0)
        XCTAssertEqual(tile1.frame, CGRect(x: 0, y: 0, width: 20, height: 20))
        XCTAssertEqual(tile1.center, CGPoint(x: 10, y: 10))
        XCTAssertEqual(tile1.vertices.count, 4)
        XCTAssertEqual(tile1.vertices, [CGPoint(x: 0, y: 10), CGPoint(x: 10, y: 20), CGPoint(x: 20, y: 10), CGPoint(x: 10, y: 0)])
        
        let tile2 = RotatedSquareTile<String, String>(x: 0, y: 1)
        XCTAssertEqual(tile2.x, 0)
        XCTAssertEqual(tile2.y, 1)
        XCTAssertEqual(tile2.frame, CGRect(x: 10, y: 10, width: 20, height: 20))
        XCTAssertEqual(tile2.center, CGPoint(x: 20, y: 20))
        XCTAssertEqual(tile2.vertices.count, 4)
        XCTAssertEqual(tile2.vertices, [CGPoint(x: 10, y: 20), CGPoint(x: 20, y: 30), CGPoint(x: 30, y: 20), CGPoint(x: 20, y: 10)])
        
        let tile3 = RotatedSquareTile<String, String>(x: 2, y: 3)
        XCTAssertEqual(tile3.x, 2)
        XCTAssertEqual(tile3.y, 3)
        XCTAssertEqual(tile3.frame, CGRect(x: 50, y: 30, width: 20, height: 20))
        XCTAssertEqual(tile3.center, CGPoint(x: 60, y: 40))
        XCTAssertEqual(tile3.vertices.count, 4)
        XCTAssertEqual(tile3.vertices, [CGPoint(x: 50, y: 40), CGPoint(x: 60, y: 50), CGPoint(x: 70, y: 40), CGPoint(x: 60, y: 30)])
        
        let tile4 = RotatedSquareTile<String, String>(x: -2, y: -2)
        XCTAssertEqual(tile4.x, -2)
        XCTAssertEqual(tile4.y, -2)
        XCTAssertEqual(tile4.frame, CGRect(x: -40, y: -20, width: 20, height: 20))
        XCTAssertEqual(tile4.center, CGPoint(x: -30, y: -10))
        XCTAssertEqual(tile4.vertices.count, 4)
        XCTAssertEqual(tile4.vertices, [CGPoint(x: -40, y: -10), CGPoint(x: -30, y: 0), CGPoint(x: -20, y: -10), CGPoint(x: -30, y: -20)])
        
        let tile5 = RotatedSquareTile<String, String>(x: -1, y: 1)
        XCTAssertEqual(tile5.x, -1)
        XCTAssertEqual(tile5.y, 1)
        XCTAssertEqual(tile5.frame, CGRect(x: -10, y: 10, width: 20, height: 20))
        XCTAssertEqual(tile5.center, CGPoint(x: 0, y: 20))
        XCTAssertEqual(tile5.vertices.count, 4)
        XCTAssertEqual(tile5.vertices, [CGPoint(x: -10, y: 20), CGPoint(x: 0, y: 30), CGPoint(x: 10, y: 20), CGPoint(x: 0, y: 10)])
        
        let tile6 = RotatedSquareTile<String, String>(x: -1, y: -1)
        XCTAssertEqual(tile6.x, -1)
        XCTAssertEqual(tile6.y, -1)
        XCTAssertEqual(tile6.frame, CGRect(x: -10, y: -10, width: 20, height: 20))
        XCTAssertEqual(tile6.center, CGPoint(x: 0, y: 0))
        XCTAssertEqual(tile6.vertices.count, 4)
        XCTAssertEqual(tile6.vertices, [CGPoint(x: -10, y: 0), CGPoint(x: 0, y: 10), CGPoint(x: 10, y: 0), CGPoint(x: 0, y: -10)])
        
        let tiles: Set<RotatedSquareTile<String, String>> = RotatedSquareTile<String, String>.tilesInRect(CGRect(x: 10, y: 10, width: 40, height: 20))
        XCTAssertEqual(tiles.count, 12)
        XCTAssert(tiles.contains(RotatedSquareTile<String, String>(x: 0, y: 0)))
        XCTAssert(tiles.contains(RotatedSquareTile<String, String>(x: 1, y: 0)))
        XCTAssert(tiles.contains(RotatedSquareTile<String, String>(x: 2, y: 0)))
        XCTAssert(tiles.contains(RotatedSquareTile<String, String>(x: 0, y: 1)))
        XCTAssert(tiles.contains(RotatedSquareTile<String, String>(x: 1, y: 1)))
        XCTAssert(tiles.contains(RotatedSquareTile<String, String>(x: 2, y: 1)))
        XCTAssert(tiles.contains(RotatedSquareTile<String, String>(x: 0, y: 2)))
        XCTAssert(tiles.contains(RotatedSquareTile<String, String>(x: 1, y: 2)))
        XCTAssert(tiles.contains(RotatedSquareTile<String, String>(x: 2, y: 2)))
        XCTAssert(tiles.contains(RotatedSquareTile<String, String>(x: 0, y: 3)))
        XCTAssert(tiles.contains(RotatedSquareTile<String, String>(x: 1, y: 3)))
        XCTAssert(tiles.contains(RotatedSquareTile<String, String>(x: 2, y: 3)))
    }
    
    func testHexagonalTile() {
        let tile1 = HexagonalTile<String, String>(x: 0, y: 0)
        XCTAssertEqual(tile1.x, 0)
        XCTAssertEqual(tile1.y, 0)
        XCTAssertEqual(tile1.frame, CGRect(x: 0, y: 0, width: 20, height: 20))
        XCTAssertEqual(tile1.center, CGPoint(x: 10, y: 10))
        XCTAssertEqual(tile1.vertices.count, 6)
        XCTAssertEqual(tile1.vertices, [CGPoint(x: 0, y: 10), CGPoint(x: 5, y: 20), CGPoint(x: 15, y: 20), CGPoint(x: 20, y: 10), CGPoint(x: 15, y: 0), CGPoint(x: 5, y: 0)])
        
        let tile2 = HexagonalTile<String, String>(x: 0, y: 1)
        XCTAssertEqual(tile2.x, 0)
        XCTAssertEqual(tile2.y, 1)
        XCTAssertEqual(tile2.frame, CGRect(x: 15, y: 10, width: 20, height: 20))
        XCTAssertEqual(tile2.center, CGPoint(x: 25, y: 20))
        XCTAssertEqual(tile2.vertices.count, 6)
        XCTAssertEqual(tile2.vertices, [CGPoint(x: 15, y: 20), CGPoint(x: 20, y: 30), CGPoint(x: 30, y: 30), CGPoint(x: 35, y: 20), CGPoint(x: 30, y: 10), CGPoint(x: 20, y: 10)])
        
        let tile3 = HexagonalTile<String, String>(x: 2, y: 3)
        XCTAssertEqual(tile3.x, 2)
        XCTAssertEqual(tile3.y, 3)
        XCTAssertEqual(tile3.frame, CGRect(x: 75, y: 30, width: 20, height: 20))
        XCTAssertEqual(tile3.center, CGPoint(x: 85, y: 40))
        XCTAssertEqual(tile3.vertices.count, 6)
        XCTAssertEqual(tile3.vertices, [CGPoint(x: 75, y: 40), CGPoint(x: 80, y: 50), CGPoint(x: 90, y: 50), CGPoint(x: 95, y: 40), CGPoint(x: 90, y: 30), CGPoint(x: 80, y: 30)])
        
        let tile4 = HexagonalTile<String, String>(x: -1, y: 0)
        XCTAssertEqual(tile4.x, -1)
        XCTAssertEqual(tile4.y, 0)
        XCTAssertEqual(tile4.frame, CGRect(x: -30, y: 0, width: 20, height: 20))
        XCTAssertEqual(tile4.center, CGPoint(x: -20, y: 10))
        XCTAssertEqual(tile4.vertices.count, 6)
        XCTAssertEqual(tile4.vertices, [CGPoint(x: -30, y: 10), CGPoint(x: -25, y: 20), CGPoint(x: -15, y: 20), CGPoint(x: -10, y: 10), CGPoint(x: -15, y: 0), CGPoint(x: -25, y: 0)])
        
        let tile5 = HexagonalTile<String, String>(x: -1, y: -1)
        XCTAssertEqual(tile5.x, -1)
        XCTAssertEqual(tile5.y, -1)
        XCTAssertEqual(tile5.frame, CGRect(x: -15, y: -10, width: 20, height: 20))
        XCTAssertEqual(tile5.center, CGPoint(x: -5, y: 0))
        XCTAssertEqual(tile5.vertices.count, 6)
        XCTAssertEqual(tile5.vertices, [CGPoint(x: -15, y: 0), CGPoint(x: -10, y: 10), CGPoint(x: 0, y: 10), CGPoint(x: 5, y: 0), CGPoint(x: 0, y: -10), CGPoint(x: -10, y: -10)])
        
        let tile6 = HexagonalTile<String, String>(x: -2, y: -2)
        XCTAssertEqual(tile6.x, -2)
        XCTAssertEqual(tile6.y, -2)
        XCTAssertEqual(tile6.frame, CGRect(x: -60, y: -20, width: 20, height: 20))
        XCTAssertEqual(tile6.center, CGPoint(x: -50, y: -10))
        XCTAssertEqual(tile6.vertices.count, 6)
        XCTAssertEqual(tile6.vertices, [CGPoint(x: -60, y: -10), CGPoint(x: -55, y: 0), CGPoint(x: -45, y: 0), CGPoint(x: -40, y: -10), CGPoint(x: -45, y: -20), CGPoint(x: -55, y: -20)])
        
        let tiles: Set<HexagonalTile<String, String>> = HexagonalTile<String, String>.tilesInRect(CGRect(x: 10, y: 10, width: 40, height: 20))
        XCTAssertEqual(tiles.count, 8)
        XCTAssert(tiles.contains(HexagonalTile<String, String>(x: 0, y: 0)))
        XCTAssert(tiles.contains(HexagonalTile<String, String>(x: 1, y: 0)))
        XCTAssert(tiles.contains(HexagonalTile<String, String>(x: 0, y: 1)))
        XCTAssert(tiles.contains(HexagonalTile<String, String>(x: 1, y: 1)))
        XCTAssert(tiles.contains(HexagonalTile<String, String>(x: 0, y: 2)))
        XCTAssert(tiles.contains(HexagonalTile<String, String>(x: 1, y: 2)))
        XCTAssert(tiles.contains(HexagonalTile<String, String>(x: 0, y: 3)))
        XCTAssert(tiles.contains(HexagonalTile<String, String>(x: 1, y: 3)))
    }
}
