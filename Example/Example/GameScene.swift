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
    
    typealias TriangularTileType = TriangularTile<Bool, Bool>
    typealias SquareTileType = SquareTile<Bool, Bool>
    typealias RotatedSquareTileType = RotatedSquareTile<Bool, Bool>
    typealias HexagonalTileType = HexagonalTile<Bool, Bool>
    
    // MARK: BEGIN CUSTOMIZING
    
    // swap here for different element types!
    typealias TileType = HexagonalTileType
    
    // MARK: END CUSTOMIZING
    
    // MARK: Instance variables
    
    var grid = Grid<TileType>()
    let spaceshipNode = SpaceshipNode()
    
    // MARK: Setup
    
    func moveSpaceshipToLocation(location: CGPoint) {
        spaceshipNode.position = location
        
        grid = Grid(TileType.tilesInRect(view!.bounds))
        let path = spaceshipNode.vertices.map { CGPoint(x: $0.x+spaceshipNode.position.x-spaceshipNode.size.width/2, y: $0.y+spaceshipNode.position.y-spaceshipNode.size.height/2) }
        
        grid.detectContactedTilesOfPath(path, closedPath: true, allowInsertingTiles: false) {
            $0.data.contact = true
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
        TriangularTile<Bool, Bool>.width = 40
        TriangularTile<Bool, Bool>.height = sqrt(3) * 40/2
        
        SquareTile<Bool, Bool>.width = 40
        SquareTile<Bool, Bool>.height = 40
        
        RotatedSquareTile<Bool, Bool>.width = 40
        RotatedSquareTile<Bool, Bool>.height = 40
        
        HexagonalTile<Bool, Bool>.width = 40
        HexagonalTile<Bool, Bool>.horizontalLength = 20
        HexagonalTile<Bool, Bool>.height = sqrt(3) * 20
        
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
