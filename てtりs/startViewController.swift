//
//  startViewController.swift
//  てtりs
//
//  Created by 上住悠生 on 2016/07/25.
//  Copyright © 2016年 上住悠生. All rights reserved.
//

import UIKit

class startViewController: UIViewController {
    
    
    var stamina: Float = 100
    var staminaTimer: Timer!
    
    @IBOutlet var staminaBar: UIProgressView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toBattle() {
        
        if stamina >= 50 {
            stamina = stamina - 20
            staminaBar.progress = stamina / 100
            
            
            self.performSegue(withIdentifier: "toBattle", sender:  nil)
        }else{
            let alert = UIAlertController(title: "バトルに行けません", message:"スタミナを溜めてください",
                
                preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func cureStamina() {
        
        staminaTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector:
            #selector(startViewController.updateStaminaValue), userInfo: nil, repeats: true)
        staminaTimer.fire()
    }
    
    func updateStaminaValue() {
        
        if stamina <= 100 {
            stamina = stamina + 1
            staminaBar.progress = stamina / 100
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
