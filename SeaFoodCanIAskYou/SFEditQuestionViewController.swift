//
//  EditQuestion.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/25.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import RealmSwift
class SFEditQuestionViewController: SFBaseViewController{
    //生成題目跟答案的實體
    var questionAndAnswer:Results<SFQuestionAndAnswerDatabase>!
    @IBOutlet weak var editQuestionTableView: UITableView!
    //右上角+號按鈕
    @IBAction func addNewQuestion(_ sender: UIBarButtonItem) {
        let yesCompletion:((String?)->())? = {
            (textInTexfield:String?) in
            guard let text = textInTexfield  else{
                print("textInTexfield is nil")
                return
            }
            //用現在的時間當成key，新增一個新的question，Answers不填入
            try! uiRealm.write {
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY/MM/DD/HH:mm:ss:SSS"
                let dateString = dateFormatter.string(from: date)
                uiRealm.create(SFQuestionAndAnswerDatabase.self, value: [dateString,text,[]], update: true)
            }
            self.editQuestionTableView.reloadData()
        }
        self.presentTextFieldAlertController(title: "請輸入新問題", message: nil, textInFieldText: nil, placeHolder: "請輸入文字", yesTitle: "確定", noTitle: "取消", yesCompletion: yesCompletion, noCompletion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.editQuestionTableView.delegate = self
        self.editQuestionTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //然後更新TableView的資料
        self.editQuestionTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//UITableView相關的delegate
extension SFEditQuestionViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionAndAnswer.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = editQuestionTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = questionAndAnswer[indexPath.row].question
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: SFEditAnswerViewController.className(), bundle: nil).instantiateInitialViewController() as? SFEditAnswerViewController else{ return }
        vc.questionAndAnswer = questionAndAnswer
        vc.aSelectedQuestion = questionAndAnswer[indexPath.row].question
        vc.indexPathOfSelectedQuestion = indexPath
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //每個row右側的驚嘆號標示
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let textInFieldText = self.questionAndAnswer[indexPath.row].question
        let yesCompletion:((String?)->())? = {
            [weak self] (textInTexfield:String?) in
            guard let text = textInTexfield  else{
                print("textInTexfield is nil")
                return
            }
            //因為只是修改questionArray的question標題,所以只要修改標題文字
            try! uiRealm.write {
                self?.questionAndAnswer[indexPath.row].question = text
            }
            self?.editQuestionTableView.reloadData()
        }
        self.presentTextFieldAlertController(title: "請修改問題", message: nil, textInFieldText: textInFieldText, placeHolder: nil, yesTitle: "確定", noTitle: "取消", yesCompletion: yesCompletion, noCompletion: nil)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //刪除指定的題目組(連答案一起被刪除了)
        try! uiRealm.write {
            uiRealm.delete(questionAndAnswer[indexPath.row].answers)
            uiRealm.delete(questionAndAnswer[indexPath.row])
        }
        //重整這個頁面的資料
        self.editQuestionTableView.reloadData()
    }
}

