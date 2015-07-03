//
//  ContactGridElementType.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

public protocol ContactGridElementType : GridElementType {
    
    // MARK: Associated types
    
    typealias Contact
    
    // MARK: Instance variables
    
    /// The contact stored by the element.
    var contact: Contact? { get set }
    
    // MARK: Static functions
    
    static func elementsInLineFromPoint(startPoint: CGPoint, toPoint endPoint: CGPoint) -> Set<Self>
    
    static func elementsInRect(rect: CGRect) -> Set<Self>
}

// MARK: Default implementations

extension ContactGridElementType {
    
    /// Create a `ContactGridElementType` at x- and y-coordinates with a specific content
    /// and contact.
    init(x: Int, y: Int, content: Content?, contact: Contact?) {
        self.init(x: x, y: y, content: content)
        self.contact = contact
    }
    
    /// The minimal frame rectangle, which describes the element's location and
    /// size in its grid's coordinate system.  The frame contains all vertices
    /// of the element.
    var frame: CGRect {
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
    var center: CGPoint {
        let frame = self.frame
        return CGPoint(x: frame.origin.x+frame.size.width/2, y: frame.origin.y+frame.size.height)
    }
}
