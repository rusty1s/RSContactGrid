//
//  GridElementNode.swift
//  Example
//
//  Created by Matthias Fey on 15.07.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import SpriteKit

class GridElementNode : SKShapeNode {
    
    init(element: GameScene.ElementType) {
        let path = CGPathCreateMutable()
        for (index, vertex) in element.vertices.enumerate() {
            if index == 0 { CGPathMoveToPoint(path, nil, vertex.x, vertex.y) }
            else { CGPathAddLineToPoint(path, nil, vertex.x, vertex.y) }
        }
        CGPathCloseSubpath(path)
        
        super.init()
        
        self.path = path
        lineWidth = 1
        strokeColor = SKColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        if element.contact != nil {
            fillColor = SKColor.redColor()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
