//
//  TriangularElement.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 16.07.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

private struct TriangularElementData {
    
    private static var width: CGFloat = 20

    private static var height: CGFloat = 20
}

public struct TriangularElement<T, S> : GridElementType {
    
    // MARK: Initializers
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    /// Create a `TriangularElement` at x- and y-coordinates with specific
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
        set { TriangularElementData.width = max(1, newValue) }
        get { return TriangularElementData.width }
    }
    
    // The height of the element.  The height has a minimum value of 1.
    public static var height: CGFloat {
        set { TriangularElementData.height = max(1, newValue) }
        get { return TriangularElementData.height }
    }
}

// MARK: Instance variables

extension TriangularElement {
    
    public var frame: CGRect {
        let width = TriangularElement<T, S>.width
        let height = TriangularElement<T, S>.height
        let realY = height * CGFloat(y)
        let realX: CGFloat!
        
        if (x+y)%2 == 0 {    // apex of the triangle is on the top
            realX = y%2 == 0 ? width * CGFloat(x/2) : width * (CGFloat(x/2)+0.5)
        }
        else {  // apex of the triangle is at the bottom
            realX = y%2 == 0 ? width * (CGFloat((x+1)/2) - 0.5) : width * CGFloat(x/2)
        }
        
        return CGRect(x: realX, y: realY, width: width, height: height)
    }
    
    public var vertices: [CGPoint] {
        let width = TriangularElement<T, S>.width
        let height = TriangularElement<T, S>.height
        let realY = height * CGFloat(y)
        
        if (x+y)%2 == 0 {   // apex of the triangle is on the top
            let realX = y%2 == 0 ? width * CGFloat(x/2) : width * (CGFloat(x/2)+0.5)
            
            return [CGPoint(x: realX, y: realY),
                CGPoint(x: realX+width/2, y: realY+height),
                CGPoint(x: realX+width, y: realY)]
        }
        else {  // apex of the triangle is at the bottom
            let realX = y%2 == 0 ? width * CGFloat((x+1)/2) : width * (CGFloat(x/2)+0.5)
            
            return [CGPoint(x: realX, y: realY),
                CGPoint(x: realX-width/2, y: realY+height),
                CGPoint(x: realX+width/2, y: realY+height)]
        }
    }
}

// MARK: Instance functions

extension TriangularElement {
    
    public func intersectsRelativeLineSegment(point1 point1: RelativeRectPoint, point2: RelativeRectPoint) -> Bool {
        if (x+y)%2 == 0 {   // apex of the triangle is on the top
            if point1.x < 0.5 && point1.y > 2*point1.x && point2.x < 0.5 && point2.y > 2*point2.x { return false }
            if point1.x > 0.5 && point1.y > 2*(1-point1.x) && point2.x > 0.5 && point2.y > 2*(1-point2.x) { return false }
        }
        else {  // apex of the triangle is at the bottom
            if point1.x < 0.5 && (1-point1.y) > 2*point1.x && point2.x < 0.5 && (1-point2.y) > 2*point2.x { return false }
            if point1.x > 0.5 && (1-point1.y) > 2*(1-point1.x) && point2.x > 0.5 && (1-point2.y) > 2*(1-point2.x) { return false }
        }
        
        return true
    }
}

// MARK: Static functions

extension TriangularElement {
    
    public static func elementsInRect<T, S>(rect: CGRect) -> Set<TriangularElement<T, S>> {
        
        let startX = segmentXOfCoordinate(rect.origin.x)
        let startY = segmentYOfCoordinate(rect.origin.y)
        let endX = segmentXOfCoordinate(rect.origin.x+rect.size.width)
        let endY = segmentYOfCoordinate(rect.origin.y+rect.size.height)
        
        var elements = Set<TriangularElement<T, S>>(minimumCapacity: (endX-startX)*(endY-startY))
        for x in startX...endX {
            for y in startY...endY {
                elements.insert(TriangularElement<T, S>(x: x, y: y))
            }
        }
        return elements
    }
    
    private static func segmentXOfCoordinate(coordinate: CGFloat) -> Int {
        return coordinate < 0 && fmod(coordinate, width/2) != 0 ? Int(coordinate/(width/2))-2 : Int(coordinate/(width/2))-1
    }
    
    private static func segmentYOfCoordinate(coordinate: CGFloat) -> Int {
        return coordinate < 0 && fmod(coordinate, height) != 0 ? Int(coordinate/height)-1 : Int(coordinate/height)
    }
}

// MARK: Comparable

extension TriangularElement {}
public func == <T, S>(lhs: TriangularElement<T, S>, rhs: TriangularElement<T, S>) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
public func < <T, S>(lhs: TriangularElement<T, S>, rhs: TriangularElement<T, S>) -> Bool {
    return lhs.y < rhs.y || (lhs.y == rhs.y && lhs.x < rhs.x)
}

// MARK: CustomDebugStringConvertible

extension TriangularElement {
    
    public var debugDescription: String { return "TriangularElement(\(self)" }
}
