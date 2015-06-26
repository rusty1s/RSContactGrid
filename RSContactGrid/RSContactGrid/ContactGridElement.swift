//
//  ContactGridElement.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

struct ContactGridElement : GridElementType {
    
    // MARK: Associated types
    
    typealias Element = ContactGridElementEdge
    
    // MARK: Initializers
    
    init (x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    // MARK: Instance variables
    
    let x: Int
    
    let y: Int
    
    // TODO: CALCULATE FRAME
    var frame: CGRect { return CGRectZero }
    
    var remainingEdges = Set(Element.allEdges.map { Element(edge: $0) })
    
    // MARK: Static variables
    
    static let width: CGFloat = 20
    
    static let height: CGFloat = 20
}

// MARK: Comparable

extension ContactGridElement {}
func == (lhs: ContactGridElement, rhs: ContactGridElement) -> Bool {
    return lhs.y == rhs.y && lhs.x == rhs.x
}
func < (lhs: ContactGridElement, rhs: ContactGridElement) -> Bool {
    return lhs.y < rhs.y || (lhs.y == rhs.y && lhs.x < rhs.x)
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension ContactGridElement {
    
    /// A textual representation of `self`, suitable for debugging.
    var debugDescription: String { return "ContactGridElement(\(self))" }
}
