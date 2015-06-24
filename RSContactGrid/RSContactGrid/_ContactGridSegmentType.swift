//
//  _ContactGridSegmentType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

protocol _ContactGridSegmentType : Hashable, Equatable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
    
    // MARK: Associated types
    
    typealias Edge: _ContactGridSegmentEdgeType
    
    // MARK: Initializiers
    
    init(x: Int, y: Int)
    
    // MARK: Instance variables
    
    var x: Int { get }
    var y: Int { get }
    
    var remainingEdges: Set<Edge> { get set }
}

// MARK: Default implementations

extension _ContactGridSegmentType {
    
    // MARK: Instance variables
    
    final var deletedEdges: Set<Edge> { return Edge.allEdges.subtract(remainingEdges) }
    final var contactedEdges: Set<Edge> { return Set(remainingEdges.filter { $0.contactedObject != nil }) }
}

// MARK: Hashable

extension _ContactGridSegmentType {
    final var hashValue: Int { return "\(x):\(y)".hashValue }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension _ContactGridSegmentType {
    
    /// A textual representation of `self`.
    final var description: String { return "TODO" }
    
    /// A textual representation of `self`, suitable for debugging.
    final var debugDescription: String { return "TODO" }
}
