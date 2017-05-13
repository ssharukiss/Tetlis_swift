//
//  ViewController.swift
//  harukiSpriteKit
//
//  Created by yuki takei on 2017/02/10.
//  Copyright © 2017年 Yuki Takei. All rights reserved.
//

import UIKit
import SpriteKit

class SKViewController: UIViewController {
    
    @IBOutlet var boardView:SKView!
    
    var boardScene:BoardScene = BoardScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any a®dditional setup after loading the view, typically from a nib.
        
        boardScene.size = boardView.frame.size
        
        boardView.presentScene(boardScene)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func finishgame () {
//            self.performSegue(withIdentifier: "tostart", sender: nil)
//        self.dismiss(animated: true, completion: nil)
//        self.presentedViewController?.dismiss(animated: true, completion: nil)
        
//        self.navigationController?.popViewController(animated: true)
        
    }

    
}
