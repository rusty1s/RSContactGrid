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
    /// - Parameter polygon: The vertices of the polygon as a clockwise finite
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

        let indexes = Array(0...polygon.count-1)
        
        // get frame rectangle of the polygon
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
        // get all elements that may be overlayed by the polygon
        var elements = ElementType.elementsInRect(polygonFrame)
        
        // mark all elements that intersect with the polygon's border as contacted
        var contactedElements = Set<ElementType>()
        for index in indexes {
            let startPoint = polygon[index]
            let endPoint = polygon[(index+1)%polygon.count]
            
            contactedElements.unionInPlace(ElementType.elementsInLineFromPoint(startPoint, toPoint: endPoint))
        }
        
        // iterate through all remaining elements
        // and check if their center is inside or outside of the polygon
        // if inside, mark the element as contacted
        // http://stackoverflow.com/questions/11716268/point-in-polygon-algorithm
        elements.subtractInPlace(contactedElements)
        for element in elements {
            var even = true
            
            for index in indexes {
                let startPoint = polygon[index]
                let endPoint = polygon[(index+1)%polygon.count]
                let point = element.center
                
                // point must be between start and end point y coordinates
                let pointBetweenYCoordinates = point.y <= max(startPoint.y, endPoint.y) && point.y >= min(startPoint.y, endPoint.y)
                // check if vertical line
                let verticalLine = startPoint.y == endPoint.y && point.x < min(startPoint.x, endPoint.x)
                // check if point is on the left side of the line
                let pointOnLeftSide = point.x < startPoint.x+((endPoint.x-startPoint.x)/(endPoint.y-startPoint.y))*(point.y-startPoint.y)
                
                if pointBetweenYCoordinates && (verticalLine || pointOnLeftSide) { even = !even }
            }
            
            if !even { contactedElements.insert(element) }
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
