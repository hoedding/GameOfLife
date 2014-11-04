//
//  Dict.swift
//  GameOfLife2
//
//  Created by Timo Höting on 27.10.14.
//  Copyright (c) 2014 Timo Höting. All rights reserved.
//

import Foundation
import UIKit

struct pos :  Hashable {
    var description:String {
        return "posX\(x)Y\(y)"
    }
    var hashValue:Int {
        return x + (y * 100)
    }
    var x : Int
    var y : Int
}

func == (lhs: pos, rhs: pos) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

let NEIGHBOURS : [CGPoint] = [CGPoint(x: -1, y: -1), CGPoint(x: -1, y: 0), CGPoint(x: -1, y: 1), CGPoint(x: 0, y: -1), CGPoint(x: 0, y: 1), CGPoint(x: 1, y: -1), CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1)]

class Dict {
    var currentDict = [pos : Int]()
    var sizeX = 50
    var sizeY = 50
    
    
    func genPos(x: Int, y: Int) -> pos {
        var position = pos(x: x, y: y)
        return position
    }
    
    func setEntryAlive(position : pos){
        currentDict[position] = 1
    }
    
    func isAlive(position: pos) -> Bool{
        if(currentDict[position] == 1){
            return true
        }
        return false
    }
    
    func dictContains(position: pos) -> Bool{
        if (( currentDict.indexForKey(position) ) != nil){
            return true
        }
        return false
    }
    
    func checkNeighbourLivingPoint(position: pos) -> Bool{
        var count = 0
        for i in 0...NEIGHBOURS.count - 1{
            if(dictContains(pos(x: position.x + Int(NEIGHBOURS[i].x), y: position.y + Int(NEIGHBOURS[i].y))))
                {count++ }
        }
        switch(count){
        case 2: if(dictContains(position)) {return true }; return false
        case 3: return true
        default: return false
        }
    }
    
    func checkNeighbourDeathPoint(position: pos) -> [pos]{
        var tempPoint = [pos]()
        for i in 0...NEIGHBOURS.count - 1{
            if(checkNeighbourLivingPoint(pos(x: position.x + Int(NEIGHBOURS[i].x), y: position.y + Int(NEIGHBOURS[i].y))))
            {tempPoint.append(pos(x: position.x + Int(NEIGHBOURS[i].x), y: position.y + Int(NEIGHBOURS[i].y)))}
        }
        return tempPoint
    }
    
    func backToTheFuture(){
        var nextGen = [pos : Int]()
        for (position, status) in currentDict{
            if(checkNeighbourLivingPoint(position)){
                nextGen[position] = 1
            }
            var tempPoint = checkNeighbourDeathPoint(position)
            if (tempPoint.count > 0){
                for i in 0...tempPoint.count-1{
                    nextGen[tempPoint[i]] = 1
                }
            }
        }
        currentDict = nextGen
    }
}
