//
//  BoardView.swift
//  harukiSpriteKit
//
//  Created by yuki takei on 2017/02/10.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation


class BoardScene: SKScene, SKPhysicsContactDelegate{
    
    
    
    var timernum: Int = 0
    
    var nodenum: Int!
    
    var pointnum: Float = 0.0

    var x:CGFloat = 11.2
    var y:CGFloat = 11.2
    
    var pointlabel: SKLabelNode!
 
    
    var nodeSize:CGFloat = 0.0
    
    var timer:Timer?
    
    var node:SKSpriteNode!
    
    var downNodes:[SKSpriteNode] = []
    
    var stopperNode:SKSpriteNode!
    
    var nodeCounter:UInt32 = 1
    
    var contactNode = (bitMask:0, nameArray:[]) as (bitMask:UInt32,nameArray:Array)
    
    var contactArray:[Any] = []
    
    var SoundAction: SKAction!


    //シーンが生成されたタイミングで呼ばれる
    override func didMove(to view: SKView) {
        
       
        self.SoundAction = SKAction.playSoundFileNamed("decision17.mp3", waitForCompletion: true)
        
        var SoundAction: SKAction = SKAction.playSoundFileNamed("BGM179-161031-bokobokobomber-wav", waitForCompletion: true)
        
        let soundRepeat = SKAction.repeatForever(SoundAction)
        
        // 再生アクション.
        self.run(soundRepeat,withKey:"die-sound");
    
        
        
        self.physicsWorld.contactDelegate = self
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        
        nodeSize = view.frame.width / x
        
        
        let stopperNode = SKSpriteNode()
        stopperNode.color = UIColor.green
        stopperNode.position = CGPoint(x: view.center.x, y: 30)
        stopperNode.size = CGSize(width: view.frame.width + 200, height: 30.0)
        stopperNode.physicsBody = SKPhysicsBody(rectangleOf: stopperNode.size)
        stopperNode.physicsBody?.restitution = 0.0
        stopperNode.physicsBody?.isDynamic = false
        stopperNode.physicsBody?.contactTestBitMask = 0x1 << 10
        
        
        addChild(stopperNode)
        
        self.stopperNode = stopperNode
        
        let stopperNode2 = SKSpriteNode()
        stopperNode2.color = UIColor.green
        stopperNode2.position = CGPoint(x: 2, y: view.center.y)
        stopperNode2.size = CGSize(width: 30.0, height: view.frame.width + 200)
        stopperNode2.physicsBody = SKPhysicsBody(rectangleOf: stopperNode2.size)
        stopperNode2.physicsBody?.restitution = 0.0
        stopperNode2.physicsBody?.isDynamic = false
        stopperNode2.physicsBody?.contactTestBitMask = 0x1 << 10
        
        
        addChild(stopperNode2)
        
        let stopperNode3 = SKSpriteNode()
        stopperNode3.color = UIColor.green
        stopperNode3.position = CGPoint(x:  (self.view?.frame.size.width)!-2, y: view.center.y)
        stopperNode3.size = CGSize(width: 30.0, height: view.frame.width + 200)
        stopperNode3.physicsBody = SKPhysicsBody(rectangleOf: stopperNode3.size)
        stopperNode3.physicsBody?.restitution = 0.0
        stopperNode3.physicsBody?.isDynamic = false
        stopperNode3.physicsBody?.contactTestBitMask = 0x1 << 10
        
        
        addChild(stopperNode3)
        
        pointlabel = SKLabelNode()
        pointlabel.position = CGPoint(x: view.center.x, y: view.center.y)
        pointlabel.color = UIColor.blue
        pointlabel.fontSize = 166
        
        addChild(pointlabel)
        
        
        
        //ここに書く
        for i in 0...9 {
            var Floatnum: Float!
            Floatnum = Float(arc4random_uniform(UInt32(self.view!.frame.width-40+20)))
            fallDown(fallDownPosX: Floatnum)
        }
        
        
        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.fallDown), userInfo: nil, repeats: true)

        
        
    }
    
    
    
    //更新
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    
//        print(downNodes.count)
        
    }
    
    //衝突開始
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node == stopperNode{
            print("contact")
        }
        
        if contact.bodyA.contactTestBitMask == contact.bodyB.contactTestBitMask {
            
            contactNode.bitMask = contact.bodyA.contactTestBitMask
            contactNode.nameArray.append(contact.bodyA.node?.name)
            contactArray.append(contactNode)
            
            contact.bodyA.node?.name = String(Int((contact.bodyA.node?.name)!)! - 10)
            
            print("aaaaaaa")
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            
            // 再生データの作成.
            
            // 再生アクション.
            self.run(SoundAction);
            
            pointnum = pointnum + 0.5
            print("pointuum = \(pointnum)")
            pointlabel.text = String(pointnum)
            
            
//            ido()
        }
        
        print("A:\(contact.bodyA.contactTestBitMask),B:\(contact.bodyB.contactTestBitMask)")
        
    }
    
    func fallDown(fallDownPosX: Float){
               downNodes.removeAll()
        
        
        for i in 0..<5{ //0...4
           
            nodenum = Int(arc4random_uniform(5))
            
            
            

            
            var nodeimage: String!
            
            if nodenum == 4 {
               nodeimage = (imagenamed: "file2-no1.png")
            }else if nodenum == 3 {
              nodeimage = (imagenamed: "file2-no2.png")
            }else if nodenum == 2{
              nodeimage = (imagenamed: "file2-no3.png")
            }else if nodenum == 1{
                nodeimage = (imagenamed: "file2-no4.png")
            }else{
                nodeimage = (imagenamed: "file2-no5.png")
            }

            
            var nodeXpos:CGFloat!
            if (timer != nil) {
                nodeXpos = self.view!.center.x
            }else{
                nodeXpos = CGFloat(fallDownPosX)
            }
            
            var node:SKSpriteNode = SKSpriteNode(imageNamed: nodeimage)
            
            node.color = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            node.position = CGPoint(x: nodeXpos, y: (self.view?.frame.height)! + nodeSize * CGFloat(i))
            node.size = CGSize(width: nodeSize, height: nodeSize)
            node.physicsBody = SKPhysicsBody(circleOfRadius: nodeSize/2)
            node.physicsBody?.contactTestBitMask = 0x1 << UInt32(nodenum)
            node.physicsBody?.allowsRotation = true
            node.name = "\(60)"
            node.physicsBody?.restitution = 0.1
            node.physicsBody?.friction = 0.3
            addChild(node)

            
//            self.node = node
            self.downNodes.append(node)
            nodeCounter += 1
            
            
            
        }
        

        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: AnyObject = touches.first {

            let location = touch.location(in: self)
            var blockLocation = floor(location.x * x / (view?.frame.width)!)
            
            
            
            print(blockLocation)
            
            if downNodes.count == 5 {
                for i in 0...4 {
                    let action = SKAction.move(to: CGPoint(x: location.x, y: downNodes[i].position.y), duration: 0.1)
                    downNodes[i].run(action)
                }
            }
            
            
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch: AnyObject = touches.first {
            
            let location = touch.location(in: self)
            var blockLocation = floor(location.x * x / (view?.frame.width)!)
            

            print(blockLocation)
            
            if downNodes.count == 5 {
                for i in 0...4 {
                    let action = SKAction.move(to: CGPoint(x: blockLocation * nodeSize, y: downNodes[i].position.y), duration: 0.1)
                    downNodes[i].run(action)
                }
            }
            
            
            
        }
        
        
    }
    
    func ido(){
        if pointnum >= 5.0 {
            var a = SKViewController()
            a.finishgame()
        }
    }
    
    
    func finish(){
//        SKAction.stop()

//        self.stop(mySoundAction)
//        mySoundAction = SKAction.stop()
        
        self.removeAllActions()
        
    
        


        
    }
    
        
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let touch: AnyObject = touches.first {
//            // シーン上のタッチされた位置を取得する
//            let location = touch.locationInNode(self)
//            // タッチされた位置にノードを移動させるアクションを作成する
//            let action = SKAction.moveTo(CGPoint(x: location.x, y: 100), duration: 0.2)
//            // どんぶりのスプライトでアクションを実行する
//            self.bowl?.runAction(action)
//        }
//    }
//    
//    // 指を動かしたときに呼ばれるメソッド
//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let touch: AnyObject = touches.first {
//            // シーン上のタッチされた位置を取得する
//            let location = touch.locationInNode(self)
//            // タッチされた位置にノードを移動させるアクションを作成する
//            let action = SKAction.moveTo(CGPoint(x: location.x, y: 100), duration: 0.2)
//            // どんぶりのスプライトでアクションを実行する
//            self.bowl?.runAction(action)
//        }
//    }
    

}
