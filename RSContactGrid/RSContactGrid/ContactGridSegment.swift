//
//  ContactGridSegment.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

struct ContactGridSegment : _ContactGridSegmentType {
    
    // MARK: Associated types
    
    typealias Element = ContactGridSegmentEdge
    
    // MARK: Initializers
    
    init (point: (Int, Int)) {
        self.point = point
        remainingEdges = Set(Element.allEdges.map { Element(edge: $0) })
    }
    
    // MARK: Instance variables
    
    let point: (Int, Int)
    
    var remainingEdges: Set<Element>
}

// MARK: Comparable

extension ContactGridSegment {}
func == (lhs: ContactGridSegment, rhs: ContactGridSegment) -> Bool {
    return lhs.y == rhs.y && lhs.x == rhs.x
}
func < (lhs: ContactGridSegment, rhs: ContactGridSegment) -> Bool {
    return lhs.y < rhs.y || (lhs.y == rhs.y && lhs.x < rhs.x)
}


