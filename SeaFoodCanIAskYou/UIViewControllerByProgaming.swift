//
//  UIViewControllerByProgaming.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2017/2/5.
//  Copyright © 2017年 Justin Huang. All rights reserved.
//

import UIKit

class UIViewControllerByProgaming: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    var rowArray = ["1","2","3","4","5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        createUi()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension UIViewControllerByProgaming{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rowArray.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rowArray[row]
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
        let myTitle = NSAttributedString(string: rowArray[row], attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 25.0)!,NSForegroundColorAttributeName:UIColor.white])
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


extension UIViewControllerByProgaming{
    func createUi(){
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
        
        //作出"敢問師父"Button
        let goToSeaFoodAnswer = UIButton(type: UIButtonType.system)
        goToSeaFoodAnswer.setTitle("敢問師父", for: UIControlState.normal)
        goToSeaFoodAnswer.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        goToSeaFoodAnswer.titleLabel?.textAlignment = .center
        goToSeaFoodAnswer.setTitleColor(UIColor.white, for: UIControlState.normal)
        goToSeaFoodAnswer.backgroundColor = UIColor.purple
        goToSeaFoodAnswer.layer.cornerRadius = 20
        //AutoLayout-size
       
        
        //作出UiPickView
        let answerPickView = UIPickerView()
        self.view.addSubview(answerPickView)
        answerPickView.delegate = self
        answerPickView.dataSource = self
        answerPickView.frame = CGRect(x: self.view.center.x, y: self.view.center.y, width: self.view.frame.width, height: view.frame.height * 0.25)
        answerPickView.translatesAutoresizingMaskIntoConstraints = false
        //AutoLayout-position
        answerPickView.topAnchor.constraint(equalTo: askLabel.bottomAnchor, constant: 20.0).isActive = true
        answerPickView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        //AutoLayout-size
        answerPickView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0, constant: 0.0).isActive = true
        answerPickView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25, constant: 0.0).isActive = true
        
        
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
        goToEditQuestion.addTarget(self, action: #selector(self.printsomthing), for: UIControlEvents.touchUpInside)
        
        
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
        stackView.topAnchor.constraint(equalTo: answerPickView.bottomAnchor, constant: 0.0).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerXAnchor).isActive = true
        //AutoLayout-size
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.0622).isActive = true

    }
    func printsomthing(){
        print("yayayayya")
    }
}
