//
//  ViewController.swift
//  BasketballScoreboard
//
//  Created by Labe on 2024/1/25.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //輸入隊伍
    @IBOutlet weak var homeTextField: UITextField!
    @IBOutlet weak var guestTextField: UITextField!
    //大錶
    @IBOutlet weak var gameDurationLabel: UILabel!
    @IBOutlet weak var gameDurationToggleButton: UIButton!
    //節數
    @IBOutlet weak var periodLabel: UILabel!
    //24秒
    @IBOutlet weak var shotClockLabel: UILabel!
    //主場
    @IBOutlet weak var homeScroesLabel: UILabel!
    @IBOutlet weak var homeFoulsCountLabel: UILabel!
    @IBOutlet weak var homeTOLCountLabel: UILabel!
    //客場
    @IBOutlet weak var guestScoresLabel: UILabel!
    @IBOutlet weak var guestFoulsCountLabel: UILabel!
    @IBOutlet weak var guestTOLCountLabel: UILabel!
    //時間相關的變數
    var timer: Timer?
    var timeIsRunning:Bool = false
    var minute = 10
    var second = 00
    var period = 0
    var shotClockTime = 24
    //分數、犯規、暫停相關變數
    var homeScore = 0
    var homeFouls = 0
    var homeTOL = 0
    var guestScore = 0
    var guestFouls = 0
    var guestTOL = 0
    
    //[自訂function]時間開始或暫停時變換Button圖案
    func isTimeRunning(button: UIButton) {
        if timeIsRunning == true {
            button.setImage(UIImage(systemName: "pause"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    //[自訂function]大錶時間存入Label
    func setGameDurationToLabel() {
        let numberFormatter = NumberFormatter()
        numberFormatter.formatWidth = 2
        numberFormatter.paddingCharacter = "0"
        let currentMinute = numberFormatter.string(from: NSNumber(value: minute))
        let currentSecond = numberFormatter.string(from: NSNumber(value: second))
        gameDurationLabel.text = "\(currentMinute!):\(currentSecond!)"
        
        shotClockLabel.text = "\(shotClockTime)"
    }
    
    //[鍵盤]按return鍵收起鍵盤
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       //textField.resignFirstResponder() 兩種寫法皆可
       self.view.endEditing(true)
       return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setGameDurationToLabel()
        //建立時鐘(建立在viewDidLoad是因為如果建立在Button裡的話，每按1次會產生1個新的時鐘(舊的不會消失，會一直累積下去，產生記憶體))
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            print("timer")
            if self.timeIsRunning == true {
                self.second -= 1
                if self.second < 0 {
                    self.minute -= 1
                    self.second = 59
                } else if self.second == 0 && self.minute == 0 {
                    self.timeIsRunning = false
                    self.isTimeRunning(button: self.gameDurationToggleButton)
                }
                self.shotClockTime -= 1
                if self.shotClockTime <= 0 {
                    self.shotClockTime = 0
                    self.timeIsRunning = false
                    self.isTimeRunning(button: self.gameDurationToggleButton)
                }
            }
            self.setGameDurationToLabel()
        })
        
        //[鍵盤]
        homeTextField.delegate = self
        guestTextField.delegate = self

    }

    //大錶
    //[Button]開始或暫停計時
    @IBAction func startOrPauseGameDurationButton(_ sender: Any) {
        timeIsRunning = !timeIsRunning
        isTimeRunning(button: gameDurationToggleButton)
        if shotClockTime == 0 {
            shotClockTime = 24
            shotClockLabel.text = "\(shotClockTime)"
        }
    }
    //[Button]重置計時
    @IBAction func resetGameDurationButton(_ sender: Any) {
        timeIsRunning = false
        minute = 10
        second = 00
        shotClockTime = 24
        isTimeRunning(button: gameDurationToggleButton)
        setGameDurationToLabel()
    }
    
    //節數
    //[Button]增加節數
    @IBAction func reducePeriodButton(_ sender: Any) {
        period -= 1
        if period < 1 {
            period = 1
        }
        periodLabel.text = "\(period)"
    }
    //[Button]減少節數
    @IBAction func addPeriodButton(_ sender: Any) {
        period += 1
        if period > 4 {
            period = 4
        }
        periodLabel.text = "\(period)"
    }
    
    //24秒
    //[Button]重置24秒
    @IBAction func resetShotClockTimeButton(_ sender: Any) {
        shotClockTime = 24
        shotClockLabel.text = "\(shotClockTime)"
    }
    
    //主場分數、犯規、暫停
    //[Stepper]以下個別是使用Stepper來控制主場分數、犯規、暫停數字的增減(注意sender要改成UIStepper)
    @IBAction func homeScoreCountStepper(_ sender: UIStepper) {
        homeScore = Int(sender.value)
        homeScroesLabel.text = "\(homeScore)"
    }
    @IBAction func homeFoulsCountStepper(_ sender: UIStepper) {
        homeFouls = Int(sender.value)
        homeFoulsCountLabel.text = "\(homeFouls)"
    }
    @IBAction func homeTOLCountStepper(_ sender: UIStepper) {
        homeTOL = Int(sender.value)
        homeTOLCountLabel.text = "\(homeTOL)"
    }
    
    //客場數、犯規、暫停
    //[Stepper]以下個別是使用Stepper來控制客場分數、犯規、暫停數字的增減(注意sender要改成UIStepper)
    @IBAction func guestScoreCountStepper(_ sender: UIStepper) {
        guestScore = Int(sender.value)
        guestScoresLabel.text = "\(guestScore)"
    }
    
    @IBAction func guestFoulsCountStepper(_ sender: UIStepper) {
        guestFouls = Int(sender.value)
        guestFoulsCountLabel.text = "\(guestFouls)"
    }
    
    @IBAction func guestTOLCountStepper(_ sender: UIStepper) {
        guestTOL = Int(sender.value)
        guestTOLCountLabel.text = "\(guestTOL)"
    }
    
}
    

