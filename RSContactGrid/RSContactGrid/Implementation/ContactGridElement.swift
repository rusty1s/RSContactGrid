//
//  ContactGridElement.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public struct ContactGridElement : ContactGridElementType {
    
    // MARK: Associated types
    
    public typealias Element = ContactGridElementEdge
    
    // MARK: Initializers
    
    public init (x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    // MARK: Instance variables
    
    public let x: Int
    
    public let y: Int
    
    public var frame: CGRect {
        return CGRect(x: CGFloat(x)*ContactGridElement.width, y: CGFloat(y)*ContactGridElement.height, width: ContactGridElement.width, height: ContactGridElement.height)
    }
    
    public var remainingEdges = Set(Element.allEdges.map { Element(edge: $0) })
    
    // MARK: Static variables
    
    public static let width: CGFloat = 20
    
    public static let height: CGFloat = 20
}

// MARK: Comparable

extension ContactGridElement {}
public func == (lhs: ContactGridElement, rhs: ContactGridElement) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
public func < (lhs: ContactGridElement, rhs: ContactGridElement) -> Bool {
    return lhs.y < rhs.y || (lhs.y == rhs.y && lhs.x < rhs.x)
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension ContactGridElement {
    
    /// A textual representation of `self`, suitable for debugging.
    public var debugDescription: String { return "ContactGridElement(\(self))" }
}
