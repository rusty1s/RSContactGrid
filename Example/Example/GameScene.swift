//
//  GameScene.swift
//  Example
//
//  Created by Matthias Fey on 14.07.15.
//  Copyright © 2015 Matthias Fey. All rights reserved.
//

import SpriteKit
import RSContactGrid

class GameScene : SKScene {
    
    // MARK: Associated types
    
    typealias SquareElementType = SquareElement<Bool, Bool>
    
    typealias ElementType = SquareElementType
    
    // MARK: Instance variables
    
    var grid = Grid<ElementType>()
    let spaceship = SKSpriteNode()
    
    // MARK: Setup
    
    func moveSpaceshipToLocation(location: CGPoint) {
        spaceship.position = location
        
        grid = Grid(ElementType.elementsInRect(view!.bounds))
        grid.addPolygon([CGPoint(x: 100, y: 100), CGPoint(x: 150, y: 150), CGPoint(x: 180, y: 60)], allowInsertingElements: false) {
            var element = $0
            element.contact = true
            return element
        }
        
        let gridNode = childNodeWithName("grid")
        gridNode?.removeAllChildren()
        for element in grid {
            let node = GridElementNode(element: element)
            gridNode?.addChild(node)
        }
        
        grid.removeAll()
    }
    
    override func didMoveToView(view: SKView) {
        SquareElementArea.width = 40
        SquareElementArea.height = 40
        
        backgroundColor = SKColor.whiteColor()
        
        let gridNode = SKNode()
        gridNode.name = "grid"
        addChild(gridNode)
        
        addChild(spaceship)
        moveSpaceshipToLocation(CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            moveSpaceshipToLocation(location)
        }
    }
}
