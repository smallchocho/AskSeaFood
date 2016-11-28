//
//  ShowAnswerViewController.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/19.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import Foundation
class ShowAnswerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    @IBOutlet weak var answerPickView: UIPickerView!
    
    @IBOutlet weak var questionName: UILabel!
    var name:String?
    var ansQuestion:[String]?
    //按下問問題按鈕
    @IBAction func askQuestionAgain(_ sender: UIButton) {
        c()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionName.text = name
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.answerPickView.reloadAllComponents()
    }
    override func viewDidAppear(_ animated: Bool) {
        c()
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
        return ansQuestion![row]
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
        let titleData = ansQuestion![row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 25.0)!,NSForegroundColorAttributeName:UIColor.white])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .center
        return pickerLabel!
    }
    func c(){
        var animationRepeatTime = 0
        let answerCount = UInt32(ansQuestion!.count)
        let randomNum = arc4random_uniform(answerCount/2) + (answerCount/2)
        self.answerPickView.selectRow(0, inComponent: 0, animated: false)
        self.answerPickView.selectRow(Int(randomNum), inComponent: 0, animated: true)
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {(timer:Timer) in
            self.answerPickView.selectRow(0, inComponent: 0, animated: false)
            self.answerPickView.selectRow(Int(randomNum), inComponent: 0, animated: true)
            animationRepeatTime += 1
            if animationRepeatTime > 5 {
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
