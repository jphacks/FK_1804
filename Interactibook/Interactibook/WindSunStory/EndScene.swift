
//  EndScene.swift
//  Interactibook
//
//  Created by 仲地早司 on 2018/10/27.
//  Copyright © 2018年 仲地早司. All rights reserved.
//
import Foundation
import SpriteKit

class EndScene: SKScene, SKPhysicsContactDelegate {
    var cloudNode:SKSpriteNode!
    var sunNode:SKSpriteNode!
    var manNode:SKSpriteNode!
    var oNode:SKSpriteNode!
    var shiNode:SKSpriteNode!
    var maNode:SKSpriteNode!
    var iNode:SKSpriteNode!
    
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
        
        //雲のノードを作成する。
        cloudNode = SKSpriteNode(imageNamed: "cloud")
        cloudNode.setScale(1.4)
        //雲の位置を調整
        cloudNode.position = CGPoint(x: cloudNode.frame.width/2, y: self.frame.height*3/4)
        
        //男のノードを作成する。
        manNode = SKSpriteNode(imageNamed: "man_title")
        manNode.setScale(0.4)
        //男の位置をシーンの中央にする。
        manNode.position = CGPoint(x: self.frame.midX, y: -10)
        
        //おしまいのノードを作成
        oNode = SKSpriteNode(imageNamed: "o")
        shiNode = SKSpriteNode(imageNamed: "shi")
        maNode = SKSpriteNode(imageNamed: "ma")
        iNode = SKSpriteNode(imageNamed: "i")
        oNode.setScale(0.5)
        shiNode.setScale(0.5)
        maNode.setScale(0.5)
        iNode.setScale(0.5)
        oNode.position = CGPoint(x: self.frame.midX - 200, y: self.frame.midY)
        shiNode.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY)
        maNode.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY)
        iNode.position = CGPoint(x: self.frame.midX + 200, y: self.frame.midY)
        
        self.addChild(backNode)
        self.addChild(sunNode)
        self.addChild(cloudNode)
        self.addChild(manNode)
        self.addChild(oNode)
        self.addChild(shiNode)
        self.addChild(maNode)
        self.addChild(iNode)
        
<<<<<<< HEAD
    }
=======
}
>>>>>>> 7c097e9cb0995307ec3f9dd8fc31adb5532c7304
}
