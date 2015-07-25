//
//  HexagonalElement.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 18.07.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

private struct HexagonalElementData {
    
    private static var width: CGFloat = 20
    
    private static var height: CGFloat = 20
    
    private static var horizontalLength: CGFloat = 10
}

public struct HexagonalElement<T, S> : GridElementType {
    
    // MARK: Initializers
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    /// Create a `HexagonalElement` at x- and y-coordinates with specific
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
    
    /// The width of the element.  The width has a minimum value of 1.
    /// Adjusts the `horizontalLength` of the element, if `width < horizontalLength`.
    public static var width: CGFloat {
        set {
            HexagonalElementData.width = max(1, newValue)
            HexagonalElement<T, S>.horizontalLength = HexagonalElement<T, S>.horizontalLength
        }
        get { return HexagonalElementData.width }
    }
    
    /// The height of the element.  The height has a minimum value of 1.
    public static var height: CGFloat {
        set { HexagonalElementData.height = max(1, newValue) }
        get { return HexagonalElementData.height }
    }
    
    /// The horizontal site's length of the element.  The length has a value between 1
    /// and the width of the element.
    public static var horizontalLength: CGFloat {
        set { HexagonalElementData.horizontalLength = min(max(1, newValue), HexagonalElement<T, S>.width) }
        get { return HexagonalElementData.horizontalLength }
    }
    
    private static var offsetX: CGFloat { return (width-horizontalLength)/2 }
}

// MARK: Instance variables

extension HexagonalElement {
    
    public var frame: CGRect {
        
        let originX = CGFloat(x)*(HexagonalElement<T, S>.width+HexagonalElement<T, S>.horizontalLength) + (y%2 == 1 ? HexagonalElement<T, S>.width-HexagonalElement<T, S>.offsetX : 0)
        let originY = CGFloat(y/2)*HexagonalElement<T, S>.height + (y%2 == 1 ? HexagonalElement<T, S>.height/2 : 0)
        
        return CGRect(x: originX, y: originY, width: HexagonalElement<T, S>.width, height: HexagonalElement<T, S>.height)
    }
    
    public var vertices: [CGPoint] {
        
        let frame = self.frame
        let offsetX = HexagonalElement<T, S>.offsetX
        
        return [CGPoint(x: frame.origin.x, y: frame.origin.y+frame.size.height/2),
            CGPoint(x: frame.origin.x+offsetX, y: frame.origin.y+frame.size.height),
            CGPoint(x: frame.origin.x+frame.size.width-offsetX, y: frame.origin.y+frame.size.height),
            CGPoint(x: frame.origin.x+frame.size.width, y: frame.origin.y+frame.size.height/2),
            CGPoint(x: frame.origin.x+frame.size.width-offsetX, y: frame.origin.y),
            CGPoint(x: frame.origin.x+offsetX, y: frame.origin.y)]
    }
}

// MARK: Instance functions

extension HexagonalElement {
    
    public func intersectsRelativeLineSegment(point1 point1: RelativeRectPoint, point2: RelativeRectPoint) -> Bool {
        let relOffsetX = HexagonalElement<T, S>.offsetX/HexagonalElement<T, S>.width
        
        // bottom left
        if point1.x < relOffsetX && point1.y < 0.5 && point2.x < relOffsetX && point2.y < 0.5 {
            let x1 = point1.x*(1/relOffsetX)
            let y1 = 2*point1.y
            let x2 = point2.x*(1/relOffsetX)
            let y2 = 2*point2.y
            
            if y1 < 1-x1 && y2 < 1-x2 { return false }
        }
        
        // top left
        if point1.x < relOffsetX && point1.y > 0.5 && point2.x < relOffsetX && point2.y > 0.5 {
            let x1 = point1.x*(1/relOffsetX)
            let y1 = 2*(point1.y-0.5)
            let x2 = point2.x*(1/relOffsetX)
            let y2 = 2*(point2.y-0.5)
            
            if y1 > x1 && y2 > x2 { return false }
        }
        
        // bottom right
        if point1.x > 1-relOffsetX && point1.y < 0.5 && point2.x > 1-relOffsetX && point2.y < 0.5 {
            let x1 = (point1.x-(1-relOffsetX))*(1/relOffsetX)
            let y1 = 2*point1.y
            let x2 = (point2.x-(1-relOffsetX))*(1/relOffsetX)
            let y2 = 2*point2.y
            
            if y1 < x1 && y2 < x2 { return false }
        }
        
        // top right
        if point1.x > 1-relOffsetX && point1.y > 0.5 && point2.x > 1-relOffsetX && point2.y > 0.5 {
            let x1 = (point1.x-(1-relOffsetX))*(1/relOffsetX)
            let y1 = 2*(point1.y-0.5)
            let x2 = (point2.x-(1-relOffsetX))*(1/relOffsetX)
            let y2 = 2*(point2.y-0.5)
            
            if 1-y1 < x1 && 1-y2 < x2 { return false }
        }
        
        return true
    }
}

// MARK: Static functions

extension HexagonalElement {
    
    public static func elementsInRect<T, S>(rect: CGRect) -> Set<HexagonalElement<T, S>> {
        
        var elements = Set<HexagonalElement<T, S>>()
        
        for x in 0...10 {
            for y in 0...40 {
                elements.insert(HexagonalElement<T, S>(x: x, y: y))
            }
        }
        
        return elements
    }
}

// MARK: Comparable

extension HexagonalElement {}
public func == <T, S>(lhs: HexagonalElement<T, S>, rhs: HexagonalElement<T, S>) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
public func < <T, S>(lhs: HexagonalElement<T, S>, rhs: HexagonalElement<T, S>) -> Bool {
    return lhs.y < rhs.y || (lhs.y == rhs.y && lhs.x < rhs.x)
}

// MARK: CustomDebugStringConvertible

extension HexagonalElement {
    
    public var debugDescription: String { return "HexagonalElement(\(self)" }
}