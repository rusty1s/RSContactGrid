//
//  GridSegmentType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 25.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol GridSegmentType : Hashable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
    
    // MARK: Initializiers
    
    /// Create a `GridSegmentType` at `x`- and `y`-coordinates.
    init(x: Int, y: Int)
    
    // MARK: Instance variables
    
    /// Returns the `x`-coordinate of the segment.
    var x: Int { get }
    
    /// Returns the `y`-coordinate of the segment.
    var y: Int { get }
    
    /// The frame rectangle, which describes the segment's location and size
    /// in its grid's coordinate system.
    var frame: CGRect { get }
}

// MARK: Hashable

extension GridSegmentType {
    
    final public var hashValue: Int { return "\(x):\(y)".hashValue }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension GridSegmentType {
    
    public var description: String { return "{x: \(x), y: \(y)}" }
    
    public var debugDescription: String { return "\(self)" }
}
