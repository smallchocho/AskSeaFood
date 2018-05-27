//
//  EditAnswer.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/28.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import RealmSwift
class SFEditAnswerViewController: SFBaseViewController {
    var aSelectedQuestion = "沒有問題"
    var questionAndAnswer:Results<SFQuestionAndAnswerDatabase>!
    var indexPathOfSelectedQuestion:IndexPath!
    @IBAction func askAnswer(_ sender: UIBarButtonItem) {
        let yesCompletion:((String?)->())? = {
            (textInTexfield:String?) in
            guard let text = textInTexfield else{
                print("textInTextField is nil")
                return
            }
            //把新的答案存入questionAndAnswer
            SFRealmManager.writeData {
                let answer = Answer(value: [text])
                self.questionAndAnswer[self.indexPathOfSelectedQuestion.row].answers.append(answer)
            }
            //重整這個頁面的資料
            self.editAnswerTableView.reloadData()
        }
        self.presentTextFieldAlertController(title: "請輸入新問題", message: nil, textInFieldText: nil, placeHolder: "請輸入文字", yesTitle: "確定", noTitle: "取消", yesCompletion: yesCompletion, noCompletion: nil)
    }
    @IBOutlet weak var editAnswerTableView: UITableView!
    @IBOutlet weak var selectedQuestion: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //表題
        selectedQuestion.title = aSelectedQuestion
        editAnswerTableView.dataSource = self
        editAnswerTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //更新TableView的資料
        self.editAnswerTableView.reloadData()
        //        print("\n\n\n\n現在的答案數量\(queAndAnsArray[questionIndexPath.row].answer.count)")
    }
}

extension SFEditAnswerViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionAndAnswer[self.indexPathOfSelectedQuestion.row].answers.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = editAnswerTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = questionAndAnswer[self.indexPathOfSelectedQuestion.row].answers[indexPath.row].answer
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let textInFieldText = self.questionAndAnswer[self.indexPathOfSelectedQuestion.row].answers[indexPath.row].answer
        let yesCompletion:((String?)->())? = {
            (textInTexfield:String?) in
            guard let text = textInTexfield else{
                print("textInTextField is nil")
                return
            }
            SFRealmManager.writeData{
                self.questionAndAnswer[self.indexPathOfSelectedQuestion.row].answers[indexPath.row].answer = text
            }
            //重整這個頁面的資料
            self.editAnswerTableView.reloadData()
        }
        self.presentTextFieldAlertController(title: "請修改問題", message: nil, textInFieldText: textInFieldText, placeHolder: nil, yesTitle: "確定", noTitle: "取消", yesCompletion: yesCompletion, noCompletion: nil)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //刪除指定的答案
        let deletedAnswer = self.questionAndAnswer[self.indexPathOfSelectedQuestion.row].answers[indexPath.row]
        SFRealmManager.deleteData(deletedAnswer)
        //重整這個頁面的資料
        self.editAnswerTableView.reloadData()
    }
}





