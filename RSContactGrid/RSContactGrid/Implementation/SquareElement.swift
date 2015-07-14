//
//  SquareElement.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public struct SquareElement : ContactGridElementType {
    
    // MARK: Associated types
    
    public typealias Content = AnyObject
    
    public typealias Contact = AnyObject
    
    // MARK: Instance variables
    
    public let x: Int
    
    public let y: Int
    
    public var content: Content?
    
    public var contact: Contact?
    
    // MARK: Static variables
    
    // The width of an element.
    public static var width: CGFloat = 20
    
    // The height of an element.
    public static var height: CGFloat = 20
}


// MARK: Initializers

extension SquareElement {

    public init (x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

// MARK: Instance variables

extension SquareElement {
    
    public var frame: CGRect {
        return CGRect(x: CGFloat(x)*SquareElement.width, y: CGFloat(y)*SquareElement.height, width: SquareElement.width, height: SquareElement.height)
    }

    public var vertices: [CGPoint] {
        return [CGPoint(x: CGFloat(x)*SquareElement.width, y: CGFloat(y)*SquareElement.height),
                CGPoint(x: CGFloat(x)*SquareElement.width, y: CGFloat(y+1)*SquareElement.height),
                CGPoint(x: CGFloat(x+1)*SquareElement.width, y: CGFloat(y+1)*SquareElement.height),
                CGPoint(x: CGFloat(x+1)*SquareElement.width, y: CGFloat(y)*SquareElement.height)]
    }
}

// MARK: Static functions

extension SquareElement {

    public static func elementsInLineFromPoint(startPoint: CGPoint, toPoint endPoint: CGPoint) -> Set<SquareElement> {
        
        let startSegment = segmentOfCoordinates(startPoint)
        let endSegment = segmentOfCoordinates(endPoint)
        
        if startPoint.y == endPoint.y {     // line is horizontal
            var elements = Set<SquareElement>(minimumCapacity: abs(endSegment.0-startSegment.0))
            for x in min(startSegment.0, endSegment.0)...max(startSegment.0, endSegment.0) {
                elements.insert(SquareElement(x: x, y: startSegment.1))
            }
            return elements
        }
        else if startPoint.x == endPoint.x {    // line is vertical
            var elements = Set<SquareElement>(minimumCapacity: abs(endSegment.1-startSegment.1))
            for y in min(startSegment.1, endSegment.1)...max(startSegment.1, endSegment.1) {
                elements.insert(SquareElement(x: startSegment.0, y: y))
            }
            return elements
        }
        else {
            // get slope and direction of the line segment
            let slopeIsPositive = startPoint.y < endPoint.y
            let directionIsPositive = startPoint.x < endPoint.x
            
            // the function of the line segment
            let function: (CGFloat) -> (CGFloat) = { return startPoint.y + (endPoint.y-startPoint.y)/(endPoint.x-startPoint.x) * ($0 - startPoint.x) }
            
            var elements = Set<SquareElement>()
            var tempStartY = directionIsPositive ? startSegment.1 : endSegment.1
            let endY = directionIsPositive ? endSegment.1 : startSegment.1
            // iterate through all relevant horizontal segments
            for x in min(startSegment.0, endSegment.0)...max(startSegment.0, endSegment.0) {
               
                let realTempEndY = slopeIsPositive ? function(CGFloat(x+1)) : function(CGFloat(x))
                var tempEndY = segmentYOfCoordinate(realTempEndY)
                tempEndY = slopeIsPositive ? min(tempEndY, endY) : max(tempEndY, endY)
                
                // iterate through all relevant vertical segments in its x-coordinate
                for y in min(tempStartY, tempEndY)...max(tempStartY, tempEndY) {
                    elements.insert(SquareElement(x: x, y: y))
                }
                tempStartY = tempEndY
            }
            return elements
        }
    }
    
    public static func elementsInRect(rect: CGRect) -> Set<SquareElement> {
        
        let startSegment = segmentOfCoordinates(rect.origin)
        let endSegment = segmentOfCoordinates(CGPoint(x: rect.origin.x+rect.size.width, y: rect.origin.y+rect.size.height))
        
        var elements = Set<SquareElement>(minimumCapacity: (endSegment.0-startSegment.0)*(endSegment.1-startSegment.1))
        for x in startSegment.0...endSegment.0 {
            for y in startSegment.1...endSegment.1 {
                elements.insert(SquareElement(x: x, y: y))
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
public func == (lhs: SquareElement, rhs: SquareElement) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
public func < (lhs: SquareElement, rhs: SquareElement) -> Bool {
    return lhs.y < rhs.y || (lhs.y == rhs.y && lhs.x < rhs.x)
}

// MARK: CustomDebugStringConvertible

extension SquareElement {

    public var debugDescription: String { return "SquareElement(\(self)" }
}
