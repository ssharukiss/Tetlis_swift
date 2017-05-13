//
//  ViewController.swift
//  tetrisHaruki
//
//  Created by yuki takei on 2016/11/19.
//  Copyright © 2016年 Yuki Takei. All rights reserved.
//
/*
 aaaaaaaaaaafsajkhcebhf;vl
 
 
*/

import UIKit

struct CellStopper{
    var flag:Bool = false
    var stopNum:Int = 0
}



class ViewController: UIViewController {
    
    
    /*
     cellBlock >>> 移動するcellである
     
     タグの使い方
     cellsBlock.tag = ブロックがあるかないかの判別
     # 基準となる場所 xpos,yposが対応する
     0 ブロックが存在しない
     1 ブロックが存在する
     2 接地する可能性があるブロック
     
     ex>十字のブロックの場合
     ___________
     |   |   |   |
     | # | 1 | 0 |
     |___|___|___|
     |   |   |   |
     | 2 | 1 | 2 |
     |___|___|___|
     |   |   |   |
     | 0 | 2 | 0 |
     |___|___|___|
     
     doneImageView　>>> 背景のimageView 接地したら全部こっちに移動
     
     
     
     
     */
    
    var shapeClass = ShapeClass()
    
    
    let screenSize = UIScreen.main.bounds.size
    var cellSize: CGFloat = 0
    var cellView = UIImageView()
    
    
    var cellsBlock = [[UIImageView]]()
    var doneImageView = [[UIImageView]]()
    
    //    var cells: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 10), count: 10)
    //    var tagDig: [[Int]] = [[Int]](repeating: [Int](repeating: 0, count: 10), count: 10)
    
    let leftButton = UIButton()
    let rightButton = UIButton()
    let downButton = UIButton()
    @IBOutlet var ScoreLabel: UILabel!
    
    
    //var period = 0.5
    let BG_CELL_NUM_X = 10
    let BG_CELL_NUM_Y = 12
    
    let MOVE_CELL_START_POS_X = 5
    let MOVE_CELL_START_POS_Y = 0
    
    
    var xPos: Int = 0
    var yPos: Int = 0
    var ScoreNumber: Float = 0.0
    
    var timer: Timer!
    var timerL: Timer!
    var timerR: Timer!
    
    var cellColor:Int = 0
    var flagColor:Int = 0
    
    var cellStopper = CellStopper()
    
    var cellnumber:Int = 0
    
    let SaveData: UserDefaults = UserDefaults.standard
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setTimer()
        
        cellSize = screenSize.width / CGFloat(BG_CELL_NUM_X)
        
        setupButton()
        //背景のviewの設定
        setupBackgroundCells()
        var Data = SaveData.object(forKey: "GACHA") as! [[String]]
        setupMoveCells()
        
