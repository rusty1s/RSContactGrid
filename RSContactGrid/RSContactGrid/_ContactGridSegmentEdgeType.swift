//
//  _ContactGridSegmentEdgeType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

protocol _ContactGridSegmentEdgeType : Hashable, Equatable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
    
    // MARK: Associated types
    
    typealias EdgeType: Hashable, Equatable, CustomStringConvertible
    typealias ContactedObject
    typealias Content
    
    // MARK: Initializers
    
    init(edge: EdgeType)
    
    // MARK: Instance variables
    
    var edge: EdgeType { get }
    
    var contactedObject: ContactedObject? { get set }
    var content: Content? { get set }
    
    static var allEdges: Set<EdgeType> { get }
}

// MARK: Hashable

extension _ContactGridSegmentEdgeType {
    
    final var hashValue: Int { return edge.hashValue }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension _ContactGridSegmentEdgeType {
    
    /// A textual representation of `self`.
    var description: String { return "TODO" }
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String { return "TODO" }
}
