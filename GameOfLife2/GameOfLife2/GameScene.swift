//
//  GameScene.swift
//  GameOfLife2
//
//  Created by Timo Höting on 19.10.14.
//  Copyright (c) 2014 Timo Höting. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var grid = Grid()
    var nodes = [SKSpriteNode]()
    
    override func didMoveToView(view: SKView) {
        
        grid.initGrid()
        showGrid()
        
        let myLabel = SKLabelNode(fontNamed:"Courier")
        myLabel.text = "Game of Life on iOS";
        myLabel.fontSize = 20;
        myLabel.position = CGPoint(x:size.width / 2, y:size.height-50);
        self.addChild(myLabel)
        
        var a = SKAction.runBlock(removeGrid)
        var b = SKAction.runBlock(reloadGrid)
        var c = SKAction.waitForDuration(0.1)
        var d = SKAction.runBlock(grid.nextStep)
        var sequence = SKAction.sequence([a,b,d,c])
        self.runAction(SKAction.repeatActionForever(sequence))
        
        //Blinker
        grid.grid[5][5] = 1
        grid.grid[5][6] = 1
        grid.grid[5][7] = 1
        
        //Clock
        grid.grid[18][10] = 1
        grid.grid[18][11] = 1
        grid.grid[20][11] = 1
        grid.grid[17][12] = 1
        grid.grid[19][12] = 1
        grid.grid[19][13] = 1
        
        //Pulsator
        grid.grid[32][11] = 1
        grid.grid[33][11] = 1
        grid.grid[34][11] = 1
        grid.grid[35][11] = 1
        grid.grid[36][11] = 1
        grid.grid[37][11] = 1
        
        grid.grid[31][12] = 1
        grid.grid[38][12] = 1
        
        grid.grid[30][13] = 1
        grid.grid[39][13] = 1
        
        grid.grid[31][14] = 1
        grid.grid[38][14] = 1
        
        grid.grid[32][15] = 1
        grid.grid[33][15] = 1
        grid.grid[34][15] = 1
        grid.grid[35][15] = 1
        grid.grid[36][15] = 1
        grid.grid[37][15] = 1
        
        //Glider
        grid.grid[5][15] = 1
        grid.grid[6][16] = 1
        grid.grid[4][17] = 1
        grid.grid[5][17] = 1
        grid.grid[6][17] = 1
       
    }
    
    
    func showGrid(){
        let startPosition = CGPoint(x: 340, y: 550)
        for y in 0...grid.sizeY-1 {
            for x in 0...grid.sizeX-1 {
                
                let background = SKSpriteNode(color: SKColor.grayColor(), size: CGSize(width: 5, height: 5))
                background.position = CGPoint(x: Int(startPosition.x) + x * 7.0, y: Int(startPosition.y)  - y * 7.0)
                background.name = "background"
                addChild(background)
                
                    let point = SKSpriteNode(color: SKColor.yellowColor(), size: CGSize(width: 5, height: 5))
                    point.position = CGPoint(x: Int(startPosition.x) + x * 7.0, y: Int(startPosition.y)  - y * 7.0)
                    point.name = "point"
                    point.hidden = true
                    nodes.append(point)
                    addChild(point)
                
               
                
            }
        }
       
    }
    
    func removeGrid(){

        for y in 0...grid.sizeY-1 {
            for x in 0...grid.sizeX-1 {
                if(!grid.isPointSet(x, y: y)){
                    if ( y == 0) {
                        nodes[x].hidden = true
                    } else if (y == 1)
                    {
                        nodes[50 + x].hidden = true
                    } else {
                        nodes[(y*50) + x].hidden = true
                    }
                }
            }
    }
    }
    
    func reloadGrid(){
    
        for y in 0...grid.sizeY-1 {
            for x in 0...grid.sizeX-1 {
                if(grid.isPointSet(x, y: y)){
                    if ( y == 0) {
                        nodes[x].hidden = false
                    } else if (y == 1)
                    {
                        nodes[50 + x].hidden = false
                    } else {
                        nodes[(y*50) + x].hidden = false
                    }

                }
            }
            
    }
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location: CGPoint! = touch.locationInNode(self)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