        /*
         doneView[0][0].frame = CGRectMake(cellSize*CGFloat(0), cellSize*CGFloat(0), cellSize, cellSize)
         doneView[0][0].image = UIImage(named: "1.png")
         view.addSubview(doneView[0][0])
         
         
         for i in 0...14 {
         for j in 0...19 {
         doneView[i][j].frame = CGRectMake(cellSize*CGFloat(i), cellSize*CGFloat(j), cellSize, cellSize)
         doneView[i][j].image = UIImage(named: "1.png")
         self.view.addSubview(doneView[i][j])
         }
         }
         */
        
        
        
    }
    
    
    
    //それぞれのタイマー
    func setTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    func setTimerL() {
        timerL = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.updateL), userInfo: nil, repeats: true)
    }
    
    func setTimerR() {
        timerR = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.updateR), userInfo: nil, repeats: true)
    }
    
    
    func update() {
        
        //cellを一マスずつ落とすプログラム
        
        
        //落とすかの判定
        serchCellsContact: for i in 0..<cellsBlock.count {
            for j in 0..<cellsBlock[i].count{
                //                print("xPos:\(xPos) yPos:\(yPos) i:\(i) j:\(j)")
                
                //接地ブロックを確認
                if cellsBlock[i][j].tag == 2 {
                    
                    //ここでnil判定
                    if xPos+i+1 < BG_CELL_NUM_X && yPos+j+1 < BG_CELL_NUM_Y {
                        if  doneImageView[xPos+i+1][yPos+j+1].tag == 0 { //yPos < BG_CELL_NUM_Y &&
                            //一個下がる
                            cellStopper.flag = false
                            
                            
                            /*test*/
                            //                            doneImageView[xPos][yPos] = cellsBlock[i][j] //= cellsBlock[i][j]
                            
                            //==============================
                            
                            
                        }else{
                            //ストップ
                            cellStopper.flag = true
                            break serchCellsContact
                            
                        }
                    }else{
                        cellStopper.flag = true
                        break serchCellsContact
                    }
                    
                }
            }
        }
        
        
        //判定結果のアクション
        if cellStopper.flag == false {  //一個下がる
            print(cellsBlock.count)
            for i in 0..<cellsBlock.count {
                for j in 0..<cellsBlock[i].count{
                    cellsBlock[i][j].frame.origin.y = cellsBlock[i][j].frame.origin.y + cellSize
                    //                        * CGFloat(yPos+1)
                }
            }
            yPos += 1
            
        }else{  //ストップ
            for i in 0..<cellsBlock.count {
                for j in 0..<cellsBlock[i].count{
                    doneImageView[xPos+i][yPos+j] = cellsBlock[i][j]
                    //                    doneImageView[xPos+i][yPos+j].image = UIImage(named:"no=1")
                    print("xP:\(xPos+i),yP\(yPos+j),tag:\(doneImageView[xPos+i][yPos+j].tag)")
                    //                    doneImageView[xPos+i][yPos+j].reloadInputViews()
                    
                }
            }
            
            setupMoveCells()
        }
        
        
        
        
        //        if yPos < 9 && cells[xPos][yPos+1] == 0{
        //
        //            cells[xPos][yPos+1] = cellColor
        //            cellView.frame.origin.y = cellSize * CGFloat(yPos+1)
        //            cells[xPos][yPos] = 0
        //            yPos = yPos + 1
        //
        //
        //
        //            //落下しないとき
        //        }else {
        //
        //            //cellが地面に当たった時そこでcellを止めるプログラム
        //
        //            let doneView: UIImageView = self.view.viewWithTag(tagDig[xPos][yPos]) as! UIImageView
        //            doneView.image = cellView.image
        //
        //            xPos = 5
        //            yPos = 0
        //            cells[xPos][yPos] = cellColor
        //            cellView.frame.origin.x = cellSize * CGFloat(xPos)
        //            cellView.frame.origin.y = cellSize * CGFloat(yPos)
        //
        //            /*
        //             doneView[xPos][yPos].frame = CGRectMake(cellSize*CGFloat(xPos), cellSize*CGFloat(yPos), cellSize, cellSize)
        //
        //             doneView[xPos][yPos].image = UIImage(named: "1.png")
        //
        //             view.addSubview(doneView[xPos][yPos])
        //             */
        //
        //
        //            for i in 0..<10 {
        //                for j in 0..<10 {
        //
        //                    //x方向の判定
        //                    if cells[i][j] != 0{
        //                        let flag =  cells[i][j]
        //                        if cells [i][j] == flag && i<7{
        //                            if cells[i+1][j] == flag && cells[i+2][j] == flag && cells[i+3][j] == flag{
        //                                flagColor = flag
        //                                print("揃った_X/ cellcolor:\(flagColor),i:\(i),j:\(j)")
        //                                delateObjectX(i , y:j)
        //                                ScoreNumber = ScoreNumber + 0.5
        //                                ScoreLabel.text = String(ScoreNumber)
        //                            }
        //                        }
        //
        //                        //y方向の判定
        //                        if cells [i][j] == flag && j<7{
        //                            if cells[i][j+1] == flag && cells[i][j+2] == flag && cells[i][j+3] == flag{
        //                                flagColor = flag
        //                                print("揃った_Y")
        //                                delateObjectY(i , y:j)
        //                                ScoreNumber = ScoreNumber + 0.5
        //                                ScoreLabel.text = String(ScoreNumber)
        //                            }
        //                        }
        //
        //                    }
        //
        //
        //
        //                }
        //
        //            }
        //
        //            //色決定
        //            var number: Int!
        //            number = Int(arc4random_uniform(6))
        //
        //            if number >= 5 {
        //                cellView.image = UIImage(named: "no=1.png")
        //                cellColor = 1
        //            }else if number >= 3 {
        //                cellView.image = UIImage(named: "no=2.png")
        //                cellColor = 2
        //            }else{
        //                cellView.image = UIImage(named: "no=3.png")
        //                cellColor = 3
        //            }
        //
        //            wait(w_status: 1000)
        
        //        }
        
        //        print("+++++++++++++++++++")
        //        for i in 0..<cellsBlock.count {
        //            for j in 0..<cellsBlock[i].count{
        //                print(cellsBlock[i][j].tag)
        //            }
        //        }
        //
        //        print("+++++++++++++++++++")
        
        
    }
    
    func downPush() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    func downPush2() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    func updateL() {
        //        //print(xPos)
        //        if xPos != 0 {
        //            if cellsBlock[xPos-1][yPos].tag == 0{
        //                cellsBlock[xPos-1][yPos] == cellColor
        //                cellView.frame.origin.x = cellSize * CGFloat(xPos-1)
        //                cellsBlock[xPos][yPos] = 0
        //                xPos = xPos - 1
        //            }
        //        }
        
        //一番左かどうかの判定
        if xPos == 0{
            return
        }
        
        //左にブロックがあるかの判定
        for i in 0..<cellsBlock.count {
            for j in 0..<cellsBlock[i].count{
                
                //cellsBlockの隣のdoneImageViewが空のとき
                if doneImageView[xPos+i-1][yPos+j].tag == 0 {
                    cellsBlock[i][j].frame.origin.x = cellsBlock[i][j].frame.origin.x - cellSize
                    
                }
                
                //                        * CGFloat(yPos+1)
            }
        }
        xPos -= 1
        
        
    }
    
    func updateR() {
        
        //一番右かどうかの判定
        if doneImageView.count == xPos + cellsBlock.count{
            return
        }
        
        //右にブロックがあるかの判定
        for i in 0..<cellsBlock.count {
            for j in 0..<cellsBlock[i].count{
                
                //cellsBlockの隣のdoneImageViewが空のとき
                if doneImageView[xPos+i+1][yPos+j].tag == 0 {
                    
                    cellsBlock[i][j].frame.origin.x = cellsBlock[i][j].frame.origin.x + cellSize
                    
                }
                
                //                        * CGFloat(yPos+1)
            }
        }
        xPos += 1
        //        if xPos != 9 {
        //print(xPos)
        //            if cells[xPos+1][yPos] == 0{
        //                cells[xPos+1][yPos] = cellColor
        //                cellView.frame.origin.x = cellSize * CGFloat(xPos+1)
        //                cells[xPos][yPos] = 0
        //                xPos = xPos + 1
        //            }
        //        }
    }
    
    //押された瞬間しか動かない
    //    func leftPush() {
    //        setTimerL()
    //    }
    //    func leftPush2() {
    //        timerL.invalidate()
    //    }
    //
    //    func rightPush() {
    //        setTimerR()
    //    }
    //    func rightPush2() {
    //        timerR.invalidate()
    //    }
    //
    
    
    //    func delateObjectX(_ x:Int, y:Int){
    //        //        print("+++++++++++++++++++")
    //        //        print("before")
    //        //        print(cells)
    //        //        print("+++++++++++++++++++")
    //        //
    //
    //
    //
    //        cells[xPos][yPos] = 0    //これいる？
    //        for i in 0...3{
    //            var CellsY:[Int] = cells[x+i]
    //            CellsY.remove(at: y)
    //            CellsY.insert(0, at: 0)
    //            cells[x+i] = CellsY
    //            //            print("\(x+1):\(CellsY)")
    //            for j in 0...9 {
    //                let doneView: UIImageView = self.view.viewWithTag(tagDig[x+i][j]) as! UIImageView
    //                decideImageView(doneView, cellsNum: cells[x+i][j])
    //
    //            }
    //        }
    //
    //        print("+++++++++++++++++++")
    //        print("before")
    //        for i in 0...9{
    //            print("\(i):\(cells[i])")
    //        }
    //        print("+++++++++++++++++++")
    //
    //
    //    }
    
    
    
    //    func delateObjectY(_ x:Int, y:Int){
    //
    //        //        for i in 0...3{
    //        //            cells[x][y+i] = 0
    //        //            let doneView: UIImageView = self.view.viewWithTag(tagDig[x][y+i]) as! UIImageView
    //        //            doneView.image = UIImage(named: "no=4.png")
    //        //        }
    //
    //        cells[xPos][yPos] = 0    //これいる？
    //        var CellsY:[Int] = cells[x]
    //        for i in 0..<4{
    //            CellsY.remove(at: y+i)
    //            CellsY.insert(0, at: 0)
    //        }
    //        cells[x] = CellsY
    //
    //        for j in 0...9 {
    //            let doneView: UIImageView = self.view.viewWithTag(tagDig[x][j]) as! UIImageView
    //            decideImageView(doneView, cellsNum: cells[x][j])
    //        }
    //
    //        //        for i in 0...3{
    //        //            cells[x][y+i] = 0
    //        //            let doneView: UIImageView = self.view.viewWithTag(tagDig[x][y+i]) as! UIImageView
    //        //            doneView.image = UIImage(named: "no=4.png")
    //        //        }
    //        //
    //        //        cells[xPos][yPos] = 0
    //        //
    //        //        var CellsY:[Int] = cells[x]
    //        //        for i in 0..<4{
    //        //            CellsY.removeAtIndex(y)
    //        //            CellsY.insert(0, atIndex: 0)
    //        //        }
    //        //        cells[x] = CellsY
    //        //
    //        //        for j in 0...9 {
    //        //            if cells[x][j] == 0{
    //        //                var doneView: UIImageView = self.view.viewWithTag(tagDig[x][j]) as! UIImageView
    //        //                doneView.image = UIImage(named:"no=4")
    //        //
    //        //            }else if cells[x][j] == flagColor{
    //        //                var doneView: UIImageView = self.view.viewWithTag(tagDig[x][j]) as! UIImageView
    //        //                doneView.image = cellView.image
    //        //            }
    //        //        }
    //
    //    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func decideImageView(_ imageView:UIImageView,cellsNum:Int){
        if cellsNum == 0{
            imageView.image = UIImage(named:"no=4")
        }else if cellsNum == 1 {
            imageView.image = UIImage(named: "no=1.png")
        }else if cellsNum == 2 {
            imageView.image = UIImage(named: "no=2.png")
        }else if cellsNum == 3{
            imageView.image = UIImage(named: "no=3.png")
        }
    }
    
    func setupBackgroundCells(){
        var tagTmp = 1
        for i in 0..<BG_CELL_NUM_X {
            doneImageView.append([UIImageView]())
            for j in 0..<BG_CELL_NUM_Y{
                let doneView = UIImageView()
                doneView.layer.borderColor = UIColor.black.cgColor
                doneView.layer.borderWidth = 0
                doneView.frame = CGRect(x: cellSize*CGFloat(i), y: cellSize*CGFloat(j), width: cellSize, height: cellSize)
                doneView.image = UIImage(named: "4.png")
                doneView.tag = 0//tagTmp
                //                tagDig[i][j] = tagTmp
                self.view.addSubview(doneView)
                self.view.sendSubview(toBack: doneView)
                
                doneImageView[i].append(doneView)
                
                tagTmp += 1
            }
        }
        
    }
    
    
    
    func setupMoveCells(){
        
        cellsBlock = [[UIImageView]]()
        
        //スタート位置
        xPos = MOVE_CELL_START_POS_X
        yPos = MOVE_CELL_START_POS_Y
        
        var shape:[[Int]] = shapeClass.blockSelector()
        print(shape)
        
        for i in 0..<shape.count {
            cellsBlock.append([UIImageView]())
            
            for j in 0..<shape[i].count{
                //落ちるviewの設定
                var cellView = UIImageView()
                cellView.frame = CGRect(x: cellSize*CGFloat(xPos+i), y: cellSize*CGFloat(yPos+j), width: cellSize, height: cellSize)
                cellView.tag = shape[i][j]
                
                if cellView.tag != 0 {
                    
                   // if cellView.tag == 1{
                      //  cellView.image = UIImage(named: "no=1.png")
                    //}else if cellView.tag == 2{
                       // cellView.image = UIImage(named: "2.png")
                    
                    
                    
//                    if Data[3] >= 6 {
//                        cellView.image = UIImage(named: "no=1.png")
//                        
//                    }else if cellnumber >= 3 {
//                         cellView.image = UIImage(named: "2.png")
//                        
//                    }else{
//                        cellView.image = UIImage(named: "3.png")
//                    }
//
//                    
//                    
//        
                    
                }
//
                    
                    
                
                
                self.view.addSubview(cellView)
                //ここ何？？ 99
                if j == 99 {
                    cellsBlock[i][j] = cellView
                }else{
                    cellsBlock[i].append(cellView)
                }
            }
        
        }
        
    }
    
    func setupButton(){
        
        //それぞれのボタンの設定
        //なんか関数多くね？
        
        
        leftButton.frame = CGRect(x: screenSize.width/2-CGFloat(cellSize*4), y: screenSize.height-CGFloat(cellSize*2), width: CGFloat(cellSize*2), height: CGFloat(cellSize*2))
        leftButton.setImage(UIImage(named:"cute3.png"), for:UIControlState())
        leftButton.titleLabel!.font = UIFont.systemFont(ofSize: 40)
        leftButton.backgroundColor = UIColor.yellow
        leftButton.addTarget(self, action: #selector(ViewController.updateL), for: .touchUpInside)
        //            leftButton.addTarget(self, action: "leftPush2", forControlEvents: .TouchUpInside)
        //            leftButton.addTarget(self, action: "leftPush2", forControlEvents: .TouchUpOutside)
        self.view.addSubview(leftButton)
        
        rightButton.frame = CGRect(x: screenSize.width/2+CGFloat(cellSize*2), y: screenSize.height-CGFloat(cellSize*2), width: CGFloat(cellSize*2), height: CGFloat(cellSize*2))
        rightButton.setImage(UIImage(named:"cute2.png"), for:UIControlState())
        
        rightButton.titleLabel!.font = UIFont.systemFont(ofSize: 40)
        rightButton.backgroundColor = UIColor.yellow
        rightButton.addTarget(self, action: #selector(ViewController.updateR), for: .touchUpInside)
        //                rightButton.addTarget(self, action: "rightPush2", forControlEvents: .TouchUpInside)
        //                rightButton.addTarget(self, action: "rightPush2", forControlEvents: .TouchUpOutside)
        self.view.addSubview(rightButton)
        
        downButton.frame = CGRect(x: screenSize.width/2-CGFloat(cellSize), y: screenSize.height-CGFloat(cellSize*2), width: CGFloat(cellSize*2), height: CGFloat(cellSize*2))
        downButton.setImage(UIImage(named:"cute.png"), for:UIControlState())
        downButton.titleLabel!.font = UIFont.systemFont(ofSize: 40)
        downButton.backgroundColor = UIColor.yellow
        downButton.addTarget(self, action: #selector(ViewController.downPush), for: .touchDown)
        downButton.addTarget(self, action: #selector(ViewController.downPush2), for: .touchUpInside)
        downButton.addTarget(self, action: "donwPush2", for: .touchUpOutside)
        self.view.addSubview(downButton)
        
    }
    
    
    
}

