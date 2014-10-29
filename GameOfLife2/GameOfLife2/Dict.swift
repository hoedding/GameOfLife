//
//  Dict.swift
//  GameOfLife2
//
//  Created by Timo Höting on 27.10.14.
//  Copyright (c) 2014 Timo Höting. All rights reserved.
//

import Foundation

enum stat {
    case isAlive
    case isDeath
}

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

class Dict {

    var currentDict = [pos : stat]()
    var sizeX = 50
    var sizeY = 50
    
    
    func genPos(x: Int, y: Int) -> pos {
        var position = pos(x: x, y: y)
        return position
    }
    
    func setEntryAlive(position : pos){
        currentDict[position] = stat.isAlive
    }
    
    func isBorder(position: pos) -> Bool{
        if(position.x == -1 || position.x == self.sizeX + 1 || position.y == -1 || position.y == self.sizeY+1){
            return true
        }
        return false
    }
    
    func isAlive(position: pos) -> Bool{
        if(currentDict[position] == stat.isAlive){
            return true
        }
        return false
    }
    
    func setActive(position: pos){
        currentDict[position] = stat.isAlive
    }
    
    func dictContains(position: pos) -> Bool{
        if(isBorder(position)){
            return false
        }
        if (( currentDict.indexForKey(position) ) != nil){
            return true
        }
        return false
    }
    
    func checkNeighbourLivingPoint(position: pos) -> Bool{
        var count = 0
        if(dictContains(pos(x: position.x + 1, y: position.y ))) {count++ }
        if(dictContains(pos(x: position.x - 1, y: position.y ))) {count++ }
        if(dictContains(pos(x: position.x, y: position.y - 1 ))) {count++ }
        if(dictContains(pos(x: position.x, y: position.y + 1 ))) {count++ }
        if(dictContains(pos(x: position.x + 1, y: position.y + 1 ))) {count++ }
        if(dictContains(pos(x: position.x + 1, y: position.y - 1 ))) {count++ }
        if(dictContains(pos(x: position.x - 1, y: position.y + 1 ))) {count++ }
        if(dictContains(pos(x: position.x - 1, y: position.y - 1 ))) {count++ }
        switch(count){
        case 0: return false
        case 1: return false
        case 2: if(dictContains(position)) {return true }; return false
        case 3: return true
        case 4: return false
        default: return false
        }
    }
    
    func checkNeighbourDeathPoint(position: pos) -> [pos]{
        var tempPoint = [pos]()
        if ( checkNeighbourLivingPoint(pos(x: position.x + 1, y: position.y )))  {tempPoint.append(pos(x: position.x + 1, y: position.y))}
        if ( checkNeighbourLivingPoint(pos(x: position.x - 1, y: position.y )))  {tempPoint.append(pos(x: position.x - 1, y: position.y ))}
        if ( checkNeighbourLivingPoint(pos(x: position.x, y: position.y - 1 )))  {tempPoint.append(pos(x: position.x, y: position.y - 1 ))}
        if ( checkNeighbourLivingPoint(pos(x: position.x, y: position.y + 1 )))  {tempPoint.append(pos(x: position.x, y: position.y + 1 ))}
        if ( checkNeighbourLivingPoint(pos(x: position.x + 1, y: position.y + 1 )))  {tempPoint.append(pos(x: position.x + 1, y: position.y + 1 ))}
        if ( checkNeighbourLivingPoint(pos(x: position.x + 1, y: position.y - 1 )))  {tempPoint.append(pos(x: position.x + 1, y: position.y - 1 ))}
        if ( checkNeighbourLivingPoint(pos(x: position.x - 1, y: position.y + 1 )))  {tempPoint.append(pos(x: position.x - 1, y: position.y + 1 ))}
        if ( checkNeighbourLivingPoint(pos(x: position.x - 1, y: position.y - 1 )))  {tempPoint.append(pos(x: position.x - 1, y: position.y - 1 ))}
        return tempPoint
    }
    
    func backToTheFuture(){
        var nextGen = [pos : stat]()
        for (position, status) in currentDict{
            if(checkNeighbourLivingPoint(position)){
                nextGen[position] = stat.isAlive
            }
            var tempPoint = checkNeighbourDeathPoint(position)
            if (tempPoint.count > 0){
                for i in 0...tempPoint.count-1{
                    nextGen[tempPoint[i]] = stat.isAlive
                }
            }
        }
        currentDict = nextGen
    }
}
