//
//  Singleton.swift
//  Interactibook
//
//  Created by kota on 2018/10/27.
//  Copyright © 2018年 仲地早司. All rights reserved.
//

import UIKit

class Singleton: NSObject {
    
    var setKeyWord : String! = "defaoults"
    var nextIdx : Int! = 0
    
    class var sharedInstance: Singleton {
        struct Static {
            static let instance : Singleton = Singleton()
        }
        return Static.instance
    }
    
}
