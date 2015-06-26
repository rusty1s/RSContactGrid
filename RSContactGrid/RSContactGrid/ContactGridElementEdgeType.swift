//
//  ContactGridElementEdgeType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

protocol ContactGridElementEdgeType : Hashable, Equatable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
    
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
    
    // MARK: Static variables
    
    static var allEdges: Set<EdgeType> { get }
}

// MARK: Default implementations

extension ContactGridElementEdgeType {
    
    final var contacted: Bool { return contactedObject != nil }
    
    final var hasContent: Bool { return content != nil }
}

// MARK: Hashable

extension ContactGridElementEdgeType {
    
    final var hashValue: Int { return edge.hashValue }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension ContactGridElementEdgeType {
    
    /// A textual representation of `self`.
    var description: String {
        return "{edge: \(edge)"
              + (contacted ? ", contactedObject: \(contactedObject)" : "")
              + (hasContent ? ", content: \(content)" : "")
              + "}"
    }
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String { return "ContactGridElementEdgeType\(self)" }
}
