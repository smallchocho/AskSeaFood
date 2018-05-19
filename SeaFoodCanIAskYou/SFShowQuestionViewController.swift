//
//  UIViewControllerByProgaming.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2017/2/5.
//  Copyright © 2017年 Justin Huang. All rights reserved.
//

import UIKit
import RealmSwift
class SFShowQuestionViewController: UIViewController{
//    var questionAndAnswer:Results<SFQuestionAndAnswerDatabase>!
    let questionPickView = UIPickerView()
    lazy var viewModel:SFShowQuestionViewModel = {
        return SFShowQuestionViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        createUi()
        initViewModel()
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
    
    func initViewModel(){
        self.viewModel.reloadTableVIew = {
            [weak self] _ in
            self?.questionPickView.reloadAllComponents()
        }
    }
    
    //UI相關
    func createUi(){
        //新增NavigationBarTitle
        self.navigationItem.title = "敢問師父"
        //底色
        self.view.backgroundColor = UIColor(displayP3Red: 94/255, green:  26/255, blue: 132/255, alpha: 1.0)
        //師父的圖片
        let seaFoodImage = UIImageView()
        seaFoodImage.image = UIImage(named: "饞")
        seaFoodImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(seaFoodImage)
        //AutoLayout-position
        seaFoodImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0.0).isActive = true
        seaFoodImage.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
        //AutoLayout-Size
        seaFoodImage.widthAnchor.constraint(equalTo: seaFoodImage.heightAnchor, multiplier: 1.0, constant: 0.0).isActive = true
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
        guard let vc = UIStoryboard(name: SFShowAnswerViewController.className(), bundle: nil).instantiateInitialViewController() as? SFShowAnswerViewController else{ return }
        let indexPath = questionPickView.selectedRow(inComponent: 0)
        vc.name = self.viewModel.questionAndAnswer[indexPath].question
        vc.ansQuestion = addStringArray(array: self.viewModel.questionAndAnswer[indexPath].answers)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func goToEditQuestion() {
        guard let vc = UIStoryboard(name: SFEditQuestionViewController.className(), bundle: nil).instantiateInitialViewController() as? SFEditQuestionViewController else{ return }
        vc.questionAndAnswer = viewModel.questionAndAnswer
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //增加array解答數量
    func addStringArray(array:List<Answer>) -> List<Answer>{
        let addAnswer = List<Answer>()
        for _ in 0...10{
            addAnswer.append(objectsIn: array)
        }
        return addAnswer
    }

}


//pickViewDelegate&pickViewDatabase相關
extension SFShowQuestionViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.questionAndAnswer.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.questionAndAnswer[row].question
    }
    //修改pickerView當中的picker本身的相關設定
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let label = view as? UILabel{
            return label
        }
        let pickerLabel = UILabel()
        let titleString = viewModel.questionAndAnswer[row].question
        let myTitle = NSAttributedString(string: titleString, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 25.0)!,NSForegroundColorAttributeName:UIColor.white])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .center
        return pickerLabel
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

