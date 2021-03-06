//
//  WindScene.swift
//  Interactibook
//
//  Created by 仲地早司 on 2018/10/27.
//  Copyright © 2018年 仲地早司. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class WindScene:SKScene, SKPhysicsContactDelegate{
    var cloudNode:SKSpriteNode!
    var coldNode:SKSpriteNode!
    var nextNode:SKSpriteNode!
    var grass1Node:SKSpriteNode!
    var grass2Node:SKSpriteNode!
    var treeNode:SKSpriteNode!
    var apple1Node:SKSpriteNode!
    var apple2Node:SKSpriteNode!
    var apple3Node:SKSpriteNode!
    var vortexNode:SKFieldNode!
    var konoha:SKSpriteNode!
    var player:AVAudioPlayer!  //for music
    
    override func didMove(to view: SKView){
        //背景画像のノードを作成する。
        let backNode = SKSpriteNode(imageNamed: "haikei2.jpg")
        //背景画像のサイズをシーンのサイズと同じにする。
        backNode.size = self.frame.size
        //背景画像の位置をシーンの中央にする。
        backNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        //雲のノードを作成する。
        cloudNode = SKSpriteNode(imageNamed: "cloud")
        cloudNode.setScale(1.4)
        //雲の位置を調整
        cloudNode.position = CGPoint(x: cloudNode.frame.width/2, y: self.frame.height*3/4)
        
        //風のノードを作成
        konoha = SKSpriteNode(imageNamed: "konoha")
        konoha.setScale(0.09)
        konoha.position = CGPoint(x: 30, y: self.frame.midY/4 + 50)
        
        //寒い人のノードを作成
        coldNode = SKSpriteNode(imageNamed: "cold")
        coldNode.position = CGPoint(x:self.frame.midX + 100, y: self.frame.midY/4 + 50)
        
        //ネクストボタンのノードを作成
        nextNode = SKSpriteNode(imageNamed: "next")
        nextNode.name = "nextNode"
        nextNode.setScale(0.5)
        nextNode.position = CGPoint(x: self.frame.midX + self.frame.midX/2, y:nextNode.frame.height)
        
        //草のノードを作成
        grass1Node = SKSpriteNode(imageNamed: "kusa1")
        grass1Node.setScale(0.3)
        grass1Node.position = CGPoint(x: self.frame.midX/2, y: 50)
        grass1Node.physicsBody = SKPhysicsBody(texture: grass1Node.texture!, size: grass1Node.size)
        
        grass2Node = SKSpriteNode(imageNamed: "kusa2")
        grass2Node.setScale(0.5)
        grass2Node.position = CGPoint(x: self.frame.midX, y: 50)
        grass2Node.physicsBody = SKPhysicsBody(texture: grass2Node.texture!, size: grass2Node.size)
        
        //木のノードを作成
        treeNode = SKSpriteNode(imageNamed: "tree")
        treeNode.setScale(0.4)
        treeNode.position = CGPoint(x: self.frame.midX/2 - 50, y: self.frame.midY/2 + 60)
        
        //りんごのノードを作成
        apple1Node = SKSpriteNode(imageNamed: "apple")
        apple1Node.setScale(0.08)
        apple1Node.position = CGPoint(x: self.frame.midX/2 - 70, y: self.frame.midY/2 + 90)
        apple2Node = SKSpriteNode(imageNamed: "apple")
        apple2Node.setScale(0.08)
        apple2Node.position = CGPoint(x: self.frame.midX/2 - 20, y: self.frame.midY/2 + 90)
        apple3Node = SKSpriteNode(imageNamed: "apple")
        apple3Node.setScale(0.08)
        apple3Node.position = CGPoint(x: self.frame.midX/2 - 45, y: self.frame.midY/2 + 150)
        
        //カテゴリマスクを設定する
        self.physicsBody?.categoryBitMask = 0b0001
        //デリゲート先を自分に設定する。
        self.physicsWorld.contactDelegate = self
        //画面端に物理ボディを設定する。
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        //各ノードをSKViewに追加
        self.addChild(backNode)
        self.addChild(cloudNode)
        self.addChild(coldNode)
        self.addChild(nextNode)
        self.addChild(grass1Node)
        self.addChild(grass2Node)
        self.addChild(treeNode)
        self.addChild(apple1Node)
        self.addChild(apple2Node)
        self.addChild(apple3Node)
        //self.addChild(konoha)
        
        //以下アクション
        let cloudActionBig = SKAction.scale(to: 1.6, duration: 1)
        let cloudActionSmall = SKAction.scale(to: 1.2, duration: 1)
        let cloudActionBS = SKAction.sequence([cloudActionBig,cloudActionSmall])
        let loopAction = SKAction.repeatForever(cloudActionBS)
        
        cloudNode.run(loopAction)
        
        //以下草に対するアクション？
        //旋風ノードを作成する。
        vortexNode = SKFieldNode.vortexField()
        vortexNode.name = "vortex"
        vortexNode.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        vortexNode.strength = 0.2
        
        //旋風ノードのカテゴリマスクを設定する。
        vortexNode.categoryBitMask = 0b0001
        
        //旋風ノードを無効にする。
        vortexNode.isEnabled = false
        
        //中心ノードを取得する。
        //let centerNode = self.childNode(withName: "center_point") as? SKSpriteNode
        
        //中心ノードの子に旋風ノードを追加する。
        //centerNode?.addChild(vortexNode)
        self.addChild(vortexNode)
        
        //音楽
        let url = Bundle.main.bundleURL.appendingPathComponent("cloud.mp3")
        do {
            try player = AVAudioPlayer(contentsOf:url)
            
            //音楽を再生する。
            player.play()
            
        } catch {
            print(error)
        }
        
    }
    
    //画面タッチ時の呼び出しメソッド
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in:self)
        
        //旋風ノードを取得する。
        let vortexNode = self.childNode(withName: "vortex") as? SKFieldNode
        //旋風ノードの有効無効を切り替える。
        whirlwind()
        if let node = atPoint(location) as? SKSpriteNode {
            //タッチしたのがラベルノードの場合、スタートボタンなのかを確認する。
            let startButton = self.childNode(withName: "nextNode") as? SKSpriteNode
            if(node == startButton) {
                nextIdx += 1
                nextScene()
            }
            
        }
    }
    
    func nextScene() {
        let skView = self.view as! SKView
        let transition = SKTransition.flipVertical(withDuration: 1)
        //スタートボタンを押した場合はプレイ画面に切り替える。
        //let result = WindSunScene(fileNamed: "WindSunScene")
        let result = SunScene(size: skView.frame.size)
        self.view!.presentScene(result, transition: transition)
    }
    
    func whirlwind(){
        vortexNode?.isEnabled = !vortexNode!.isEnabled
        apple1Node.physicsBody = SKPhysicsBody(texture: apple1Node.texture!, size:apple1Node.size)
        apple2Node.physicsBody = SKPhysicsBody(texture: apple2Node.texture!, size:apple2Node.size)
        apple3Node.physicsBody = SKPhysicsBody(texture: apple3Node.texture!, size:apple3Node.size)
        konoha.physicsBody = SKPhysicsBody(texture: konoha.texture!, size:konoha.size)
    }
}
