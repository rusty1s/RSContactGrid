//
//  _ContactGridSegmentEdgeType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

protocol _ContactGridSegmentEdgeType : RawRepresentable, Hashable, Equatable, CustomStringConvertible, CustomDebugStringConvertible {
    
    // MARK: Associated types
    
    typealias ContactedObject
    typealias Content
    
    // MARK: Instance variables
    
    var contactedObject: ContactedObject? { get set }
    var content: Content? { get set }
    
    static var allEdges: Set<Self> { get }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension _ContactGridSegmentEdgeType {
    
    /// A textual representation of `self`.
    final var description: String { return "TODO" }
    
    /// A textual representation of `self`, suitable for debugging.
    final var debugDescription: String { return "TODO" }
}
