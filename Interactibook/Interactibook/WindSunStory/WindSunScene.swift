//
//  WindSunScene.swift
//  Interactibook
//
//  Created by 仲地早司 on 2018/10/27.
//  Copyright © 2018年 仲地早司. All rights reserved.
//

import Foundation
import SpriteKit

class WindSunScene:SKScene, SKPhysicsContactDelegate {
    
    var manNode:SKSpriteNode!
    var sunNode:SKSpriteNode!
    var cloudNode:SKSpriteNode!
    var nextNode:SKSpriteNode!
    var startDate:NSDate!
    var vortexNode:SKFieldNode!
    
    //現在シーン設定時の呼び出しメソッド
    override func didMove(to view: SKView) {
        
        //背景画像のノードを作成する。
        let backNode = SKSpriteNode(imageNamed: "haikei2.jpg")
        //背景画像のサイズをシーンのサイズと同じにする。
        backNode.size = self.frame.size
        //背景画像の位置をシーンの中央にする。
        backNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        //太陽のノードを作成する。
        sunNode = SKSpriteNode(imageNamed: "taiyou")
        sunNode.setScale(0.8)
        //太陽の位置をシーンの中央にする。
        sunNode.position = CGPoint(x: self.frame.width - sunNode.frame.width/2, y: self.frame.height/2)
        
        //雲のノードを作成する。
        cloudNode = SKSpriteNode(imageNamed: "cloud")
        cloudNode.setScale(1.2)
        //雲の位置をシーンの中央にする。
        //cloudNode.position = CGPoint(x: cloudNode.frame.width/2, y: self.frame.height - sunNode.frame.height/2)
        cloudNode.position = CGPoint(x: cloudNode.frame.width/2, y: self.frame.height/2)
        //鳥ノードを取得する。
        //birdNode = self.childNode(withName: "bird_brown") as? SKSpriteNode
        
        //男のノードを作成する。
        manNode = SKSpriteNode(imageNamed: "man_coat")
        //manNode = self.childNode(withName: "man") as? SKSpriteNode
        manNode.setScale(0.8)
        //男の位置を調整
        manNode.position = CGPoint(x: self.frame.width, y: self.frame.midY/4+80)
        //manNode.physicsBody = SKPhysicsBody(texture: manNode.texture!, size: manNode.size)
        //ネクストボタンのノードを作成する。
        nextNode = SKSpriteNode(imageNamed: "next")
        nextNode.name = "nextNode"
        nextNode.setScale(0.5)
        nextNode.position = CGPoint(x: self.frame.midX + self.frame.midX/2, y:nextNode.frame.height)
        
        //カテゴリマスクを設定する。
        self.physicsBody?.categoryBitMask = 0b0001
        
        //デリゲート先を自分に設定する。
        self.physicsWorld.contactDelegate = self
        //画面端に物理ボディを設定する。
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        self.addChild(backNode)
        self.addChild(sunNode)
        self.addChild(cloudNode)
        self.addChild(manNode)
        self.addChild(nextNode)
        
        //以下アクション系
        let cloudActionBig = SKAction.scale(to: 1.6, duration: 1)
        let cloudActionSmall = SKAction.scale(to: 1.2, duration: 1)
        let cloudActionBS = SKAction.sequence([cloudActionBig,cloudActionSmall])
        let loopAction = SKAction.repeatForever(cloudActionBS)
        let manAction = SKAction.move(to:CGPoint(x:self.frame.midX, y: self.frame.midY/4), duration:10)
        let img1 = SKTexture(imageNamed: "man_coat")
        let img2 = SKTexture(imageNamed: "man_stand")
        let walkAction = SKAction.animate(with: [img1, img2], timePerFrame: 0.2)
        let walkActionAnytime = SKAction.repeat(walkAction, count: 30)
        
        cloudNode.run(loopAction)
        manNode.run(manAction)
        manNode.run(walkActionAnytime)
    }
    
    
    
    //画面タッチ開始時の呼び出しメソッド
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        //タップ開始日時を取得する。
        startDate = NSDate()
        
        //ネクストボタンが押された次のシーンへ
        if let node = atPoint(location) as? SKSpriteNode {
            
            //タッチしたのがラベルノードの場合、スタートボタンなのかを確認する。
            let startButton = self.childNode(withName: "nextNode") as? SKSpriteNode
            if(node == startButton) {
                let skView = self.view as! SKView
                let transition = SKTransition.flipVertical(withDuration: 1)
                //スタートボタンを押した場合はプレイ画面に切り替える。
                //let result = WindSunScene(fileNamed: "WindSunScene")
                let result = WindScene(size: skView.frame.size)
                self.view!.presentScene(result, transition: transition)
            }
        }
    }
    
    
    
    //画面タッチ移動時の呼び出しメソッド
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //タッチした位置まで移動するアクションを作成する。
        let location = touches.first!.location(in: self)
        let action = SKAction.move(to: CGPoint(x:location.x, y:location.y + 20), duration:0.1)
        
        //アクションを実行する。
        manNode!.run(action)
    }
    
    
    
    //画面タッチ終了時の呼び出しメソッド
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //重力の影響を受けるようにする。
        manNode.physicsBody?.affectedByGravity = true
    }
    
    
    
    //衝突検知時の呼び出しメソッド
    func didBeginContact(contact: SKPhysicsContact) {
        print("衝突しました")
    }
}
