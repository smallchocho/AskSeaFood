//
//  EditAnswer.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/28.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
class EditAnswer: UIViewController {
    @IBAction func askAnswer(_ sender: UIBarButtonItem) {
        //產生一個輸入新答案的提示頁
        let newQuestionAlert = UIAlertController(title: "請輸入答案", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        newQuestionAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "請輸入文字"
        }
        //按下OK按鈕後執行closure的內容
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){
            (action:UIAlertAction) in
            //檢查newQuestionAlert.textFields?[0].text不是nil後存入inputText
            if let inputText = newQuestionAlert.textFields?[0].text{
                //在檢查inputText是不是空字串
                if inputText != "" {
                    //把inputText存入中self.queAndAnsArray[self.questionIndexPath.row].answer中
                    self.queAndAnsArray[self.questionIndexPath.row].answer.append(inputText)
                    //把上面修改過的資料存入UserDefault
                    saveData(savedData: self.queAndAnsArray)
                    //重整這個頁面的資料
                    self.editAnswerTableView.reloadData()
                }
            }
        }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
        newQuestionAlert.addAction(okAction)
        newQuestionAlert.addAction(cancelAction)
        present(newQuestionAlert, animated: true, completion: nil)
    }
    @IBOutlet weak var editAnswerTableView: UITableView!
    @IBOutlet weak var selectedQuestion: UINavigationItem!
    var aSelectedQuestion = "沒有問題"
    var queAndAnsArray:[QuestionAndAnswer] = []
    var questionIndexPath:IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedQuestion.title = aSelectedQuestion
        editAnswerTableView.dataSource = self
        editAnswerTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //如果發現有存擋就讀檔
        if loadData() != [QuestionAndAnswer](){
            queAndAnsArray = loadData()
        }
        //然後更新TableView的資料
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
        return queAndAnsArray[questionIndexPath.row].answer.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = editAnswerTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = queAndAnsArray[questionIndexPath.row].answer[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //產生一個輸入新答案的提示頁
        let newQuestionAlert = UIAlertController(title: "請修改答案", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        newQuestionAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "請輸入文字"
            textField.text = self.queAndAnsArray[self.questionIndexPath.row].answer[indexPath.row]
        }
        //按下OK按鈕後執行closure的內容
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){
            (action:UIAlertAction) in
            //檢查newQuestionAlert.textFields?[0].text不是nil後存入inputText
            if let inputText = newQuestionAlert.textFields?[0].text{
                //在檢查inputText是不是空字串
                if inputText != "" {
                    //把inputText存入
                    self.queAndAnsArray[self.questionIndexPath.row].answer[indexPath.row] = inputText
                    //把上面修改過的資料存入UserDefault
                    saveData(savedData: self.queAndAnsArray)
                    //重整這個頁面的資料
                    self.editAnswerTableView.reloadData()
                }
            }
        }
        //創cancel按鈕
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
        newQuestionAlert.addAction(okAction)
        newQuestionAlert.addAction(cancelAction)
        present(newQuestionAlert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //刪除指定的答案
        queAndAnsArray[questionIndexPath.row].answer.remove(at: indexPath.row)
        //儲存進UserDefault
        saveData(savedData: queAndAnsArray)
        //重整這個頁面的資料
        self.editAnswerTableView.reloadData()
    }
}
