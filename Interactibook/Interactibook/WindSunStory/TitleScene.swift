//
//  TitleScene.swift
//  Interactibook
//
//  Created by 仲地早司 on 2018/10/27.
//  Copyright © 2018年 仲地早司. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class TitleScene:SKScene {
    
    var manNode:SKSpriteNode!
    var sunNode:SKSpriteNode!
    var cloudNode:SKSpriteNode!
    var titleNode:SKSpriteNode!
    var nextNode:SKSpriteNode!
    var player:AVAudioPlayer!  //for music
    //現在シーン設定時の呼び出しメソッド
    override func didMove(to view: SKView) {
        //背景画像のノードを作成する。
        let backNode = SKSpriteNode(imageNamed: "haikei1")
        //背景画像のサイズをシーンのサイズと同じにする。
        backNode.size = self.frame.size
        //背景画像の位置をシーンの中央にする。
        backNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        /*
         //画面サイズを合わせる
         self.scaleMode = .aspectFit
         */
        //タイトルのノードを作成する。
        titleNode = SKSpriteNode(imageNamed: "title")
        titleNode.setScale(1.3)
        //タイトルの位置をシーンの中央にする。
        titleNode.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        
        //太陽のノードを作成する。
        sunNode = SKSpriteNode(imageNamed: "taiyou")
        sunNode.setScale(0.8)
        //太陽の位置をシーンの中央にする。
        //sunNode.position = CGPoint(x: self.frame.width - sunNode.frame.width/2, y: self.frame.height - sunNode.frame.height/2)
        sunNode.position = CGPoint(x: self.frame.width - sunNode.frame.width/2, y: self.frame.height + 10)
        
        //雲のノードを作成する。
        cloudNode = SKSpriteNode(imageNamed: "cloud")
        cloudNode.setScale(1.2)
        //雲の位置をシーンの中央にする。
        //cloudNode.position = CGPoint(x: cloudNode.frame.width/2, y: self.frame.height - sunNode.frame.height/2)
        cloudNode.position = CGPoint(x: cloudNode.frame.width/2, y: self.frame.height + 10)
        
        //男のノードを作成する。
        manNode = SKSpriteNode(imageNamed: "man_title")
        manNode.setScale(0.4)
        //男の位置をシーンの中央にする。
        manNode.position = CGPoint(x: self.frame.midX, y: -10)
        
        //ネクストボタンのノードを作成する。
        nextNode = SKSpriteNode(imageNamed: "next")
        //startNode = SKLabelNode(text: "NEXT")
        nextNode.name = "nextNode"
        nextNode.setScale(0.5)
        nextNode.position = CGPoint(x: self.frame.midX + self.frame.midX/2, y:nextNode.frame.height)
        
        
        //音楽
        let url = Bundle.main.bundleURL.appendingPathComponent("title.mp3")
        do {
            try player = AVAudioPlayer(contentsOf:url)
            
            //音楽を再生する。
            player.play()
            
        } catch {
            print(error)
        }
        //ノードをシーンに追加する。
        self.addChild(backNode)
        self.addChild(titleNode)
        self.addChild(sunNode)
        self.addChild(cloudNode)
        self.addChild(manNode)
        self.addChild(nextNode)
        
        //以下編集  行動系やで
        let sunActionRoate = SKAction.rotate(byAngle: 180, duration: 300)
        //let sunActionMove = SKAction.move(CGPoint(x: self.frame.width - sunNode.frame.width/2, y: self.frame.height - sunNode.frame.height/2), duration: 300)
        let sunActionMove = SKAction.move(to: CGPoint(x: self.frame.width - sunNode.frame.width/2, y: self.frame.height - sunNode.frame.height/2), duration: 3)
        let sunAction = SKAction.group([sunActionRoate, sunActionMove])
        let cloudActionBig = SKAction.scale(to: 1.6, duration: 1)
        let cloudActionSmall = SKAction.scale(to: 1.2, duration: 1)
        let cloudActionMove = SKAction.move(to: CGPoint(x: cloudNode.frame.width/2, y: self.frame.height - sunNode.frame.height/2), duration: 3)
        let cloudActionBS = SKAction.sequence([cloudActionBig,cloudActionSmall])
        let cloudAction = SKAction.group([cloudActionBS, cloudActionMove])
        let manAction = SKAction.move(to: CGPoint(x: self.frame.midX, y: self.frame.midY/4), duration: 3)
        
        sunNode.run(sunAction)
        cloudNode.run(cloudAction)
        manNode.run(manAction)
    }
    
    //画面タッチ時の呼び出しメソッド
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in:self)
        if let node = atPoint(location) as? SKSpriteNode {
            
            //タッチしたのがラベルノードの場合、スタートボタンなのかを確認する。
            let startButton = self.childNode(withName: "nextNode") as? SKSpriteNode
            if(node == startButton) {
                let skView = self.view as! SKView
                let transition = SKTransition.flipVertical(withDuration: 1)
                print("ok")
                //スタートボタンを押した場合はプレイ画面に切り替える。
                //let result = WindSunScene(fileNamed: "WindSunScene")
                let result = WindSunScene(size: skView.frame.size)
                self.view!.presentScene(result, transition: transition)
            }
            
        }
    }
}

