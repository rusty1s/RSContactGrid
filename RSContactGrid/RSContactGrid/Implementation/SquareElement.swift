//
//  SquareElement.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public struct SquareElementArea {
    
    // MARK: Static variables
    
    /// Defines the width of a squared element.
    public static var width: CGFloat = 20
    
    /// Defines the height of a squared element.
    public static var height: CGFloat = 20
}

public struct SquareElement<T, S> : GridElementType {
    
    // MARK: Initializers
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    /// Create a `SquareElement` at x- and y-coordinates with specific
    /// content and contact.
    public init(x: Int, y: Int, content: T?, contact: S?) {
        self.init(x: x, y: y)
        self.content = content
        self.contact = contact
    }
    
    // MARK: Instance variables
    
    public let x: Int
    
    public let y: Int
    
    /// The content stored by the `SquareElement`.
    public var content: T?
    
    /// The contact stored by the `SquareElement`.
    public var contact: S?
    
    // MARK: Static variables
    
    // The width of the element.
    public static var width: CGFloat { return SquareElementArea.width }
    
    // The height of the element.
    public static var height: CGFloat { return SquareElementArea.height }
}

// MARK: Instance variables

extension SquareElement {
    
    public var frame: CGRect {
        return CGRect(x: CGFloat(x)*SquareElement<T, S>.width,
                      y: CGFloat(y)*SquareElement<T, S>.height,
                      width: SquareElement<T, S>.width,
                      height: SquareElement<T, S>.height)
    }

    public var vertices: [CGPoint] {
        return [CGPoint(x: CGFloat(x)*SquareElement<T, S>.width, y: CGFloat(y)*SquareElement<T, S>.height),
                CGPoint(x: CGFloat(x)*SquareElement<T, S>.width, y: CGFloat(y+1)*SquareElement<T, S>.height),
                CGPoint(x: CGFloat(x+1)*SquareElement<T, S>.width, y: CGFloat(y+1)*SquareElement<T, S>.height),
                CGPoint(x: CGFloat(x+1)*SquareElement<T, S>.width, y: CGFloat(y)*SquareElement<T, S>.height)]
    }
}

// MARK: Static functions

extension SquareElement {

    public static func elementsInLineFromPoint<T, S>(startPoint: CGPoint, toPoint endPoint: CGPoint) -> Set<SquareElement<T, S>> {
        
        let startSegment = segmentOfCoordinates(startPoint)
        let endSegment = segmentOfCoordinates(endPoint)
        
        if startPoint.y == endPoint.y {     // line is horizontal
            var elements = Set<SquareElement<T, S>>(minimumCapacity: abs(endSegment.0-startSegment.0))
            for x in min(startSegment.0, endSegment.0)...max(startSegment.0, endSegment.0) {
                elements.insert(SquareElement<T, S>(x: x, y: startSegment.1))
            }
            return elements
        }
        else if startPoint.x == endPoint.x {    // line is vertical
            var elements = Set<SquareElement<T, S>>(minimumCapacity: abs(endSegment.1-startSegment.1))
            for y in min(startSegment.1, endSegment.1)...max(startSegment.1, endSegment.1) {
                elements.insert(SquareElement<T, S>(x: startSegment.0, y: y))
            }
            return elements
        }
        else {
            // get slope and direction of the line segment
            let slopeIsPositive = startPoint.y < endPoint.y
            let directionIsPositive = startPoint.x < endPoint.x
            
            // the function of the line segment
            let function: (CGFloat) -> (CGFloat) = { return startPoint.y + ((endPoint.y-startPoint.y)/(endPoint.x-startPoint.x)) * ($0 - startPoint.x) }
            
            var elements = Set<SquareElement<T, S>>()
            var tempStartY = directionIsPositive ? startSegment.1 : endSegment.1
            let endY = directionIsPositive ? endSegment.1 : startSegment.1
            // iterate through all relevant horizontal segments
            for x in min(startSegment.0, endSegment.0)...max(startSegment.0, endSegment.0) {
               
                let realTempEndY = directionIsPositive ? function(CGFloat(x+1)*width) : function(CGFloat(x)*width)
                var tempEndY = segmentYOfCoordinate(realTempEndY)
                
                // adjust contacted elements when line segment goes through edge
                // needs only adjustment if slope is positive
                if slopeIsPositive && fmod(realTempEndY, width) == 0 {
                    if directionIsPositive { tempEndY-- }
                }
                
                tempEndY = slopeIsPositive ? min(tempEndY, endY) : max(tempEndY, endY)

                // iterate through all relevant vertical segments in its x-coordinate
                for y in min(tempStartY, tempEndY)...max(tempStartY, tempEndY) {
                    elements.insert(SquareElement<T, S>(x: x, y: y))
                }
                tempStartY = tempEndY
                
                // adjust contacted elements when line segment goes through edge
                // needs only adjustment if slope is positive
                if slopeIsPositive && fmod(realTempEndY, width) == 0 {
                    if directionIsPositive { tempStartY++ }
                    else { tempStartY-- }
                }
            }
            return elements
        }
    }
    
    public static func elementsInRect<T, S>(rect: CGRect) -> Set<SquareElement<T, S>> {
        
        let startSegment = segmentOfCoordinates(rect.origin)
        let endSegment = segmentOfCoordinates(CGPoint(x: rect.origin.x+rect.size.width, y: rect.origin.y+rect.size.height))
        
        var elements = Set<SquareElement<T, S>>(minimumCapacity: (endSegment.0-startSegment.0)*(endSegment.1-startSegment.1))
        for x in startSegment.0...endSegment.0 {
            for y in startSegment.1...endSegment.1 {
                elements.insert(SquareElement<T, S>(x: x, y: y))
            }
        }
        return elements
    }
    
    private static func segmentXOfCoordinate(coordinate: CGFloat) -> Int {
        return coordinate < 0 && fmod(coordinate, width) != 0 ? Int(coordinate/width)-1 : Int(coordinate/width)
    }
    
    private static func segmentYOfCoordinate(coordinate: CGFloat) -> Int {
        return coordinate < 0 && fmod(coordinate, height) != 0 ? Int(coordinate/height)-1 : Int(coordinate/height)
    }
    
    private static func segmentOfCoordinates(coordinates: CGPoint) -> (Int, Int) {
        return (segmentXOfCoordinate(coordinates.x), segmentYOfCoordinate(coordinates.y))
    }
}

// MARK: Comparable

extension SquareElement {}
public func == <T, S>(lhs: SquareElement<T, S>, rhs: SquareElement<T, S>) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
public func < <T, S>(lhs: SquareElement<T, S>, rhs: SquareElement<T, S>) -> Bool {
    return lhs.y < rhs.y || (lhs.y == rhs.y && lhs.x < rhs.x)
}

// MARK: CustomDebugStringConvertible

extension SquareElement {

    public var debugDescription: String { return "SquareElement(\(self)" }
}
