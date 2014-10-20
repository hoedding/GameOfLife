//
//  Grid.swift
//  GameOfLife
//
//  Created by Timo Höting on 19.10.14.
//  Copyright (c) 2014 Timo Höting. All rights reserved.
//


//TODO
//Array loswerden -> Nachbar Überprüfung ändern
import Foundation
import UIKit

class Grid {
    let sizeX = 50
    let sizeY = 50
    var grid = Array<Array<Int>>()
    var toLife = Array<CGPoint>()
    var toDeath = Array<CGPoint>()
    
    
    func initGrid(){
        for x in 0...sizeX{
            grid.append(Array(count: sizeY, repeatedValue:Int()))
        }
        for y in 0...sizeX - 1 {
            for x in 0...sizeY - 1 {
                grid[x][y] = 0
            }
        }
    }
    
    func countNeighbours(x: Int, y: Int)  {
        var i = 0
        if(hasNeighbourTop(x, y: y)){
            i++
        }
        if(hasNeighbourDown(x, y: y)){
            i++
        }
        if(hasNeighbourLeft(x, y: y)){
            i++
        }
        if(hasNeighbourRight(x, y: y)){
            i++
        }
        if(hasNeighbourTopRight(x, y: y)){
            i++
        }
        if(hasNeighbourTopLeft(x, y: y)){
            i++
        }
        if(hasNeighbourDownRight(x, y: y)){
            i++
        }
        if(hasNeighbourDownLeft(x, y: y)){
            i++
        }
        switch(i){
        case 0: toDeath.append(CGPoint(x: x, y: y))
                break
        case 1: toDeath.append(CGPoint(x: x, y: y))
                break
        case 2: //nothing
                break
        case 3: toLife.append(CGPoint(x: x, y: y))
                break
        case 4: toDeath.append(CGPoint(x: x, y: y))
                break
        default:toDeath.append(CGPoint(x: x, y: y))
                break
        }
    }
    
    func playGod(){
        for i in 0...toLife.count-1{
            grid[Int(toLife[i].x)][Int(toLife[i].y)] = 1
        }
        for i in 0...toDeath.count-1{
            grid[Int(toDeath[i].x)][Int(toDeath[i].y)] = 0
        }
        toLife.removeAll(keepCapacity: false)
         toDeath.removeAll(keepCapacity: false)
    }
    
    func isPointSet(x: Int, y: Int) -> Bool {
        if(grid[x][y] == 1){
            return true
        }
        return false
    }
    
    func hasNeighbourTop(x: Int, y: Int) -> Bool{
        if (y == 0){
            return false
        }
        if (isPointSet(x, y: y-1)){
            return true
        }
        return false
    }
    func hasNeighbourDown(x: Int, y: Int) -> Bool{
        if (y == sizeY-1){
            return false
        }
        if (isPointSet(x, y: y+1)){
            return true
        }
        return false
    }
    func hasNeighbourLeft(x: Int, y: Int) -> Bool{
        if (x == 0){
            return false
        }
        if (isPointSet(x-1, y: y)){
            return true
        }
        return false
    }
    func hasNeighbourRight(x: Int, y: Int) -> Bool{
        if (x == sizeX-1){
            return false
        }
        if (isPointSet(x+1, y: y)){
            return true
        }
        return false
    }
    func hasNeighbourTopRight(x: Int, y: Int) -> Bool{
        if (y == 0 || x == sizeX-1){
            return false
        }
        if (isPointSet(x+1, y: y-1)){
            return true
        }
        return false
    }
    func hasNeighbourTopLeft(x: Int, y: Int) -> Bool{
        if (y == 0 || x == 0){
            return false
        }
        if (isPointSet(x-1, y: y-1)){
            return true
        }
        return false
    }
    func hasNeighbourDownRight(x: Int, y: Int) -> Bool{
        if (y == sizeY-1 || x == sizeX-1){
            return false
        }
        if (isPointSet(x+1, y: y+1)){
            return true
        }
        return false
    }
    func hasNeighbourDownLeft(x: Int, y: Int) -> Bool{
        if (y == sizeY-1 || x == 0){
            return false
        }
        if (isPointSet(x-1, y: y+1)){
            return true
        }
        return false
    }
    func nextStep(){
        for y in 0...sizeX - 1 {
            for x in 0...sizeY - 1 {
               countNeighbours(x, y: y)
            }
        }
        playGod()
    }
    
}