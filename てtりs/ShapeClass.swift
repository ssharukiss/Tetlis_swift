//
//  ShapeClass.swift
//  てtりs
//
//  Created by yuki takei on 2016/11/05.
//  Copyright © 2016年 上住悠生. All rights reserved.
//

import Foundation

protocol Block {
    
    var blockCell0:[[Int]] {get}
    var blockCell90:[[Int]] {get}
    var blockCell180:[[Int]] {get}
    var blockCell270:[[Int]] {get}
}

class ShapeClass:NSObject{
    
    var x:Int = 0
    let BLOCKS_PATTRN_NUM:UInt32 = 6
    
    func blockSelector() -> [[Int]]{
        
        
        var selectBlocks:Block!
        
        var randNum:Int = Int(arc4random_uniform(BLOCKS_PATTRN_NUM))
        
        switch randNum {
        case 0:
            selectBlocks = blockT()
            break
        case 1:
            selectBlocks = blockL()
            break
        case 2:
            selectBlocks = blockReL()
            break
        case 3:
            selectBlocks = lineblock()
            break
        case 4:
            selectBlocks = gizagizablock()
            break
        case 5:
            selectBlocks = cubeblock()
            break
        default:
            break
        }
        
        return roteteSelector(getBlocks: selectBlocks)
        
    }
    
    func roteteSelector(getBlocks:Block) -> [[Int]]{
        var rotateNum:Int = Int(arc4random_uniform(4))
        var getArray = [[Int]]()
        
        switch rotateNum {
        case 0:
            getArray =  getBlocks.blockCell0
            break
        case 1:
            getArray = getBlocks.blockCell90
            break
        case 2:
            getArray = getBlocks.blockCell180
            break
        case 3:
            getArray = getBlocks.blockCell270
            break
        default:
            break
        }
        
        return getArray
        
    }
    
}


struct blockT:Block{
    var blockCell0 = [[2,0],[1,2],[2,0]]
    var blockCell90 = [[0,2,0],[1,1,2]]
    var blockCell180 = [[0,2],[1,2],[0,2]]
    var blockCell270 = [[1,1,2],[0,2,0]]
}

struct blockL:Block{
    var blockCell0 = [[1,2],[2,0],[2,0]]
    var blockCell90 = [[2,0,0],[1,1,2]]
    var blockCell180 = [[0,2],[0,2],[1,2]]
    var blockCell270 = [[1,1,2],[0,0,2]]
}

struct  blockReL:Block {
    var blockCell0 = [[2,0],[2,0],[1,2]]
    var blockCell90 = [[0,0,2],[1,1,2]]
    var blockCell180 = [[1,2],[0,2],[0,2]]
    var blockCell270 = [[1,1,2],[2,0,0]]
}

struct  lineblock:Block {
    var blockCell0 = [[2],[2],[2],[2]]
    var blockCell90 = [[1,1,1,2]]
    var blockCell180 = [[2],[2],[2],[2]]
    var blockCell270 = [[1,1,1,2]]
    
}

struct gizagizablock:Block {
    var blockCell0 = [[2,0],[1,2],[0,2]]
    var blockCell90 = [[0,1,2],[1,2,0]]
    var blockCell180 = [[2,0],[1,2],[0,2]]
    var blockCell270 = [[0,1,2],[1,2,0]]
}

struct cubeblock:Block {
    var blockCell0 = [[1,2],[1,2]]
    var blockCell90 = [[1,2],[1,2]]
    var blockCell180 = [[1,2],[1,2]]
    var blockCell270 = [[1,2],[1,2]]
}



