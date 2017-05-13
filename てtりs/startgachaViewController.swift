
//
//  startgachaViewController.swift
//  てtりs
//
//  Created by 上住悠生 on 2016/07/09.
//  Copyright © 2016年 上住悠生. All rights reserved.
//

import UIKit

class startgachaViewController: UIViewController {
    
    var number: Int!
    //ボタンを押したときに乱数を発生させる
    
    @IBAction func getRandomNumber() {
        number = Int(arc4random_uniform(11))
        NSLog("発生した乱数は...%dです", number)
    }
    
    //画面遷移する前に呼ばれる処理　ここで２つ目の画面(ResultViewController)に値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Segueのdestination (目的地）、つまりこの画面の次の画面を取得する
        let resultViewController = segue.destination as! gachaViewController
        //画面遷移の型を変える
        resultViewController.modalTransitionStyle = UIModalTransitionStyle.init(rawValue: 1)!
        //結果画面のnumber変数にガチャ画面で発生した乱数を渡す
        resultViewController.number = self.number
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
