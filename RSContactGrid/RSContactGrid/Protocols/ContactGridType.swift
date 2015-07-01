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
    
    /// Adds a virtual polygon into the grid and defines behavior for
    /// overlayed segment edges.
    /// - Parameter polygon: a finite sequence of `CGPoint`.
    /// Lines of a polygon aren't allowed to intersect each other.
    /// - Parameter contactEdgeEffect: the behavior of a `SegmentType`
    /// and its specific `SegmentEdgeType`, that is overlayed by the polygon.
    /// - Parameter allowInsertingSegments: allows the grid to insert segments,
    /// which are overlayed by the polygon, but are not yet inserted into the grid.
    mutating func addPolygon(polygon: [CGPoint], allowInsertingSegments: Bool, @noescape resolveContact: ((SegmentType, SegmentEdgeType) -> ()))
}
