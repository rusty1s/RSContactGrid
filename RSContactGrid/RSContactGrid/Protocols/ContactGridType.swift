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
    
    mutating func addPolygon(polygon: [CGPoint], withContactEdgeEffect: (SegmentEdgeType -> ()), allowInsertingSegments: Bool)
}
