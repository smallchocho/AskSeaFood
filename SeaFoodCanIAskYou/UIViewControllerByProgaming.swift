//
//  UIViewControllerByProgaming.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2017/2/5.
//  Copyright © 2017年 Justin Huang. All rights reserved.
//

import UIKit
import RealmSwift
class UIViewControllerByProgaming: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    var questionAndAnswer:Results<QuestionAndAnswerDatabase>!
    let questionPickView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        createUi()
        loadData()
        //延遲啟動畫面消失的時間
        Thread.sleep(forTimeInterval: 1.4)
    }
    override func viewWillAppear(_ animated: Bool) {
        questionPickView.reloadAllComponents()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //增加array解答數量的方法
    func addStringArray(array:List<Answer>) -> List<Answer>{
        let addAnswer = List<Answer>()
        for _ in 0...10{
            addAnswer.append(objectsIn: array)
        }
        return addAnswer
    }
    //傳值
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goShowAnswerViewController"{
            let indexPath = questionPickView.selectedRow(inComponent: 0)
            let destination = segue.destination as! ShowAnswerViewController
            destination.name = questionAndAnswer[indexPath].question
            destination.ansQuestion = addStringArray(array: questionAndAnswer[indexPath].answers)
        }
        if segue.identifier == "goEditQuestion"{
            if let destination = segue.destination as? EditQuestion{
                destination.questionAndAnswer = questionAndAnswer
            }
        }
    }
}
//RealM相關
extension UIViewControllerByProgaming{
    func loadData(){
        //讀取LacalDatabase
        try! uiRealm.write {
            questionAndAnswer = uiRealm.objects(QuestionAndAnswerDatabase.self)
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
        questionAndAnswer = uiRealm.objects(QuestionAndAnswerDatabase.self)
    }
}

//pickViewDelegate&pickViewDatabase相關
extension UIViewControllerByProgaming{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return questionAndAnswer.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return questionAndAnswer[row].question
    }
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
}

//UI相關
extension UIViewControllerByProgaming{
    func createUi(){
        //新增NavigationBarTitle
        self.navigationItem.title = "敢問師父"
        //底色
        self.view.backgroundColor = UIColor(colorLiteralRed: 0.29, green: 0.0, blue: 0.443, alpha: 1.0)
        //師父的圖片
        let seaFoodImage = UIImageView()
        seaFoodImage.image = UIImage(named: "師傅去背完成2")
        seaFoodImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(seaFoodImage)
        //AutoLayout-position
        seaFoodImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        seaFoodImage.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
        //AutoLayout-Size
        seaFoodImage.widthAnchor.constraint(equalTo: seaFoodImage.heightAnchor, multiplier: 1.35, constant: 0.0).isActive = true
        seaFoodImage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.36, constant: 0.0).isActive = true
        
        //師父我想問Label
        let askLabel = UILabel()
        askLabel.text = "師父我想問:"
        askLabel.font = UIFont.systemFont(ofSize: 38)
        askLabel.textColor = UIColor.white
        askLabel.textAlignment = .center
        askLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(askLabel)
        
        //AutoLayout-position
        askLabel.topAnchor.constraint(equalTo: seaFoodImage.bottomAnchor, constant: 5.0).isActive = true
        askLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        //AutoLayout-size
        askLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        
        //作出UiPickView
        
        self.view.addSubview(questionPickView)
        questionPickView.delegate = self
        questionPickView.dataSource = self
        questionPickView.frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: self.view.frame.width, height: view.frame.height * 0.25)
        questionPickView.translatesAutoresizingMaskIntoConstraints = false
        //AutoLayout-position
        questionPickView.topAnchor.constraint(equalTo: askLabel.bottomAnchor, constant: 20.0).isActive = true
        questionPickView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        //AutoLayout-size
        questionPickView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0, constant: 0.0).isActive = true
        questionPickView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25, constant: 0.0).isActive = true
        
        //作出"敢問師父"Button
        let goToSeaFoodAnswer = UIButton(type: UIButtonType.system)
        goToSeaFoodAnswer.setTitle("敢問師父", for: UIControlState.normal)
        goToSeaFoodAnswer.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        goToSeaFoodAnswer.titleLabel?.textAlignment = .center
        goToSeaFoodAnswer.setTitleColor(UIColor.white, for: UIControlState.normal)
        goToSeaFoodAnswer.backgroundColor = UIColor.purple
        goToSeaFoodAnswer.layer.cornerRadius = 20
        goToSeaFoodAnswer.addTarget(self, action: #selector(self.goToSeaFoodAnswer), for: UIControlEvents.touchUpInside)
        //AutoLayout-size
        
        
        
        //作出"整理思緒"Button
        let goToEditQuestion:UIButton! = UIButton(type: UIButtonType.system)
        goToEditQuestion.setTitle("整理思緒", for: UIControlState.normal)
        goToEditQuestion.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        goToEditQuestion.titleLabel?.textAlignment = .center
        goToEditQuestion.setTitleColor(UIColor.white, for: UIControlState.normal)
        goToEditQuestion.backgroundColor = UIColor.purple
        goToEditQuestion.layer.cornerRadius = 20
        goToEditQuestion.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(goToEditQuestion)
        goToEditQuestion.addTarget(self, action: #selector(self.goToEditQuestion), for: UIControlEvents.touchUpInside)
        
        
        //作出兩個Button的StackView
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(goToSeaFoodAnswer)
        stackView.addArrangedSubview(goToEditQuestion)
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        //AutoLayout-position
        stackView.topAnchor.constraint(equalTo: questionPickView.bottomAnchor, constant: 0.0).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerXAnchor).isActive = true
        //AutoLayout-size
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.0622).isActive = true

    }
    func goToSeaFoodAnswer() {
        performSegue(withIdentifier: "goShowAnswerViewController", sender: nil)
    }
    func goToEditQuestion() {
        performSegue(withIdentifier: "goEditQuestion", sender: nil)
    }
}
