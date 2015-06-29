//
//  ContactGridSegmentEdgeType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol ContactGridSegmentEdgeType : Hashable, Equatable, RawRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
    
    // MARK: Associated types
    
    typealias EdgeValue: Hashable, Equatable, CustomStringConvertible
    
    typealias ContactedObject
    
    typealias Content
    
    // MARK: Initializers
    
    init(value: EdgeValue)
    
    // MARK: Instance variables
    
    var value: EdgeValue { get }
    
    var contactedObject: ContactedObject? { get set }
    
    var content: Content? { get set }
    
    // MARK: Static variables
    
    static var allEdges: Set<EdgeValue> { get }
}

// MARK: Default implementations

extension ContactGridSegmentEdgeType {
    
    final public var contacted: Bool { return contactedObject != nil }
    
    final public var hasContent: Bool { return content != nil }
}

// MARK: Hashable

extension ContactGridSegmentEdgeType {
    
    final public var hashValue: Int { return value.hashValue }
}

// MARK: CustomStringConvertible

extension ContactGridSegmentEdgeType {
    
    /// A textual representation of `self`.
    public var description: String {
        return "{edge: \(value)"
              + (contacted ? ", contactedObject: \(contactedObject)" : "")
              + (hasContent ? ", content: \(content)" : "")
              + "}"
    }
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String { return "\(self)" }
}
