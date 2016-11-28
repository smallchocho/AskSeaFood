//
//  EditQuestion.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/25.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit

class EditQuestion: UIViewController{
    @IBAction func addNewQuestion(_ sender: UIBarButtonItem) {
        //產生一個輸入新問題的提示頁
        let newQuestionAlert = UIAlertController(title: "請輸入新問題", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        newQuestionAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "請輸入文字"
        }
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){
            //如果newQuestionAlert.textFields?[0].text有值且不是空字串，
            //就新增一個QuestionAndAnswer物件到questionArray裡面
            (action:UIAlertAction) in
            if let inputText = newQuestionAlert.textFields?[0].text{
                if inputText != "" {
                    //因為這是新增一個新的問題＆答案，
                    //所以要新增一個新的QuestionAndAnswer物件，答案的值給一個[String]()
                    let tempArray = QuestionAndAnswer(question: inputText, answer: [String]())
                    //然後存入questionArray
                    self.questionArray.append(tempArray)
                    //把上面修改過的資料存入UserDefault
                    saveData(savedData: self.questionArray)
                    self.editQuestionTableView.reloadData()
                }
            }
        }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
        newQuestionAlert.addAction(okAction)
        newQuestionAlert.addAction(cancelAction)
        present(newQuestionAlert, animated: true, completion: nil)
        
        
    }
    @IBOutlet weak var editQuestionTableView: UITableView!
    
    var questionArray:[QuestionAndAnswer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.editQuestionTableView.delegate = self
        self.editQuestionTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //如果發現有存擋就讀檔
        if loadData() != [QuestionAndAnswer](){
            questionArray = loadData()
        }
        //然後更新TableView的資料
        self.editQuestionTableView.reloadData()
        //        print("\n\n\n\n現在的題目數量\(questionArray.count)")
        //        print("\n\n\n\n第四題的答案數量\(questionArray[3].answer.count)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToEditAnswer"{
            if let destination = segue.destination as? EditAnswer{
                if let indexPath = editQuestionTableView.indexPathForSelectedRow{
                    destination.queAndAnsArray = questionArray
                    destination.aSelectedQuestion = questionArray[indexPath.row].question
                    destination.questionIndexPath = indexPath
                }
            }
        }
    }
}
extension EditQuestion:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = questionArray.count
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = editQuestionTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = questionArray[indexPath.row].question
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //產生一個輸入新問題的提示頁
        let newQuestionAlert = UIAlertController(title: "請修改問題", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        newQuestionAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "請輸入文字"
            textField.text = self.questionArray[indexPath.row].question
        }
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){
            //如果newQuestionAlert.textFields?[0].text有值且不是空字串，
            //就修改questionArray的內容
            (action:UIAlertAction) in
            if let inputText = newQuestionAlert.textFields?[0].text{
                if inputText != "" {
                    //因為只是修改questionArray的question標題,所以只要修改標題文字
                    self.questionArray[indexPath.row].question = inputText
                    //把上面修改過的資料存入UserDefault
                    saveData(savedData: self.questionArray)
                    self.editQuestionTableView.reloadData()
                }
            }
        }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
        newQuestionAlert.addAction(okAction)
        newQuestionAlert.addAction(cancelAction)
        present(newQuestionAlert, animated: true, completion: nil)
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //刪除指定的題目組(連答案一起被刪除了)
        questionArray.remove(at: indexPath.row)
        //把上面修改過的資料存入UserDefault
        saveData(savedData: questionArray)
        //重整這個頁面的資料
        self.editQuestionTableView.reloadData()
        
    }
}
