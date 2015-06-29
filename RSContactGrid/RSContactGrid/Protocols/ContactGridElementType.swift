//
//  ContactGridElementType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol ContactGridElementType : GridElementType {
    
    // MARK: Associated types
    
    typealias Element: ContactGridElementEdgeType
    
    // MARK: Instance variables
    
    var remainingEdges: Set<Element> { get set }
}

// MARK: Default implementations

extension ContactGridElementType {
    
    final public var deletedEdges: Set<Element.EdgeType> {
        return Element.allEdges.subtract(remainingEdges.map { $0.edge })
    }
    
    final public var contactedEdges: Set<Element> {
        return Set(remainingEdges.filter { $0.contactedObject != nil })
    }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension ContactGridElementType {
    
    /// A textual representation of `self`.
    public var description: String { return "{x: \(x), y: \(y), remaining edges: \(remainingEdges)}"}
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String { return "ContactGridElementType(\(self))" }
}
