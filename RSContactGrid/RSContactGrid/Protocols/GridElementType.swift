//
//  GridElementType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 25.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol GridElementType : Hashable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
    
    // MARK: Associated types
    
    typealias Content
    
    // MARK: Initializiers
    
    /// Create a `GridElementType` at x- and y-coordinates.
    init(x: Int, y: Int)
    
    // MARK: Instance variables
    
    /// Returns the x-coordinate of the segment.
    var x: Int { get }
    
    /// Returns the y-coordinate of the segment.
    var y: Int { get }
    
    /// The vertices of the element in its grid's coordinate system as a clockwise
    /// finite sequence of `CGPoint`.
    var vertices: [CGPoint] { get }
    
    /// The content stored by the element.
    var content: Content? { get set }
}

// MARK: Default implementations

extension GridElementType {
    
    /// Create a `GridElementType` at x- and y-coordinates with a specific content.
    public init(x: Int, y: Int, content: Content?) {
        self.init(x: x, y: y)
        self.content = content
    }
}

// MARK: Hashable

extension GridElementType {
    
    final public var hashValue: Int { return "\(x):\(y)".hashValue }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension GridElementType {
    
    public var description: String { return "{x: \(x), y: \(y)}" }
    
    public var debugDescription: String { return "\(self)" }
}
