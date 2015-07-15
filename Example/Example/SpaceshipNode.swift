//
//  SpaceshipNode.swift
//  Example
//
//  Created by Matthias Fey on 15.07.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import SpriteKit

class SpaceshipNode : SKNode {
    
    override init() {
        super.init()
        
        let spriteNode = SKSpriteNode(imageNamed: "Spaceship")
        spriteNode.name = "sprite"
        spriteNode.xScale = 0.5
        spriteNode.yScale = 0.5
        addChild(spriteNode)
        
        let path = CGPathCreateMutable()
        for (index, vertex) in vertices.map({ CGPoint(x: $0.x-spriteNode.size.width/2, y: $0.y-spriteNode.size.height/2) }).enumerate() {
            if index == 0 { CGPathMoveToPoint(path, nil, vertex.x, vertex.y) }
            else { CGPathAddLineToPoint(path, nil, vertex.x, vertex.y) }
        }
        CGPathCloseSubpath(path)
        
        let borderNode = SKShapeNode(path: path)
        borderNode.name = "border"
        borderNode.lineWidth = 2
        borderNode.strokeColor = SKColor.greenColor()
        addChild(borderNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var vertices: [CGPoint] {
        return [CGPoint(x: 98, y: 6), CGPoint(x: 92, y: 0), CGPoint(x: 80, y: 0), CGPoint(x: 72, y: 16), CGPoint(x: 16, y: 16), CGPoint(x: 0, y: 42), CGPoint(x: 0, y: 48), CGPoint(x: 68, y: 106), CGPoint(x: 68, y: 122), CGPoint(x: 82, y: 128), CGPoint(x: 84, y: 144), CGPoint(x: 98, y: 172), CGPoint(x: 112, y: 144), CGPoint(x: 114, y: 128), CGPoint(x: 128, y: 122), CGPoint(x: 128, y: 106), CGPoint(x: 196, y: 48), CGPoint(x: 196, y: 48), CGPoint(x: 196, y: 42), CGPoint(x: 180, y: 16), CGPoint(x: 124, y: 16), CGPoint(x: 116, y: 0), CGPoint(x: 104, y: 0)]
    }
    
    var size: CGSize { return (childNodeWithName("sprite") as! SKSpriteNode).size }
}
