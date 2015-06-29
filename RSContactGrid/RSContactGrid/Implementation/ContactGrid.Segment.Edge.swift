//
//  ContactGrid.Segment.Edge.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

// MARK: Initializers

extension ContactGrid.Segment.Edge {

    public init(value: EdgeValue) {
        self.value = value
        self.contactedObject = nil
        self.content = nil
    }
}

// MARK: Instance methods

extension ContactGrid.Segment.Edge {

    public static var allEdges: Set<EdgeValue> { return Set([.Left, .Top, .Right, .Bottom]) }
}

// MARK: RawRepresentable

extension ContactGrid.Segment.Edge {
    
    public typealias RawValue = Int

    public init?(rawValue: RawValue) {
        guard let value = EdgeValue(rawValue: rawValue) else { return nil }
        
        self.init(value: value)
    }
    
    public var rawValue: RawValue { return value.rawValue }
}

// MARK: Equatable

extension ContactGrid.Segment.Edge {}
public func == (lhs: ContactGrid.Segment.Edge, rhs: ContactGrid.Segment.Edge) -> Bool {
    return lhs.value == rhs.value
}

// MARK: CustomDebugStringConvertible

extension ContactGrid.Segment.Edge {
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String { return "ContactGrid.Segment.Edge(\(self)" }
}
