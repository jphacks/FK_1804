//
//  SunScene.swift
//  Interactibook
//
//  Created by 仲地早司 on 2018/10/27.
//  Copyright © 2018年 仲地早司. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class SunScene: SKScene, SKPhysicsContactDelegate{
    var sunNode:SKSpriteNode!
    var hotNode:SKSpriteNode!
    var flowerNode:SKSpriteNode!
    var nextNode:SKSpriteNode!
    var player:AVAudioPlayer!
    let musicAction = SKAction.playSoundFileNamed("shine1.mp3", waitForCompletion: true)
    
    override func didMove(to view: SKView) {
        //背景画像のノードを作成する。
        let backNode = SKSpriteNode(imageNamed: "haikei2.jpg")
        //背景画像のサイズをシーンのサイズと同じにする。
        backNode.size = self.frame.size
        //背景画像の位置をシーンの中央にする。
        backNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        //太陽ノードを作成
        sunNode = SKSpriteNode(imageNamed: "taiyou")
        sunNode.setScale(0.8)
        //太陽の位置を調整
        sunNode.position = CGPoint(x: self.frame.width - sunNode.frame.width/2, y: self.frame.height*3/4)
        
        //暑い人のノードを作成
        hotNode = SKSpriteNode(imageNamed: "hot")
        hotNode.position = CGPoint(x:self.frame.midX, y: self.frame.midY/4 + 50)
        hotNode.xScale = abs(hotNode.xScale) * -1.0 //反転させるため
        
        //お花のノードを作成
        flowerNode = SKSpriteNode(imageNamed: "flower")
        flowerNode.name = "flowerNode"
        flowerNode.setScale(0.2)
        
        flowerNode.position = CGPoint(x: self.frame.midX/4, y: 80)
        
        //ネクストボタンのノードを作成
        nextNode = SKSpriteNode(imageNamed: "next")
        nextNode.name = "nextNode"
        nextNode.setScale(0.5)
        nextNode.position = CGPoint(x: self.frame.midX + self.frame.midX/2, y:nextNode.frame.height)
        
        //カテゴリマスクを設定する
        self.physicsBody?.categoryBitMask = 0b0001
        //デリゲート先を自分に設定する。
        self.physicsWorld.contactDelegate = self
        //画面端に物理ボディを設定する。
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        //各ノードをSKViewに追加
        self.addChild(backNode)
        self.addChild(sunNode)
        self.addChild(hotNode)
        self.addChild(flowerNode)
        self.addChild(nextNode)
        
        //以下アクション
        let sunAction1 = SKAction.move(to: CGPoint(x: 0, y: self.frame.height*3/4), duration: 4)
        let sunAction2 = SKAction.move(to: CGPoint(x: self.frame.width, y: self.frame.height*3/4), duration: 4)
        let sunAction = SKAction.repeatForever(SKAction.sequence([sunAction1, sunAction2]))
        
        sunNode.run(sunAction)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in:self)
        if let node = atPoint(location) as? SKSpriteNode {

            let startButton = self.childNode(withName: "nextNode") as? SKSpriteNode
            if(node == startButton) {
                nextScene()
            }

            let flowerButton = self.childNode(withName: "flowerNode") as? SKSpriteNode
            if(node == flowerButton) {
                //let skView = self.view as! SKView
                let particle = SKEmitterNode(fileNamed: "flowerparticle.sks")
                
                particle!.position = CGPoint(x: self.frame.midX/4, y: 80)
                let action1 = SKAction.wait(forDuration: 0.7)
                let action2 = SKAction.removeFromParent()
                let actionAll = SKAction.sequence([action1, action2])
                
                //パーティクルをシーンに追加する。
                self.addChild(particle!)
                
                //アクションを実行する。
                particle!.run(actionAll)
                
                //音楽
                
                self.run(musicAction)
                /*
                 let url = Bundle.main.bundleURL.appendingPathComponent("shine1.mp3")
                 do {
                 try player = AVAudioPlayer(contentsOf:url)
                 
                 //音楽を再生する。
                 player.play()
                 } catch {
                 print(error)
                 }
                 */
                
            }
            
        }
    }
    func nextScene() {
        let skView = self.view as! SKView
        let transition = SKTransition.flipVertical(withDuration: 1)
        //スタートボタンを押した場合はプレイ画面に切り替える。
        let result = EndScene(size: skView.frame.size)
        self.view!.presentScene(result, transition: transition)
    }
    
}
