//
//  GridContactDetection.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 23.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

// MARK: Default implementations

extension GridType {
    
    /// Adds a virtual polygon into the grid and defines behavior for
    /// overlayed elements.
    /// - Parameter polygon: The vertices of the polygon as a finite
    /// sequence of `CGPoint`.
    /// - Parameter allowInsertingElements: allows the grid to insert element,
    /// which are overlayed by the polygon, but are not yet inserted into the grid.
    /// - Parameter resolveContact: the behavior of a `ElementType` that is overlayed
    /// by the polygon.
    final public mutating func addPolygon(var polygon: [CGPoint], allowInsertingElements: Bool = true, @noescape resolveContact: ElementType -> ElementType) {
        
        // error handling
        guard polygon.count > 2 else { return } // polygon must at least form a triangle
        for index in Array(0...polygon.count-1).filter({ polygon[$0] == polygon[($0+1)%polygon.count] }).reverse() {
            polygon.removeAtIndex(index)    // delete equal neighbors
        }
        guard polygon.count > 2 else { return } // polygon must still at least form a triangle

        var contactedElements = Set<ElementType>()
        
        // check if the line intersects with the given frame
        // if `true`, the method returns the frame's collision points
        func line(startPoint startPoint: CGPoint, endPoint: CGPoint, intersectsRect rect: CGRect) -> (RelativeRectEdgePoint, RelativeRectEdgePoint)? {
            
            if startPoint.y == endPoint.y { // line is horizontal
                if startPoint.y >= rect.origin.y && startPoint.y <= rect.origin.y+rect.size.height {
                    // line goes trough rect
                    let collisionPoint = (startPoint.y-rect.origin.y)/rect.size.height
                    return (RelativeRectEdgePoint(x: 0, y: collisionPoint)!, RelativeRectEdgePoint(x: 1, y: collisionPoint)!)
                }
                else { return nil }
            }
            
            if startPoint.x == endPoint.x { // line is vertical
                if startPoint.x >= rect.origin.x && startPoint.x <= rect.origin.x+rect.size.width {
                    // line goes trough rect
                    let collisionPoint = (startPoint.x-rect.origin.x)/rect.size.width
                    return (RelativeRectEdgePoint(x: collisionPoint, y: 0)!, RelativeRectEdgePoint(x: collisionPoint, y: 1)!)
                }
                else { return nil }
            }
            
            let function: CGFloat -> CGFloat = { return startPoint.y + ((endPoint.y-startPoint.y)/(endPoint.x-startPoint.x)) * ($0 - startPoint.x) }
            let inverseFunction: CGFloat -> CGFloat = { return startPoint.x + ((endPoint.x-startPoint.x)/(endPoint.y-startPoint.y)) * ($0 - startPoint.y) }
            
            let y1 = (function(rect.origin.x)-rect.origin.y)/rect.size.height
            let x1 = (inverseFunction(rect.origin.y)-rect.origin.x)/rect.size.width
            let y2 = (function(rect.origin.x+rect.size.width)-rect.origin.y)/rect.size.height
            let x2 = (inverseFunction(rect.origin.y+rect.size.height)-rect.origin.x)/rect.size.height
            
            var contactPoints = Set<CGPoint>()
            if y1 >= 0 && y1 <= 1 { // left edge
                contactPoints.insert(CGPoint(x: 0, y: y1))
            }
            if x1 >= 0 && x1 <= 1 { // bottom edge
                contactPoints.insert(CGPoint(x: x1, y: 0))
            }
            if y2 >= 0 && y2 <= 1 { // right edge
                contactPoints.insert(CGPoint(x: 1, y: y2))
            }
            if x2 >= 0 && x2 <= 1 { // top edge
                contactPoints.insert(CGPoint(x: x2, y: 1))
            }
            
            assert(contactPoints.count <= 2)
            if contactPoints.count == 1 && contactPoints.first! != CGPoint(x: 0, y: 0) { return nil }
            
            if contactPoints.count == 1 {   // one collision point
                let edgePoint = RelativeRectEdgePoint(x: 0, y: 0)!
                return (edgePoint, edgePoint)
            }
            else if contactPoints.count == 2 {  // two collision points
                let array = Array(contactPoints)
                return (RelativeRectEdgePoint(x: array[0].x, y: array[0].y)!, RelativeRectEdgePoint(x: array[1].x, y: array[1].y)!)
            }
            else { return nil } // no collision point
        }
        
        // mark all elements that intersect with the polygon's border as contacted
        for index in Array(0...polygon.count-1) {
            let startPoint = polygon[index]
            let endPoint = polygon[(index+1)%polygon.count]
            
            // define rect built by the start and end points of the line segment
            let lineRect = CGRect(x: min(startPoint.x, endPoint.x),
                                  y: min(startPoint.y, endPoint.y),
                                  width: abs(endPoint.x-startPoint.x),
                                  height: abs(endPoint.y-startPoint.y))
            
            // get possible contacted elements by the line segment
            let elements = ElementType.elementsInRect(lineRect)
            for element in elements {
                // detect rect edge points of the element's frame, if line intersects
                if let edgePoints = line(startPoint: startPoint, endPoint: endPoint, intersectsRect: element.frame) {
                    // detect if the line intersects the element
                    if element.intersectsLineThroughFrameAtEdgePoints(point1: edgePoints.0, point2: edgePoints.1) {
                        contactedElements.insert(element)
                    }
                }
            }
        }
        
        // get the frame of the polygon
        var minX = CGFloat.max
        var maxX = CGFloat.min
        var minY = CGFloat.max
        var maxY = CGFloat.min
        
        for point in polygon {
            minX = min(minX, point.x)
            maxX = max(maxX, point.x)
            minY = min(minY, point.y)
            maxY = max(maxY, point.y)
        }
        let polygonFrame = CGRect(x: minX, y: minY, width: maxX-minX, height: maxY-minY)
        
        // calculate remaining elements that may be contacted by the polygon
        var remainingElements = ElementType.elementsInRect(polygonFrame)
        remainingElements.subtractInPlace(contactedElements)
        
        // point in polygon test (ray casting to the left)
        // http://stackoverflow.com/questions/11716268/point-in-polygon-algorithm
        func point(point: CGPoint, inPolygon polygon: [CGPoint]) -> Bool {
            var even = true
            
            for index in Array(0...polygon.count-1) {
                let startPoint = polygon[index]
                let endPoint = polygon[(index+1)%polygon.count]
                
                // point must be between start and end point y coordinates
                let pointBetweenYCoordinates = point.y <= max(startPoint.y, endPoint.y) && point.y >= min(startPoint.y, endPoint.y)
                // check if vertical line
                let verticalLine = startPoint.y == endPoint.y && point.x < min(startPoint.x, endPoint.x)
                // check if point is on the left side of the line
                let pointOnLeftSide = point.x < startPoint.x+((endPoint.x-startPoint.x)/(endPoint.y-startPoint.y))*(point.y-startPoint.y)
                
                if pointBetweenYCoordinates && (verticalLine || pointOnLeftSide) { even = !even }
            }
            
            return !even
        }
        
        // iterate through all remaining elements
        // and check if their center is inside or outside of the polygon
        // if inside, mark the element as contacted
        for element in remainingElements {
            if point(element.center, inPolygon: polygon) { contactedElements.insert(element) }
        }
        
        // iterate through contacted elements and resolve contacts
        delegate?.didBeginResolveContacts()
        for element in contactedElements {
            if let removedElement = remove(element) {
                let resolvedElement = resolveContact(removedElement)
                insert(resolvedElement)
                delegate?.didResolveContactInElement(resolvedElement)
            }
            else {
                if allowInsertingElements {
                    let resolvedElement = resolveContact(element)
                    insert(resolvedElement)
                    delegate?.didResolveContactInElement(resolvedElement)
                }
            }
        }
        delegate?.didEndResolveContacts()
    }
}

// MARK: Helper

extension CGPoint : Hashable {
    
    public var hashValue: Int { return "\(x):\(y)".hashValue }
}
