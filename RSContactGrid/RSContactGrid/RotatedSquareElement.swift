//
//  RotatedSquareElement.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 18.07.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

private struct RotatedSquareElementData {
    
    private static var width: CGFloat = 20
    
    private static var height: CGFloat = 20
}

public struct RotatedSquareElement<T, S> : GridElementType {
    
    // MARK: Initializers
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    /// Create a `RotatedSquareElement` at x- and y-coordinates with specific
    /// content and contact.
    public init(x: Int, y: Int, content: T?, contact: S?) {
        self.init(x: x, y: y)
        self.content = content
        self.contact = contact
    }
    
    // MARK: Instance variables
    
    public let x: Int
    
    public let y: Int
    
    /// The content stored by the element.
    public var content: T?
    
    /// The contact stored by the element.
    public var contact: S?
    
    // MARK: Static variables
    
    // The width of the element.  The width has a minimum value of 1.
    public static var width: CGFloat {
        set { RotatedSquareElementData.width = max(1, newValue) }
        get { return RotatedSquareElementData.width }
    }
    
    // The height of the element.  The height has a minimum value of 1.
    public static var height: CGFloat {
        set { RotatedSquareElementData.height = max(1, newValue) }
        get { return RotatedSquareElementData.height }
    }
}

// MARK: Instance variables

extension RotatedSquareElement {
    
    public var frame: CGRect {
        if y%2 == 0 {
            return CGRect(x: CGFloat(x)*RotatedSquareElement<T, S>.width,
                y: CGFloat(y/2)*RotatedSquareElement<T, S>.height,
                width: RotatedSquareElement<T, S>.width,
                height: RotatedSquareElement<T, S>.height)
        }
        else {
            return CGRect(x: (CGFloat(x)+0.5)*RotatedSquareElement<T, S>.width,
                y: (CGFloat(y/2)+0.5)*RotatedSquareElement<T, S>.height,
                width: RotatedSquareElement<T, S>.width,
                height: RotatedSquareElement<T, S>.height)
        }
    }
    
    public var vertices: [CGPoint] {
        let startX = y%2 == 0 ? (CGFloat(x)+0.5)*RotatedSquareElement<T, S>.width : CGFloat(x+1)*RotatedSquareElement<T, S>.width
        let startY = y%2 == 0 ? CGFloat(y/2)*RotatedSquareElement<T, S>.height : (CGFloat(y/2)+0.5)*RotatedSquareElement<T, S>.height
        
        return [CGPoint(x: startX, y: startY),
            CGPoint(x: startX-RotatedSquareElement<T, S>.width/2, y: startY+RotatedSquareElement<T, S>.height/2),
            CGPoint(x: startX, y: startY+RotatedSquareElement<T, S>.height),
            CGPoint(x: startX+RotatedSquareElement<T, S>.width/2, y: startY+RotatedSquareElement<T, S>.height/2)]
    }
}

// MARK: Instance functions

extension RotatedSquareElement {
    
    public func intersectsRelativeLineSegment(point1 point1: RelativeRectPoint, point2: RelativeRectPoint) -> Bool {
        if point1.x < 0.5 && point1.y < 0.5 && point1.y < (0.5-point1.x) && point2.x < 0.5 && point2.y < 0.5 && point2.y < (0.5-point2.x) { return false }
        if point1.x < 0.5 && point1.y > 0.5 && (1-point1.y) < (0.5-point1.x) && point2.x < 0.5 && point2.y > 0.5 && (1-point2.y) < (0.5-point2.x) { return false }
        if point1.x > 0.5 && point1.y < 0.5 && point1.y < (point1.x-0.5) && point2.x > 0.5 && point2.y < 0.5 && point2.y < (point2.x-0.5) { return false }
        if point1.x > 0.5 && point1.y > 0.5 && (1-point1.y) < (point1.x-0.5) && point2.x > 0.5 && point2.y > 0.5 && (1-point2.y) < (point2.x-0.5) { return false }
            
        return true
    }
}

// MARK: Static functions

extension RotatedSquareElement {
    
    public static func elementsInRect<T, S>(rect: CGRect) -> Set<RotatedSquareElement<T, S>> {
        
        var elements = Set<RotatedSquareElement<T, S>>()
        
        let evenStartSegment = evenSegmentOfCoordinates(rect.origin)
        let evenEndSegment = evenSegmentOfCoordinates(CGPoint(x: rect.origin.x+rect.size.width, y: rect.origin.y+rect.size.height))
        
        for x in evenStartSegment.0-1...evenEndSegment.0+1 {
            for y in evenStartSegment.1-1...evenEndSegment.1+1 {
                elements.insert(RotatedSquareElement<T, S>(x: x, y: y))
            }
        }
        
        return elements
    }
    
    private static func evenSegmentXOfCoordinate(coordinate: CGFloat) -> Int {
        return coordinate < 0 && fmod(coordinate, width) != 0 ? Int(coordinate/width)-1 : Int(coordinate/width)
    }
    
    private static func evenSegmentYOfCoordinate(coordinate: CGFloat) -> Int {
        return coordinate < 0 && fmod(coordinate, height) != 0 ? (Int(coordinate/height)-1)*2 : Int(coordinate/height)*2
    }
    
    private static func evenSegmentOfCoordinates(coordinates: CGPoint) -> (Int, Int) {
        return (evenSegmentXOfCoordinate(coordinates.x), evenSegmentYOfCoordinate(coordinates.y))
    }
    
    private static func oddSegmentXOfCoordinate(var coordinate: CGFloat) -> Int {
        coordinate -= RotatedSquareElement<T, S>.width/2
        
        return coordinate < 0 && fmod(coordinate, width) != 0 ? Int(coordinate/width)-1 : Int(coordinate/width)
    }
    
    private static func oddSegmentYOfCoordinate(var coordinate: CGFloat) -> Int {
        coordinate -= RotatedSquareElement<T, S>.height/2
        
        return coordinate < 0 && fmod(coordinate, height) != 0 ? (Int(coordinate/height)-1)*2+1 : Int(coordinate/height)*2+1
    }
    
    private static func oddSegmentOfCoordinates(coordinates: CGPoint) -> (Int, Int) {
        return (oddSegmentXOfCoordinate(coordinates.x), oddSegmentYOfCoordinate(coordinates.y))
    }
}

// MARK: Comparable

extension RotatedSquareElement {}
public func == <T, S>(lhs: RotatedSquareElement<T, S>, rhs: RotatedSquareElement<T, S>) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
public func < <T, S>(lhs: RotatedSquareElement<T, S>, rhs: RotatedSquareElement<T, S>) -> Bool {
    return lhs.y < rhs.y || (lhs.y == rhs.y && lhs.x < rhs.x)
}

// MARK: CustomDebugStringConvertible

extension RotatedSquareElement {
    
    public var debugDescription: String { return "RotatedSquareElement(\(self)" }
}
