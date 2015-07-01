//
//  ContactGridType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol ContactGridType : GridType {
    
    // MARK: Associated types
    
    typealias SegmentType: ContactGridSegmentType
    
    typealias SegmentEdgeType: ContactGridSegmentEdgeType
    
    // MARK: Instance methods
    
    /// Adds a polygon, a finite sequence of `CGPoint`'s, into the grid.
    /// `contactEdgeEffect` describes the behavior of all `SegmentEdgeType`'s
    /// in the grid, that overlay the polygon.
    /// `allowInsertingSegments` allows the grid to insert segments, which
    /// overlay the polygon, but are not yet inserted into the grid.
    mutating func addPolygon(polygon: [CGPoint], @noescape withContactEdgeEffect contactEdgeEffect: (SegmentEdgeType -> ()), allowInsertingSegments: Bool)
}
