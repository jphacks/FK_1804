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
    
    var databaseRef:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = Database.database().reference()
        
        databaseRef.observe(DataEventType.childAdded, with: { snapshot in //セッティングしている。新しいデータが入ってくるのを見張ってる。もしも、新しいデータが入ってきた場合{}内の処理を実行する。
            if let name = (snapshot.value! as AnyObject).object(forKey: "name") as? String,
                let message = (snapshot.value! as AnyObject).object(forKey: "message") as? String {
                
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
