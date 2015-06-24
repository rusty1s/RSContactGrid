//
//  ContactGrid.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

struct ContactGrid : _ContactGridType {
    
    // MARK: Associated types
    
    typealias Element = ContactGridSegment

    // MARK: Initializers
    
    init() {
        segments = Set<Element>()
    }
    
    init(minimumCapacity: Int) {
        segments = Set<Element>(minimumCapacity: minimumCapacity)
    }
    
    init<S : SequenceType where S.Generator.Element == Element>(_ sequence: S) {
        segments = Set<Element>()
        // TODO
    }
    
    // MARK: Instance variables
    
    private var segments: Set<Element>()
    
    // MARK: Instance methods
    
    func segmentAtPoint(point: Index) -> Element? {
        return segments[segments.indexOf(point)]
    }
    
    mutating func insertAtPoint(point: Index) {
        
    }
    
    mutating func removeAtPoint(point: Index) -> Element? {
        segments.removeAtIndex(point)
    }
    
    mutating func removeAll(keepCapacity keepCapacity: Bool = true) {
        segments.removeAll(keepCapacity: keepCapacity)
    }
    
    mutating func addPolygon(polygon: [CGPoint], withEffect: (Element -> ()), allowInsertingSegments: Bool) {
        
    }
}
