//
//  ContactGrid.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 29.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

extension ContactGrid : ContactGridType {
    
    // MARK: Associated types
    
    public typealias SegmentEdgeType = Segment.Edge
    
    // MARK: Instance methods
    
    public mutating func addPolygon(var polygon: [CGPoint], @noescape withContactEdgeEffect contactEdgeEffect: (SegmentEdgeType -> ()), allowInsertingSegments: Bool) {
        
        guard polygon.count > 2 else { return } // polygons must at least form a triangle
        for index in Array(0...polygon.count-1).filter({ polygon[$0] == polygon[($0+1)%polygon.count] }).reverse() {
            polygon.removeAtIndex(index)    // delete equal neighbors
        }
        guard polygon.count > 2 else { return } // polygons must still at least form a triangle
        
        polygon = polygon.map { CGPoint(x: $0.x/Segment.width, y: $0.y/Segment.height) }    // make points independent of segment width and height
        let lines = Array(0...polygon.count-1).map {
            // build line segments out of polygon points
            LineSegment(startPoint: polygon[$0], endPoint: polygon[($0+1)%polygon.count])
        }
        
        func addIntersection(intersection: Intersection, toPoint point: CGPoint) {
        }
        
        for line in lines {
            // get starting and ending segment points of the line segment
            let startSegmentPoint = segmentPointOfRelativePosition(line.startPoint)
            let endSegmentPoint = segmentPointOfRelativePosition(line.endPoint)
            
            if line.isHorizontal {
                
                let cut = line.function(0)-CGFloat(startSegmentPoint.1) // relative horizontal cut point through segment
                
                // start and end edge are dependent to horizontal line segment direction
                let startEdge = line.startPoint.x < line.endPoint.x ? Segment.Edge.Value.Left : .Right
                let endEdge = startEdge == .Left ? Segment.Edge.Value.Right : .Left
                
                for x in min(startSegmentPoint.0, endSegmentPoint.0)...max(startSegmentPoint.0, endSegmentPoint.0) {
                    let intersection = Intersection(startEdge: startEdge, startCut: cut, endEdge: endEdge, endCut: cut)
                    addIntersection(intersection, toPoint: CGPoint(x: x, y: startSegmentPoint.1))
                }
            }
            else if line.isVertical {
                
                let cut = line.inverseFunction(0)-CGFloat(startSegmentPoint.0)  // relative vertical cut point through segment
                
                // start and end edge are dependent to vertical line segment direction
                let startEdge = line.startPoint.y < line.endPoint.y ? Segment.Edge.Value.Bottom : .Top
                let endEdge = startEdge == .Bottom ? Segment.Edge.Value.Top : .Bottom
                
                for y in min(startSegmentPoint.1, endSegmentPoint.1)...max(startSegmentPoint.1, endSegmentPoint.1) {
                    let intersection = Intersection(startEdge: startEdge, startCut: cut, endEdge: endEdge, endCut: cut)
                    addIntersection(intersection, toPoint: CGPoint(x: startSegmentPoint.0, y: y))
                }
            }
            else {
                
                // get slope and direction of the line segment
                let slopeIsPositive = line.startPoint.y < line.endPoint.y
                let directionIsPositive = line.startPoint.x < line.endPoint.x
                
                // get segments between startSegmentPoint and endSegmentPoint that intersects with the line
                var startY = startSegmentPoint.1
                for x in min(startSegmentPoint.0, endSegmentPoint.0)...max(startSegmentPoint.0, endSegmentPoint.0) {
                
                    var endY = segmentPlaceOfRelativeCoordinate(line.function(CGFloat(x+1)))
                    
                    // TODO: ggf endY abmindern, wenn line.function gerades ergebnis liefert?
                    // es muss wirklich top oder bottom geschnitten werden!
                    
                    endY = slopeIsPositive ? min(endY, endSegmentPoint.1) : max(endY, endSegmentPoint.1)
                    
                    for y in min(startY, endY)...max(startY, endY) {    // line intersects with the segment (x, y)

                        // TODO: berücksichtige schnittpunkt ecke!, d.h zum beispiel left und cut 0 oder 1, oder bottom und cut 0 oder 1
                        
                        // calculate start edge
                        let startXCoordinate = line.inverseFunction(slopeIsPositive ? CGFloat(y) : CGFloat(y+1))
                        let startEdge: Segment.Edge.Value
                        let startCut: CGFloat
                        
                        if x == segmentPlaceOfRelativeCoordinate(startXCoordinate) {
                            // startEdge is .Top or .Bottom
                            startEdge = slopeIsPositive ? .Bottom : .Top
                            startCut = startXCoordinate - CGFloat(x)
                        }
                        else {
                            // startEdge is .Left or .Right
                            startEdge = directionIsPositive ? .Left : .Right
                            startCut = line.function(directionIsPositive ? CGFloat(x) : CGFloat(x+1)) - CGFloat(x)
                        }
                        
                        // calculate end edge
                        let endXCoordinate = line.inverseFunction(slopeIsPositive ? CGFloat(y+1) : CGFloat(y))
                        let endEdge: Segment.Edge.Value
                        let endCut: CGFloat
                        
                        if x == segmentPlaceOfRelativeCoordinate(endXCoordinate) {
                            // endEdge is .Top or .Bottom
                            endEdge = slopeIsPositive ? .Top : .Bottom
                            endCut = endXCoordinate - CGFloat(x)
                        }
                        else {
                            // endEdge is .Left or .Right
                            endEdge = directionIsPositive ? .Right : .Left
                            endCut = line.function(directionIsPositive ? CGFloat(x+1) : CGFloat(x)) - CGFloat(x)
                        }
                        
                        let intersection = Intersection(startEdge: startEdge, startCut: startCut, endEdge: endEdge, endCut: endCut)
                        addIntersection(intersection, toPoint: CGPoint(x: x, y: y))
                    }
                    
                    startY = endY
                }
            }
        }
        
        // update grid
    }
    
