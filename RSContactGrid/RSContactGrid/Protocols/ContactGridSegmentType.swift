//
//  ContactGridSegmentType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol ContactGridSegmentType : GridSegmentType {
    
    // MARK: Associated types
    
    typealias EdgeType: ContactGridSegmentEdgeType
    
    // MARK: Instance variables
    
    /// The remaining edges of the segment.
    var remainingEdges: Set<EdgeType> { get set }
}

// MARK: Default implementations

extension ContactGridSegmentType {
    
    /// The edges, which were already deleted from the segment.
    final public var deletedEdges: Set<EdgeType.EdgeValue> {
        return EdgeType.allValues.subtract(remainingEdges.map { $0.value })
    }
    
    /// The remaining edges with a content body.
    final public var edgesWithContentBody: Set<EdgeType> {
        return Set(remainingEdges.filter { $0.hasContentBody })
    }
    
    /// The remaining edges with a contact body.
    final public var edgesWithContactBody: Set<EdgeType> {
        return Set(remainingEdges.filter { $0.hasContactBody })
    }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension ContactGridSegmentType {
    
    public var description: String { return "{x: \(x), y: \(y), remaining edges: \(remainingEdges.map { $0.description })}"}
    
    public var debugDescription: String { return "\(self)" }
}
