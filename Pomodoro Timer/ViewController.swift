//
//  ViewController.swift
//  Pomodoro Timer
//
//  Created by 呂建鎧 on 2023/9/27.
//

import UIKit

class ViewController: UIViewController {
    

    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var controlButton: UIButton!
    
    
    // 命名變數
    var timer: Timer? // 計時器
    var secondsRemaining = 5 // 總秒數 25 分鐘 x 60 秒 = 1500 秒，為了方便測試先用 5 秒
    let totalSeconds = 5 // 計算進度條的總秒數
    
    override func viewDidLoad() {
            super.viewDidLoad()
            updateUI()
        }
    
    // 計時器控制開始和暫停
    @IBAction func controlButtonPressed(_ sender: UIButton) {
        
        if timer == nil{
            startTimer()
            controlButton.setTitle("暫停", for: .normal)
        }else {
            stopTimer()
            controlButton.setTitle("開始", for: .normal)
            
        }
        
    }
    
    // 開始計時
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            if self.secondsRemaining > 0 { //是否大於 0。如果是，代表還有時間尚未倒數完畢
                self.secondsRemaining -= 1 // 還有剩餘時間，每秒減 1
                self.updateUI()//更新 UI 顯示
            }else{
                
                self.textLabel.text = "時間到！"
                self.stopTimer() //時間到，停止計時
                
            }
        })
        
        
    }
    
        
        
    // 更新 UI
    
    func updateUI(){
        
        // 將文字格式設定為 MM:SS
        countdownLabel.text = "\(secondsRemaining / 60):\(String(format: "%02d", secondsRemaining % 60))"
        
    }
    
    
    //暫停計時
    
    func stopTimer(){
        timer?.invalidate() //停止計時
        timer = nil
        
    }
        
            
}
        
            


