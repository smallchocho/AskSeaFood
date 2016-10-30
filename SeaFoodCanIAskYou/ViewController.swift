//
//  ViewController.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/15.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    var questionAndAnswer:[QuestionAndAnswer] = [
        QuestionAndAnswer(question:"假日哪邊的黃線可以停車？", answer:["你看不到我你看不到我","你看不到我你看不到我"]),
        QuestionAndAnswer(question:"Yes or No", answer:["Yes","No"]),
        QuestionAndAnswer(question: "我該告白嗎？", answer: ["現在不衝更待何時","別去，砲灰"]),
        QuestionAndAnswer(question: "中午吃什麼？", answer: ["霸王豬腳","自助餐","金仙蝦捲","雞肉飯"]),
        QuestionAndAnswer(question: "師父愛吃什麼？", answer: ["Seafood","應該是Seafood","那就Seafood吧","總之就是Seafood"])
    ]
    @IBAction func goToEditQuestion(_ sender: UIButton) {
        performSegue(withIdentifier: "c", sender: nil)
    }
    
    //轉場到ShowAnswerViewController
    @IBAction func goToSeaFoodAnswer(_ sender: AnyObject) {
        //先取得目前選中的pickRow編號
        let rowNumber = askPickView.selectedRow(inComponent: 0)
        //利用pickRow編號取得目前選中的項目內容，如果符合條件就轉到黃線停車頁
        if questionAndAnswer[rowNumber].question == "假日哪邊的黃線可以停車？"{
            performSegue(withIdentifier: "GoToYellowLine", sender: nil)
        }
        else{
            performSegue(withIdentifier: "goShowAnswerViewController", sender: nil)
        }
    }
    @IBOutlet weak var askPickView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //如果loadData()不是一個空字串，也就是如果有存擋過的話，就把loadData()賦值給questionAndAnswer
        if loadData() != [QuestionAndAnswer](){
            questionAndAnswer = loadData()
        }
        //可延遲啟動畫面消失的時間
        Thread.sleep(forTimeInterval: 1.4)
    }
    override func viewWillAppear(_ animated: Bool) {
        //如果loadData()不是一個空字串，也就是如果有存擋過的話，就把loadData()賦值給questionAndAnswer
        if loadData() != [QuestionAndAnswer](){
            questionAndAnswer = loadData()
        }
        askPickView.reloadAllComponents()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return questionAndAnswer.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return questionAndAnswer[row].question
    }
    
    //修改pickerView當中的picker本身的相關設定
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        //設定picker是什麼ＵＩ型式
//        let pickerLabel = UILabel()
//        //把這個row所要顯示的字存進變數
//        let titleData = askQuestion[row]
//        //把上面的變數用NSAttributedString方法設定字型、字體大小、字體顏色
//        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 25.0)!,NSForegroundColorAttributeName:UIColor.white])
//        //把myTitle存入pickerLabel.attributedText中，完成關於字體的設定
//        pickerLabel.attributedText = myTitle
//        
//        //跟背景相關的顏色、位置等等的設定
//        //hue這邊猜測是利用將row跟askQuestion.count的比值之後轉成CGFloat
//        let hue = CGFloat(row)/CGFloat(askQuestion.count)
//        //然後在這邊設定backgroundColor的顏色設定
//        pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 1.0)
//        //最後指定label怎麼對齊
//        pickerLabel.textAlignment = .center
//        return pickerLabel
//    }
    //修改pickerView當中的picker本身的相關設定（較省記憶體的版本）
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil {
            //if no label there yet
            pickerLabel = UILabel()
            //color the label's background
//            let hue = CGFloat(row)/CGFloat(askQuestion.count)
//            pickerLabel?.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
//        let titleData = questionAndAnswer[row].question
        let myTitle = NSAttributedString(string: questionAndAnswer[row].question, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 25.0)!,NSForegroundColorAttributeName:UIColor.white])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .center
        return pickerLabel!
    }
    //調整pickerView的row的寬
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return 200
//    }
     //調整pickerView的row的高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    ////////增加array解答數量的方法
    func addStringArray(array:[String]) -> [String]{
        var addAnswer = array
        if addAnswer.count > 10{
            for _ in 0...5{
                addAnswer += array
            }
        }else if addAnswer.count <= 10 && addAnswer.count > 5{
            for _ in 0...9{
                addAnswer += array
            }
        }else{
            for _ in 0...20{
                addAnswer += array
            }
        }
        return addAnswer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goShowAnswerViewController"{
            let indexPath = askPickView.selectedRow(inComponent: 0)
            let destination = segue.destination as! ShowAnswerViewController
            destination.name = questionAndAnswer[indexPath].question
            destination.ansQuestion = addStringArray(array: questionAndAnswer[indexPath].answer)
        }
        if segue.identifier == "c"{
            if let destination = segue.destination as? EditQuestion{
                destination.questionArray = questionAndAnswer
            }
        }
        
    }
}

