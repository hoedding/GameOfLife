//
//  GameScene.swift
//  GameOfLife2
//
//  Created by Timo Höting on 19.10.14.
//  Copyright (c) 2014 Timo Höting. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var nodes = [SKSpriteNode]()
    var dict = Dict()
    var counter = 0
    let genCounter = SKLabelNode(fontNamed:"Courier")

    
    override func didMoveToView(view: SKView) {
        showGrid()
        reloadGrid()
        dict.backToTheFuture()
        let myLabel = SKLabelNode(fontNamed:"Courier")
        myLabel.text = "Game of Life on iOS";
        myLabel.fontSize = 20;
        myLabel.position = CGPoint(x:size.width / 2, y:size.height-50);
        self.addChild(myLabel)
        genCounter.text = "";
        genCounter.fontSize = 20;
        genCounter.position = CGPoint(x:size.width / 2, y:size.height-100);
        self.addChild(genCounter)
        
        dict.setEntryAlive(pos(x: 5, y: 10))
        dict.setEntryAlive(pos(x: 6, y: 10))
        dict.setEntryAlive(pos(x: 7, y: 10))
        
        //GLider
        dict.setEntryAlive(pos(x: 5, y: 15))
        dict.setEntryAlive(pos(x: 6, y: 16))
        dict.setEntryAlive(pos(x: 4, y: 17))
        dict.setEntryAlive(pos(x: 5, y: 17))
        dict.setEntryAlive(pos(x: 6, y: 17))
        
        //Pulsator
        dict.setEntryAlive(pos(x: 32, y: 11))
        dict.setEntryAlive(pos(x: 33, y: 11))
        dict.setEntryAlive(pos(x: 34, y: 11))
        dict.setEntryAlive(pos(x: 35, y: 11))
        dict.setEntryAlive(pos(x: 36, y: 11))
        dict.setEntryAlive(pos(x: 37, y: 11))
        
        dict.setEntryAlive(pos(x: 31, y: 12))
        dict.setEntryAlive(pos(x: 38, y: 12))
        
        dict.setEntryAlive(pos(x: 30, y: 13))
        dict.setEntryAlive(pos(x: 39, y: 13))
        
        dict.setEntryAlive(pos(x: 31, y: 14))
        dict.setEntryAlive(pos(x: 38, y: 14))
        
        dict.setEntryAlive(pos(x: 32, y: 15))
        dict.setEntryAlive(pos(x: 33, y: 15))
        dict.setEntryAlive(pos(x: 34, y: 15))
        dict.setEntryAlive(pos(x: 35, y: 15))
        dict.setEntryAlive(pos(x: 36, y: 15))
        dict.setEntryAlive(pos(x: 37, y: 15))

        
        var slider = UISlider(frame: CGRect(x: size.width / 2, y: size.height-100, width: 100, height: 50))
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.continuous = true
        slider.backgroundColor = UIColor.clearColor()
        slider.hidden = false
        view.addSubview(slider)

        var b = SKAction.runBlock(reloadGrid)
        var c = SKAction.waitForDuration(0)
        var d = SKAction.runBlock(dict.backToTheFuture)
        var e = SKAction.runBlock(setCounter)
        var sequence = SKAction.sequence([ b ,d, e])
        self.runAction(SKAction.repeatActionForever(sequence))
        
    }
    
    func setCounter(){
        counter++
    }
    
    func showGrid(){
        let startPosition = CGPoint(x: 340, y: 550)
        for y in 0...dict.sizeY-1 {
            for x in 0...dict.sizeX-1 {
                let background = SKSpriteNode(color: SKColor.grayColor(), size: CGSize(width: 5, height: 5))
                var t1 = CGFloat( x * 7 )
                var t2 = CGFloat( y * 7 )
                background.position = CGPoint(x: startPosition.x + t1, y: startPosition.y - t2)
                addChild(background)
                
                let point = SKSpriteNode(color: SKColor.yellowColor(), size: CGSize(width: 5, height: 5))
                point.position = CGPoint(x: startPosition.x + t1, y: startPosition.y - t2)
                point.name = "point"
                point.hidden = true
                nodes.append(point)
                addChild(point)
            }
        }
    }
    
    func reloadGrid(){
        for y in 0...dict.sizeY-1 {
            for x in 0...dict.sizeX-1 {
                if(dict.isAlive(dict.genPos(x, y: y))){
                        nodes[x+y*dict.sizeY].hidden = false
                } else {
                        nodes[x+y*dict.sizeY].hidden = true
                }
            }
    }
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
           //nop
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        genCounter.text = String(counter)
    }
}
