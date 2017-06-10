//
//  FinishViewController.swift
//  てtりs
//
//  Created by 上住悠生 on 2017/05/27.
//  Copyright © 2017年 上住悠生. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    
    @IBOutlet var num: UILabel! = UILabel()
    

    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
         result()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func result() {
       
        var message:Float = appDelegate.message
        num.text = String(describing: message)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
