//
//  Protocols.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 22.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

/*// MARK: Contact grid

/*
// extends CollectionType
// extends MutableCollectionType
// extends SequenceType
// extends Reflectable
// extends Hashable
// extends Equatable
// extends Slicable
// extends MutableSlicable

// hat alles was zu array und dictionary passt
*/

protocol ContactGrid : Hashable, Equatable, MutableCollectionType, CollectionType, SequenceType, ArrayLiteralConvertible, CustomStringConvertible, CustomDebugStringConvertible, Reflectable {

    typealias Segment: ContactGridSegment
}

extension ContactGrid {
    
    /// A textual representation of `self`.
    var description: String { return "TODO" }
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String { return "TODO" }
}

// MARK: Contact grid segment

protocol ContactGridSegment : Hashable, Equatable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
    
    typealias Edge: ContactGridSegmentEdge
    
    var x: Int { get }
    var y: Int { get }
    
    var remainingEdges: Set<Edge> { get set }
}

extension ContactGridSegment {

    var deletedEdges: Set<Edge> { return Edge.allEdges.subtract(remainingEdges) }
}

extension ContactGridSegment {}
func == (lhs: ContactGridSegment, rhs: ContactGridSegment) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
func < (lhs: ContactGridSegment, rhs: ContactGridSegment) -> Bool {
    return lhs.y < rhs.y || (lhs.y == rhs.y && lhs.x < rhs.x)
}

extension ContactGridSegment {
    
    /// A textual representation of `self`.
    var description: String { return "TODO" }
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String { return "TODO" }
}

// MARK: Contact grid segment edge

protocol ContactGridSegmentEdge : RawRepresentable, Hashable, Equatable, CustomStringConvertible, CustomDebugStringConvertible {
    
    typealias Parent: ContactGridSegment
    typealias ContactedObject
    typealias Content
    
    var parent: Parent { get }
    
    var contactedObject: ContactedObject? { get set }
    var content: Content? { get set }
    
    static var allEdges: Set<Self> { get }
}

extension ContactGridSegmentEdge {

    typealias RawValue = Int
}

extension ContactGridSegmentEdge {

    var hashValue: Int { return self.rawValue }
}

extension ContactGridSegmentEdge {}
func == (lhs: ContactGridSegmentEdge, rhs: ContactGridSegmentEdge) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

extension ContactGridSegmentEdge {
    
    /// A textual representation of `self`.
    var description: String { return "TODO" }
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String { return "TODO" }
}*/
