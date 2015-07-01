//
//  ContactGrid.Segment.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 24.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

// MARK: Initializers

extension ContactGrid.Segment {

    public init (x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

// MARK: Instance methods

extension ContactGrid.Segment {
    
    public var frame: CGRect {
        return CGRect(x: CGFloat(x)*ContactGrid.Segment.width, y: CGFloat(y)*ContactGrid.Segment.height, width: ContactGrid.Segment.width, height: ContactGrid.Segment.height)
    }
}

// MARK: Comparable

extension ContactGrid.Segment {}
public func == (lhs: ContactGrid.Segment, rhs: ContactGrid.Segment) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}
public func < (lhs: ContactGrid.Segment, rhs: ContactGrid.Segment) -> Bool {
    return lhs.y < rhs.y || (lhs.y == rhs.y && lhs.x < rhs.x)
}

// MARK: CustomDebugStringConvertible

extension ContactGrid.Segment {

    public var debugDescription: String { return "ContactGrid.Segment(\(self)" }
}
