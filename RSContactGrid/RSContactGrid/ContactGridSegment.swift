//
//  ContactGridSegment.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

protocol ContactGridSegment : Hashable, Equatable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
    
    typealias Edge: ContactGridSegmentEdge
    
    var x: Int { get }
    var y: Int { get }
    
    var remainingEdges: Set<Edge> { get set }
}

extension ContactGridSegment {
    
    var deletedEdges: Set<Edge> { return Edge.allEdges.subtract(remainingEdges) }
}

// MARK: Hashable

extension ContactGridSegment {
    var hashValue: Int { return "\(x):\(y)".hashValue }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension ContactGridSegment {
    
    /// A textual representation of `self`.
    var description: String { return "TODO" }
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String { return "TODO" }
}
