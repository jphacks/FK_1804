//
//  StoryViewController.swift
//  Interactibook
//
//  Created by 仲地早司 on 2018/10/27.
//  Copyright © 2018年 仲地早司. All rights reserved.
//

import UIKit
import SpriteKit

class StoryViewController: UIViewController {

    @IBOutlet weak var storySceneView: SKView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //SKViewを取得する。
        //let skView = self.storySceneView as! SKView
        
        //SKViewと同じサイズのSKSceneインスタンスを生成する。
        //let scene = MainScene(size:skView.frame.size)
        let scene = TitleScene(size:storySceneView.frame.size)
        
        //現在シーンを設定する。
        storySceneView.presentScene(scene)
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
