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
class SFShowAnswerViewController: UIViewController{
    @IBOutlet weak var answerPickView: UIPickerView!
    @IBOutlet weak var questionNameLabel: UILabel!
    @IBOutlet weak var sinPowerNumberLabel: UILabel!
    @IBOutlet weak var sinPowerBarImageView: UIImageView!
    @IBOutlet weak var barHeightConstraint: NSLayoutConstraint!
    lazy var viewModel:SFShowAnswerViewModel! = {
        return SFShowAnswerViewModel()
    }()
    var name:String?
    //按下讚嘆師父按鈕
    @IBAction func thankSeaFood(_ sender: UIButton) {
        self.viewModel.downSinPowerBarAndSinCounter()
    }
    //按下問問題按鈕
    @IBAction func askQuestionAgain(_ sender: UIButton) {
        if self.viewModel.sinPowerCounter < 87 { spinAnswers() }
        self.viewModel.upSinPowerBarAndSinCounter()
        switch self.viewModel.sinPowerCounter {
        case 50:
            self.pressentAlertController(alertTitle: "警告", alertMessage: "提醒施主，業力值已經50%了喔\n請讚嘆師父來消除業力，感恩", yesActionTitle: "好喔", yesActionHandler: nil,noActionTitle: nil,noActionHandler: nil)
        case 87:
            let yesHandler:(UIAlertAction)->() = { _ in
                self.openUrlInSafari(url:"https://www.facebook.com/SeaFoodCanIAskYou/")
            }
            self.pressentAlertController(alertTitle: "業力引爆！", alertMessage: "提醒施主，業力值已到了87%了喔\n不能再高了，請去敢問師父粉絲團按讚表達你的懺悔", yesActionTitle: "好喔", yesActionHandler: yesHandler, noActionTitle: nil, noActionHandler: nil)
        default:
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionNameLabel.text = name
        self.initViewModel()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //讀取sinPower資料
        if self.viewModel.sinPowerCounter < 87 { self.spinAnswers() }
        //動畫顯示在畫面上
        self.sinPowerNumberLabel.text = String(self.viewModel.sinPowerCounter)
    }
    
    fileprivate func initViewModel(){
        self.viewModel.reloadSinPowerView = {
            self.sinPowerNumberLabel.text = String(self.viewModel.sinPowerCounter)
            self.barHeightConstraint.constant = self.viewModel.sinPowerHeight
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    fileprivate func spinAnswers(){
        var animationRepeatTimes = 0
        let answerCount = UInt32(self.viewModel.ansQuestion!.count)
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
}

extension SFShowAnswerViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.ansQuestion!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModel.ansQuestion![row].answer
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let label = view as? UILabel{
            return label
        }
        let pickerLabel = UILabel()
        let titleString = self.viewModel.ansQuestion![row].answer
        let myTitle = NSAttributedString(string: titleString, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 25.0)!,NSForegroundColorAttributeName:UIColor.white])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
}

extension SFShowAnswerViewController{
    func openUrlInSafari(url:String){
        if let urlOfSafari = URL(string:url){
            UIApplication.shared.open(urlOfSafari, options: [:], completionHandler: nil)
        }
    }
    
    func pressentAlertController(alertTitle:String?,alertMessage:String?,yesActionTitle:String?,yesActionHandler:((UIAlertAction)->Void)?,noActionTitle:String?,noActionHandler:((UIAlertAction)->Void)?){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        if let yesTitle = yesActionTitle {
            let yesAction = UIAlertAction(title: yesTitle, style: UIAlertActionStyle.default, handler: yesActionHandler)
            alert.addAction(yesAction)
        }
        if let noTitle = noActionTitle {
            let noAction = UIAlertAction(title: noTitle, style: UIAlertActionStyle.cancel, handler: noActionHandler)
            alert.addAction(noAction)
        }
        present(alert, animated: true, completion: nil)
    }
}
