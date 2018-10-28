//
//  StoryViewController.swift
//  Interactibook
//
//  Created by 仲地早司 on 2018/10/27.
//  Copyright © 2018年 仲地早司. All rights reserved.
//

import UIKit
import SpriteKit
import Firebase
import FirebaseCore
import FirebaseDatabase

class StoryViewController: UIViewController {

    @IBOutlet weak var storySceneView: SKView!

    var nextIdx:Int = 0
    
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("command")
        ref.observe(DataEventType.childChanged, with: { snapshot in
            if let keyword = snapshot.value! as? String{
                Singleton.sharedInstance.setKeyWord = keyword
                print(keyword)
                self.selectActions(key: Singleton.sharedInstance.setKeyWord)
            }
        })
        
        //SKViewを取得する。
        //let skView = self.storySceneView as! SKView
        
        //SKViewと同じサイズのSKSceneインスタンスを生成する。
        //let scene = MainScene(size:skView.frame.size)
        let scene = TitleScene(size:storySceneView.frame.size)
        
        
        
        //現在シーンを設定する。
        storySceneView.presentScene(scene)
        // Do any additional setup after loading the view.
    }

}

extension StoryViewController{
    
    func selectActions(key:String) {
        switch key {
        case "next_story":
            if nextIdx == 0 {
                let sc =  self.storySceneView.scene as! TitleScene
                sc.nextScene()
            }else if nextIdx == 1{
                let sc =  self.storySceneView.scene as! WindSunScene
                sc.nextScene()
            }else if nextIdx == 2{
                let sc =  self.storySceneView.scene as! WindScene
                sc.nextScene()
            }else if nextIdx == 3{
                let sc = self.storySceneView.scene as! SunScene
<<<<<<< HEAD
                sc.nextScene()
=======
>>>>>>> 7c097e9cb0995307ec3f9dd8fc31adb5532c7304
            }else {
                return
            }
            self.nextIdx += 1
        case "wind":
            let sc =  self.storySceneView.scene as! WindScene
            sc.whirlwind()
            return
        case "sun":
//            let sc =  self.storySceneView.scene as! WindScene
//            sc.nextScene()
            return
//        case "win_sun":
//            let sc =  self.storySceneView.scene as! SunScene
//            sc.nextScene()
//        case "end":
//            let sc =  self.storySceneView.scene as! 
//            sc.nextScene()
        default:
            return
        }
    
    }
    
}
