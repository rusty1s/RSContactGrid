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
    
    var remainingEdges: Set<EdgeType> { get set }
}

// MARK: Default implementations

extension ContactGridSegmentType {
    
    final public var deletedEdges: Set<EdgeType.EdgeValue> {
        return EdgeType.allValues.subtract(remainingEdges.map { $0.value })
    }
    
    final public var contactedEdges: Set<EdgeType> {
        return Set(remainingEdges.filter { $0.contactedObject != nil })
    }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension ContactGridSegmentType {
    
    /// A textual representation of `self`.
    public var description: String { return "{x: \(x), y: \(y), remaining edges: \(remainingEdges.map { $0.description })}"}
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String { return "\(self)" }
}
