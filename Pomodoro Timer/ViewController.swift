//
//  ViewController.swift
//  Pomodoro Timer
//
//  Created by 呂建鎧 on 2023/9/27.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    

    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var controlButton: UIButton!
    
    
    // 命名變數
    var timer: Timer? // 計時器
    var secondsRemaining = 5 // 總秒數 25 分鐘 x 60 秒 = 1500 秒，為了方便測試先用 5 秒
    let totalSeconds = 5 // 計算進度條的總秒數
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            updateUI()
        }
    
    // 計時器控制開始和暫停
    @IBAction func controlButtonPressed(_ sender: UIButton) {
        
        if timer == nil {
                if secondsRemaining == 0 {
                    // Reset the timer to the default value
                    secondsRemaining = totalSeconds
                    updateUI()
                    controlButton.setTitle("開始專注", for: .normal)
                } else {
                    startTimer()
                    controlButton.setTitle("停止", for: .normal)
                }
            } else {
                stopTimer()
                controlButton.setTitle("重新開始", for: .normal)
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
                self.playSound()  //播放聲音
                self.stopTimer() //時間到，停止計時
                
            }
        })
        
        
    }
    
        
        
    // 更新 UI
    
    func updateUI(){
        
        // 將文字格式設定為 MM:SS
        countdownLabel.text = "\(secondsRemaining / 60):\(String(format: "%02d", secondsRemaining % 60))"
        
        // 更新 progressBar 的進度
            progressBar.progress = 1.0 - Float(secondsRemaining) / Float(totalSeconds)
        
    }
    
    
    //暫停計時
    
    func stopTimer(){
        timer?.invalidate() //停止計時
        timer = nil
        
    }
    
    
    //播放聲音
    func playSound() {
        if let url = Bundle.main.url(forResource: "nature-soundstropicaljunglebirds", withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.play()
            } catch {
                print("音檔播放錯誤: \(error.localizedDescription)")
            }
        } else {
            print("未找到音檔")
        }
    }

        
            
}
        
            