    // MARK: Helper structs
    
    private struct LineSegment {
        
        init(startPoint: CGPoint, endPoint: CGPoint) {
            if startPoint == endPoint { fatalError("start point of line is equal to end point") }
            
            self.startPoint = startPoint
            self.endPoint = endPoint
        }
        
        var startPoint: CGPoint
        var endPoint: CGPoint
        
        var isHorizontal: Bool { return startPoint.y == endPoint.y }
        var isVertical: Bool { return startPoint.x == endPoint.x }
        
        func function(x: CGFloat) -> CGFloat {
            if isVertical { fatalError("line is vertical") }
            return startPoint.y + ((endPoint.y-startPoint.y)/(endPoint.x-startPoint.x)) * (x - startPoint.x)
        }
        
        func inverseFunction(y: CGFloat) -> CGFloat {
            if isHorizontal { fatalError("line is horizontal") }
            return startPoint.x + ((endPoint.x-startPoint.x)/(endPoint.y-startPoint.y)) * (y - startPoint.y)
        }
    }
    
    private struct Intersection {
        
        init(startEdge: Segment.Edge.Value, startCut: CGFloat, endEdge: Segment.Edge.Value, endCut: CGFloat) {
            if startEdge == endEdge { fatalError("intersection can not have equal start and end edges") }
            if startCut < 0 || startCut > 1 { fatalError("start cut has invalid value") }
            if endCut < 0 || endCut > 1 { fatalError("end cut has invalid value") }
            
            self.startEdge = startEdge
            self.startCut = startCut
            
            self.endEdge = endEdge
            self.endCut = endCut
        }
        
        let startEdge: Segment.Edge.Value
        let startCut: CGFloat
        
        let endEdge: Segment.Edge.Value
        let endCut: CGFloat
        
        var contactedEdges: Set<Segment.Edge.Value> {
            
            switch (startEdge, endEdge) {
                
            case (.Left, .Top): return Segment.Edge.allValues
            case (.Left, .Bottom): return [.Left, .Bottom]
            case (.Left, .Right):
                if (startCut+endCut)/2 < 0.5 { return [.Left, .Right, .Bottom] }
                else { return Segment.Edge.allValues }
                
            case (.Top, .Right): return Segment.Edge.allValues
            case (.Top, .Left): return [.Top, .Left]
            case (.Top, .Bottom):
                if (startCut+endCut)/2 < 0.5 { return [.Top, .Bottom, .Left] }
                else { return Segment.Edge.allValues }
                
            case (.Right, .Bottom): return Segment.Edge.allValues
            case (.Right, .Top): return [.Right, .Top]
            case (.Right, .Left):
                if (startCut+endCut)/2 < 0.5 { return Segment.Edge.allValues }
                else { return [.Right, .Left, .Top] }
                
            case (.Bottom, .Left): return Segment.Edge.allValues
            case (.Bottom, .Right): return [.Bottom, .Right]
            case (.Bottom, .Top):
                if (startCut+endCut)/2 < 0.5 { return Segment.Edge.allValues }
                else { return [.Bottom, .Top, .Right] }
                
            default: return []
            }
        }
    }
    
    // MARK: Helper methods
    
    private func segmentPlaceOfRelativeCoordinate(coordinate: CGFloat) -> Int {
        return coordinate < 0 && fmod(coordinate, 1) != 0 ? Int(coordinate)-1 : Int(coordinate)
    }
    
    private func segmentPointOfRelativePosition(position: CGPoint) -> (Int, Int) {
        return (segmentPlaceOfRelativeCoordinate(position.x), segmentPlaceOfRelativeCoordinate(position.y))
    }
}

/*extension CGPoint : Hashable {
    
    public var hashValue: Int { return "\(x):\(y)".hashValue }
}*/
