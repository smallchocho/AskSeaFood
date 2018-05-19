//
//  ShowAnswerViewController.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/19.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
class SFShowAnswerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    @IBOutlet weak var answerPickView: UIPickerView!
    @IBOutlet weak var questionName: UILabel!
    @IBOutlet weak var sinPowerNumber: UILabel!
    @IBOutlet weak var sinPowerBar: UIImageView!
    @IBOutlet weak var barHeightConstraint: NSLayoutConstraint!
    
    var name:String?
    var sinPowerHeight:Float = 1
    var sinPowerCounter = 0
    var ansQuestion:List<Answer>!
    //按下讚嘆師父按鈕
    @IBAction func thankSeaFood(_ sender: UIButton) {
        downSinPowerBarAndSinCounter()
    }
    //按下問問題按鈕
    @IBAction func askQuestionAgain(_ sender: UIButton) {
        if sinPowerCounter < 87{
            spinAnswers()
        }
        upSinPowerBarAndSinCounter()
        switch sinPowerCounter {
        case 50:
            pressentAlertController(alertTitle: "警告", alertMessage: "提醒施主，業力值已經50%了喔\n請讚嘆師父來消除業力，感恩", actionTitle: "好喔", actionHandler: nil)
        case 87:
            pressentAlertController(alertTitle: "業力引爆！", alertMessage: "提醒施主，業力值已到了87%了喔\n不能再高了，請去敢問師父粉絲團按讚表達你的懺悔", actionTitle: "好喔", actionHandler: { (action) in
                self.openUrlInSafari(url:"https://www.facebook.com/SeaFoodCanIAskYou/")
            })
        default:
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        questionName.text = name
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.answerPickView.reloadAllComponents()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //讀取sinPower資料
        loadSinPowerInfo()
        if sinPowerCounter < 87{
            spinAnswers()
        }
        //動畫顯示在畫面上
        self.sinPowerNumber.text = String(self.sinPowerCounter)
        self.barHeightConstraint.constant = CGFloat(sinPowerHeight)
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        sinPowerHeight = Float(self.barHeightConstraint.constant)
        saveSinPowerInfo()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ansQuestion!.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ansQuestion![row].answer
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil {
            //if no label there yet
            pickerLabel = UILabel()
            //color the label's background
            //            let hue = CGFloat(row)/CGFloat(askQuestion.count)
            //            pickerLabel?.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        let titleData = ansQuestion![row].answer
        //這啥？
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 25.0)!,NSForegroundColorAttributeName:UIColor.white])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .center
        return pickerLabel!
    }
    
    func spinAnswers(){
        var animationRepeatTimes = 0
        let answerCount = UInt32(ansQuestion!.count)
        let randomNum = arc4random_uniform(answerCount/2) + (answerCount/2)
        self.answerPickView.selectRow(0, inComponent: 0, animated: false)
        self.answerPickView.selectRow(Int(randomNum), inComponent: 0, animated: true)
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {(timer:Timer) in
            self.answerPickView.selectRow(0, inComponent: 0, animated: false)
            self.answerPickView.selectRow(Int(randomNum), inComponent: 0, animated: true)
            animationRepeatTimes += 1
            if animationRepeatTimes > 5 {
                timer.invalidate()
            }
        })
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
//擴充方法
extension SFShowAnswerViewController{
    func openUrlInSafari(url:String){
        if let urlOfSafari = URL(string:url){
            UIApplication.shared.open(urlOfSafari, options: [:], completionHandler: nil)
        }
    }
    func saveSinPowerInfo(){
        UserDefaults.standard.set(sinPowerHeight, forKey: "sinPowerHeight")
        UserDefaults.standard.set(sinPowerCounter, forKey: "sinPowerCounter")
        UserDefaults.standard.synchronize()
    }
    func loadSinPowerInfo(){
        if UserDefaults.standard.float(forKey: "sinPowerHeight") != 0{
            sinPowerHeight = UserDefaults.standard.float(forKey: "sinPowerHeight")
        }
        if UserDefaults.standard.integer(forKey: "sinPowerCounter") != 0{
            sinPowerCounter = UserDefaults.standard.integer(forKey: "sinPowerCounter")
        }
    }
    func pressentAlertController(alertTitle:String?,alertMessage:String?,actionTitle:String?,actionHandler:((UIAlertAction)->Void)?){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.cancel, handler: actionHandler)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func upSinPowerBarAndSinCounter(){
        if sinPowerCounter < 80{
            sinPowerCounter += 10
        }else if sinPowerCounter < 87 && sinPowerCounter >= 80{
            sinPowerCounter += 7
        }
        self.sinPowerNumber.text = String(self.sinPowerCounter)
        if self.barHeightConstraint.constant < self.view.frame.height * 0.324{
            self.barHeightConstraint.constant += self.view.frame.height * 0.036
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    func downSinPowerBarAndSinCounter(){
        if sinPowerCounter <= 80 && sinPowerCounter > 0 {
            sinPowerCounter -= 10
        }else if sinPowerCounter > 0{
            self.sinPowerCounter -= 7
        }
        self.sinPowerNumber.text = String(self.sinPowerCounter)
        if self.barHeightConstraint.constant >= self.view.frame.height * 0.036{
            self.barHeightConstraint.constant -= self.view.frame.height * 0.036
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
