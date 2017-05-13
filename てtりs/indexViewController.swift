//
//  monsters robby ViewController.swift
//  TechMon
//
//  Created by 上住悠生 on 2016/02/20.
//  Copyright © 2016年 上住悠生. All rights reserved.
//

import UIKit

class indexViewController: UIViewController {
    
    var indexnumber: Int = 0
    
    @IBOutlet var MonsterImageView: UIImageView!
    @IBOutlet var MonsterIntroduce: UILabel!
    @IBOutlet var monsternumber: UILabel!
    @IBOutlet var monstername: UILabel!
    
    var Data:[[String]]!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let SaveData: UserDefaults = UserDefaults.standard
        Data = SaveData.object(forKey: "GACHA") as! [[String]]
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func next() {
        
        indexnumber = indexnumber + 1
        NSLog("%d",indexnumber)
        Index()
    }
    
    
    
    func Index() {
        
        if indexnumber == 1 {
            if (Bool(Data[0][3])) == false {
                monstername.text = "不明"
                monsternumber.text = "No.?"
            }else{
                monstername.text = Data[0][1]
                monsternumber.text = Data[0][0]
                MonsterImageView.image = UIImage(named: Data[0][2])

            }
        }else if indexnumber == 2 {
            if (Bool(Data[1][3])) == false {
                monstername.text = "不明"
                monsternumber.text = "No.?"
            }else{
            monstername.text = Data[1][1]
            monsternumber.text = Data[1][0]
            MonsterImageView.image = UIImage(named: Data[1][2])
            }
        }else if indexnumber == 3  {
            if (Bool(Data[2][3])) == false {
                monstername.text = "不明"
                monsternumber.text = "No.?"
            }else{
            monstername.text = Data[2][1]
            monsternumber.text = Data[2][0]
            MonsterImageView.image = UIImage(named: Data[2][2])
            }
        }else if indexnumber == 4 {
            if (Bool(Data[3][3])) == false {
                monstername.text = "不明"
                monsternumber.text = "No.?"
            }else{
            monstername.text = Data[3][1]
            monsternumber.text = Data[3][0]
            MonsterImageView.image = UIImage(named: Data[3][2])
            }
        }else if indexnumber == 5 {
            if (Bool(Data[4][3])) == false {
                monstername.text = "不明"
                monsternumber.text = "No.?"
            }else{
            monstername.text = Data[4][1]
            monsternumber.text = Data[4][0]
            MonsterImageView.image = UIImage(named: Data[4][2])
            }
        }else{
                    }
        
        
        
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
