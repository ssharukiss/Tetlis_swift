
//
//  gachaViewController.swift
//  てtりs
//
//  Created by 上住悠生 on 2016/07/09.
//  Copyright © 2016年 上住悠生. All rights reserved.
//

import UIKit

class gachaViewController: UIViewController {

    var number: Int!
    var introduction: String!
    
    
    
    
    
    
     var Data:[[String]]!
    
    //画像を表示するためのImageViewを用意
    
    @IBOutlet var monsterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let SaveData: UserDefaults = UserDefaults.standard
//        SaveData.set([
//            ["0","name","0.png","false"],
//            ["1","name2","1.png","false"],
//            ["2","name3","2.png","false"],
//            ["3","name4","3.png","false"],
//            ["4","name5","4.png","false"]],forKey: "GACHA")
        Data = SaveData.object(forKey: "GACHA") as! [[String]]
        
        // Do any additional setup afte r loading the view.
        NSLog("渡された値は...%だっ！", number)
        
        if number == 10 {
            
            Data[0][3] = "true"
            
            
        }else if number == 9 {
           
            Data[1][3] = "true"
            monsterImageView.image = UIImage(named: Data[1][2])
        
            
            
        }else if number == 8 {
            //激レアモンスター
           
            Data[2][3] = "true"
            monsterImageView.image =  UIImage(named: Data[2][2])
            
        }else if number > 5 {
        
            //レアモンスター
            
            Data[3][3] = "true"
            monsterImageView.image = UIImage(named: Data[3][2])
            
            
        }else {
            //ノーマルモンスター
           
            
            Data[4][3] = "true"
            
    
           
            
            monsterImageView.image = UIImage(named: Data[4][2])
        }
        
        
         SaveData.set(Data, forKey:  "GACHA")
        print(Data)
    }
  
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
