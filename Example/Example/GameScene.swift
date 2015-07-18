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
    typealias TriangularElementType = TriangularElement<Bool, Bool>
    
    // MARK: BEGIN CUSTOMIZING
    
    // swap here for different element types!
    typealias ElementType = TriangularElementType
    
    // MARK: END CUSTOMIZING
    
    // MARK: Instance variables
    
    var grid = Grid<ElementType>()
    let spaceshipNode = SpaceshipNode()
    
    // MARK: Setup
    
    func moveSpaceshipToLocation(location: CGPoint) {
        spaceshipNode.position = location
        
        grid = Grid(ElementType.elementsInRect(view!.bounds))
        let polygon = spaceshipNode.vertices.map { CGPoint(x: $0.x+spaceshipNode.position.x-spaceshipNode.size.width/2, y: $0.y+spaceshipNode.position.y-spaceshipNode.size.height/2) }
        
        grid.addPolygon(polygon, allowInsertingElements: false) {
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
        
        TriangularElementArea.width = 40
        TriangularElementArea.height = sqrt(3) * 40/2
        
        backgroundColor = SKColor.whiteColor()
        
        let gridNode = SKNode()
        gridNode.name = "grid"
        addChild(gridNode)
        
        addChild(spaceshipNode)
        moveSpaceshipToLocation(CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            moveSpaceshipToLocation(location)
        }
    }
}
