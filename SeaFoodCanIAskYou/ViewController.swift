//
//  ViewController.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/15.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import RealmSwift
class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    var answer1 = Answer(value:["Yes"])
    var answer2 = Answer(value:["No"])
    var question1:Results<QuestionAndAnswerDatabase>!
//    var question1 = QuestionAndAnswerDatabase(value:
//        ["id":"0","question":"Yes or No","answers":[answer1,answer2]])
    var answer3 = Answer(value:["現在不衝更待何時？"])
    var answer4 = Answer(value:["別去，砲灰"])
    var questionAndAnswer:[QuestionAndAnswer] = [
        QuestionAndAnswer(question:"假日哪邊的黃線可以停車？", answer:["你看不到我你看不到我","你看不到我你看不到我"]),
        QuestionAndAnswer(question:"Yes or No", answer:["Yes","No"]),
        QuestionAndAnswer(question: "我該告白嗎？", answer:["現在不衝更待何時","別去，砲灰"]),
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
//        if questionAndAnswer[rowNumber].question == "假日哪邊的黃線可以停車？"{
//            performSegue(withIdentifier: "GoToYellowLine", sender: nil)
//        }
//        else{
            performSegue(withIdentifier: "goShowAnswerViewController", sender: nil)
//        }
    }
    @IBOutlet weak var askPickView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(uiRealm.configuration.fileURL as Any)
            try! uiRealm.write {
//                let date = Date()
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "YYYY/MM/DD/HH:mm:ss:SSS"
//                let dateString = dateFormatter.string(from: date)
                question1 = uiRealm.objects(QuestionAndAnswerDatabase.self)
                if uiRealm.objects(QuestionAndAnswerDatabase.self).first == nil{
                uiRealm.create(QuestionAndAnswerDatabase.self, value:
                    ["0","Yes or No",
                     [Answer(value:["Yes"]),
                      Answer(value:["No"])]
                    ], update: true)
                uiRealm.create(QuestionAndAnswerDatabase.self, value:
                    ["1","我該告白嗎？",
                     [Answer(value:["現在不衝更待何時？"]),
                      Answer(value:["別去，砲灰"])]
                    ], update: true)
                uiRealm.create(QuestionAndAnswerDatabase.self, value:
                    ["2","中午吃什麼？",
                     [Answer(value:["霸王豬腳"]),
                      Answer(value:["自助餐"]),
                      Answer(value:["金仙蝦捲"]),
                      Answer(value:["雞肉飯"])]
                    ], update: true)
                uiRealm.create(QuestionAndAnswerDatabase.self, value:
                    ["3","師父愛吃什麼？",
                     [Answer(value:["Seafood"]),
                      Answer(value:["應該是Seafood"]),
                      Answer(value:["那就Seafood吧"]),
                      Answer(value:["總之就是Seafood"])]
                    ], update: true)
                }
            }
        question1 = uiRealm.objects(QuestionAndAnswerDatabase.self)
        //可延遲啟動畫面消失的時間
        Thread.sleep(forTimeInterval: 1.4)
    }
    override func viewWillAppear(_ animated: Bool) {
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
        return question1.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return question1[row].question
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
        let myTitle = NSAttributedString(string: question1[row].question, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 25.0)!,NSForegroundColorAttributeName:UIColor.white])
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
    func addStringArray(array:List<Answer>) -> List<Answer>{
        let addAnswer = List<Answer>()
        for _ in 0...10{
            addAnswer.append(objectsIn: array)
        }
        return addAnswer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goShowAnswerViewController"{
            let indexPath = askPickView.selectedRow(inComponent: 0)
            let destination = segue.destination as! ShowAnswerViewController
            destination.name = question1[indexPath].question
            destination.ansQuestion = addStringArray(array: question1[indexPath].answers)
        }
        if segue.identifier == "c"{
            if let destination = segue.destination as? EditQuestion{
                destination.questionArray = questionAndAnswer
            }
        }
    }
}

