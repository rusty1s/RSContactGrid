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

    typealias ContentBody
    
    typealias ContactBody
    
    // MARK: Initializers
    
    /// Create a `ContactGridSegmentEdgeType` with an edge value
    /// and empty content and contact bodies.
    init(value: EdgeValue)
    
    // MARK: Instance variables
    
    /// Returns the edge value.
    var value: EdgeValue { get }
    
    /// The content body stored by the edge.
    var contentBody: ContentBody? { get set }
    
    /// The contact body stored by the edge used for collision detection
    /// with the content body.
    var contactBody: ContactBody? { get set }
    
    // MARK: Static variables
    
    /// Returns all possible edge values.
    static var allValues: Set<EdgeValue> { get }
}

// MARK: Default implementations

extension ContactGridSegmentEdgeType {
    
    /// Create a `ContactGridSegmentEdgeType` with an edge value
    /// and content and contact bodies.
    public init(value: EdgeValue, contentBody: ContentBody?, contactBody: ContactBody?) {
        self.init(value: value)
        self.contentBody = contentBody
        self.contactBody = contactBody
    }
    
    /// `true` if the edge has a content body.
    final public var hasContentBody: Bool { return contentBody != nil }
    
    /// `true` if the edge has a contact body.
    final public var hasContactBody: Bool { return contactBody != nil }
}

// MARK: Hashable

extension ContactGridSegmentEdgeType {
    
    final public var hashValue: Int { return value.hashValue }
}

// MARK: CustomStringConvertible

extension ContactGridSegmentEdgeType {
    
    public var description: String {
        return "{edge: \(value)"
              + (hasContentBody ? ", content body: \(contentBody)" : "")
              + (hasContactBody ? ", contact body: \(contactBody)" : "")
              + "}"
    }
    
    public var debugDescription: String { return "\(self)" }
}
