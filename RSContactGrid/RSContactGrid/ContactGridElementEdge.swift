//
//  ContactGridElementEdge.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

struct ContactGridElementEdge : ContactGridElementEdgeType {
    
    enum Edge: Int, CustomStringConvertible {
        case Left = 1
        case Top, Right, Bottom
        
        var description: String { return "\(self)" }
    }
    
    // MARK: Associated types
    
    typealias EdgeType = Edge
    
    typealias ContactedObject = AnyObject
    
    typealias Content = AnyObject
    
    // MARK: Initializers
    
    init(edge: EdgeType) {
        self.edge = edge
    }
    
    // MARK: Instance variables
    
    let edge: EdgeType
    
    var contactedObject: ContactedObject?
    
    var content: Content?
    
    static var allEdges: Set<EdgeType> { return Set([.Left, .Top, .Right, .Bottom]) }
}

// MARK: RawRepresentable

extension ContactGridElementEdge {
    
    typealias RawValue = Int

    init?(rawValue: RawValue) {
        guard let edge = Edge(rawValue: rawValue) else { return nil }
        
        self.edge = edge
    }
    
    var rawValue: RawValue { return edge.rawValue }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension ContactGridElementEdge {
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String { return "ContactGridElementEdge(\(self))" }
}
