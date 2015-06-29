//
//  ContactGrid.swift
//  RSContactGrid
//
//  Created by Matthias Fey on 29.06.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

extension ContactGrid : ContactGridType {
    
    public typealias SegmentEdgeType = Segment.Edge
    
    public mutating func addPolygon(polygon: [CGPoint], withContactEdgeEffect: (SegmentEdgeType -> ()), allowInsertingSegments: Bool = true) {
        
        // MARK: Helper
        
        struct LineSegment {
            
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
        
        // MARK: Calculations
        
        guard polygon.count > 2 else { return }
        
        let relPolygon = polygon.map { CGPoint(x: $0.x/Segment.width, y: $0.y/Segment.height) }
        let lines = Array<Int>(0...polygon.endIndex).map {
            LineSegment(startPoint: relPolygon[$0], endPoint: relPolygon[$0+1%polygon.count])
        }
        
        for line in lines {
            
            if line.isHorizontal {
                
            }
            else if line.isVertical {
                
            }
            else {
                
            }
        }
        
        // TODO
    }
}
