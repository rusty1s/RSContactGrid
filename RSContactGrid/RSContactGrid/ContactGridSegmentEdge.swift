//
//  ContactGridSegmentEdge.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

protocol ContactGridSegmentEdge : RawRepresentable, Hashable, Equatable, CustomStringConvertible, CustomDebugStringConvertible {
    
    typealias ContactedObject
    typealias Content
    
    var contactedObject: ContactedObject? { get set }
    var content: Content? { get set }
    
    static var allEdges: Set<Self> { get }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension ContactGridSegmentEdge {
    
    /// A textual representation of `self`.
    var description: String { return "TODO" }
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String { return "TODO" }
}
