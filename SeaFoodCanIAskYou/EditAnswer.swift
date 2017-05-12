//
//  EditAnswer.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/28.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import RealmSwift
class EditAnswer: UIViewController {
    var aSelectedQuestion = "沒有問題"
    var questionAndAnswer:Results<QuestionAndAnswerDatabase>!
    var indexPathOfSelectedQuestion:IndexPath!
    @IBAction func askAnswer(_ sender: UIBarButtonItem) {
        //產生一個輸入新答案的提示頁
        addAlertController(title: nil) {
            (bool:Bool,textInTextField:String?) in
            if bool == true{
                guard let text = textInTextField else{
                    print("textInTextField is nil")
                    return
                }
                //把新的答案存入questionAndAnswer
                try! uiRealm.write {
                    let answer = Answer(value: [text])
                    self.questionAndAnswer[self.indexPathOfSelectedQuestion.row].answers.append(answer)
                }
                //重整這個頁面的資料
                self.editAnswerTableView.reloadData()
            }
        }
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension EditAnswer:UITableViewDelegate,UITableViewDataSource{
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
        //產生一個輸入新答案的提示頁
        addAlertController(title: questionAndAnswer[self.indexPathOfSelectedQuestion.row].answers[indexPath.row].answer){
            (bool:Bool, textInTextField:String?) in
            if bool == true{
                guard let text = textInTextField else{
                    print("textInTextField is nil")
                    return
                }
                //把修改後的答案存進queAndAnsArray
                try! uiRealm.write {
                    self.questionAndAnswer[self.indexPathOfSelectedQuestion.row].answers[indexPath.row].answer = text
                }
                //重整這個頁面的資料
                self.editAnswerTableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //刪除指定的答案
        try! uiRealm.write {
            let deletedAnswer = self.questionAndAnswer[self.indexPathOfSelectedQuestion.row].answers[indexPath.row]
            uiRealm.delete(deletedAnswer)
        }
        //重整這個頁面的資料
        self.editAnswerTableView.reloadData()
    }
}
//刪除或修改Answer的func
extension EditAnswer{
    //1.生成一個AlertController(帶1個textField跟2個button)。2.判斷輸入的title是不是nil。3.依照2的結果回傳一個。
    func addAlertController(title:String?,completion:@escaping (Bool,String?)->()){
        //產生一個輸入新問題的提示頁
        let newAnswerAlert = UIAlertController(title: "請輸入新選項", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        newAnswerAlert.addTextField {(textField:UITextField) in
            textField.placeholder = "請輸入文字"
        }
        if title != nil{
            newAnswerAlert.title = "請修改選項"
            newAnswerAlert.textFields?.first?.placeholder = nil
            newAnswerAlert.textFields?.first?.text = title
        }
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){
            //如果newQuestionAlert.textFields?[0].text有值且不是空字串，
            //就新增一個QuestionAndAnswer物件到queAndAnsArray裡面
            (action:UIAlertAction) in
            let textInTexfield = newAnswerAlert.textFields?.first?.text
            if textInTexfield != nil && textInTexfield != ""{
                completion(true,textInTexfield)
            }else{
                completion(false,nil)
            }
        }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
        newAnswerAlert.addAction(okAction)
        newAnswerAlert.addAction(cancelAction)
        self.present(newAnswerAlert, animated: true, completion: nil)
    }
}




