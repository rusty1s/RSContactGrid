//
//  ContactGridElementEdge.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public struct ContactGridElementEdge : ContactGridElementEdgeType {
    
    public enum Edge: Int, CustomStringConvertible {
        case Left = 1
        case Top, Right, Bottom
        
        public var description: String { return "\(self)" }
    }
    
    // MARK: Associated types
    
    public typealias EdgeType = Edge
    
    public typealias ContactedObject = AnyObject
    
    public typealias Content = AnyObject
    
    // MARK: Initializers
    
    public init(edge: EdgeType) {
        self.edge = edge
    }
    
    // MARK: Instance variables
    
    public let edge: EdgeType
    
    public var contactedObject: ContactedObject?
    
    public var content: Content?
    
    public static var allEdges: Set<EdgeType> { return Set([.Left, .Top, .Right, .Bottom]) }
}

// MARK: RawRepresentable

extension ContactGridElementEdge {
    
    public typealias RawValue = Int

    public init?(rawValue: RawValue) {
        guard let edge = Edge(rawValue: rawValue) else { return nil }
        
        self.edge = edge
    }
    
    public var rawValue: RawValue { return edge.rawValue }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension ContactGridElementEdge {
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String { return "ContactGridElementEdge(\(self))" }
}
