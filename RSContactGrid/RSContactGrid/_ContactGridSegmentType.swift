//
//  _ContactGridSegmentType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

protocol _ContactGridSegmentType : Hashable, Equatable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
    
    // MARK: Associated types
    
    typealias Element: _ContactGridSegmentEdgeType
    
    // MARK: Initializiers
    
    init(point: (Int, Int))
    
    // MARK: Instance variables
    
    var point: (Int, Int) { get }
    
    var remainingEdges: Set<Element> { get set }
}

// MARK: Default implementations

extension _ContactGridSegmentType {
    
    // MARK: Initializers
    
    init(x: Int, y: Int) {
        self.init(point: (x, y))
    }
    
    // MARK: Instance variables
    
    var x: Int { return point.0 }
    var y: Int { return point.1 }
    
    final var deletedEdges: Set<Element.EdgeType> { return Element.allEdges.subtract(remainingEdges.map { $0.edge }) }
    final var contactedEdges: Set<Element> { return Set(remainingEdges.filter { $0.contactedObject != nil }) }
}

// MARK: Hashable

extension _ContactGridSegmentType {
    
    final var hashValue: Int { return "\(x):\(y)".hashValue }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension _ContactGridSegmentType {
    
    /// A textual representation of `self`.
    var description: String { return "TODO" }
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String { return "TODO" }
}
