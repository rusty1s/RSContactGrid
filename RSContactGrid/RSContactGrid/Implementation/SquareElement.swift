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
        self.content = nil
        self.contact = nil
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
        return Set<SquareElement>()
    }
    
    public static func elementsInRect(rect: CGRect) -> Set<SquareElement> {
        return Set<SquareElement>()
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
