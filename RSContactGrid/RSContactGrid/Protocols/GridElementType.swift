//
//  GridElementType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 25.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol GridElementType : Hashable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
    
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
    
    // MARK: Static functions
    
    /// Returns the minimal inital elements that intersect with a line segment
    /// from the start point to the end point.
    static func elementsInLineFromPoint(startPoint: CGPoint, toPoint endPoint: CGPoint) -> Set<Self>
    
    /// Returns the minimal inital elements that are overlayed by the rect.
    static func elementsInRect(rect: CGRect) -> Set<Self>
}

// MARK: Default implementations

extension GridElementType {
    
    /// The minimal frame rectangle, which describes the element's location and
    /// size in its grid's coordinate system.  The frame contains all vertices
    /// of the element.
    public var frame: CGRect {
        var minX = CGFloat.max
        var maxX = CGFloat.min
        var minY = CGFloat.max
        var maxY = CGFloat.min
        
        for vertex in vertices {
            minX = min(minX, vertex.x)
            maxX = max(maxX, vertex.x)
            minY = min(minY, vertex.y)
            maxY = max(maxY, vertex.y)
        }
        
        return CGRect(x: minX, y: minY, width: maxX-minX, height: maxY-minY)
    }
    
    /// The center of the element's frame rectangle.
    final public var center: CGPoint {
        let frame = self.frame
        return CGPoint(x: frame.origin.x+frame.size.width/2, y: frame.origin.y+frame.size.height/2)
    }
}

// MARK: Hashable

extension GridElementType {
    
    final public var hashValue: Int { return "\(x):\(y)".hashValue }
}

// MARK: CustomStringConvertible / CustomDebugStringConvertible

extension GridElementType {
    
    public var description: String { return "{x: \(x), y: \(y)}" }
    
    public var debugDescription: String { return "GridElementType(\(self))" }
}
