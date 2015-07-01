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
        grid.addPolygon([CGPoint(x: 10, y: 10), CGPoint(x: 30, y: 30), CGPoint(x: 50, y: 10)], withContactEdgeEffect: {
            print($0)
            }, allowInsertingSegments: true)
        
    }
}
