//
//  EditQuestion.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/25.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
import RealmSwift
class EditQuestion: UIViewController{
    //生成題目跟答案的實體
    var questionAndAnswer:Results<QuestionAndAnswerDatabase>!
    @IBOutlet weak var editQuestionTableView: UITableView!
    //右上角+號按鈕
    @IBAction func addNewQuestion(_ sender: UIBarButtonItem) {
        addAlertController(title: nil) { (bool:Bool, textInTexfield:String?) in
            if bool == true{
                //因為這是新增一個新的問題＆答案，
                //所以要新增一個新的QuestionAndAnswer物件，答案的值則先賦值一個空字串的Array
                guard let text = textInTexfield  else{
                    print("textInTextfield is nil")
                    return
                }
                //用現在的時間當成key，新增一個新的question，Answers不填入
                try! uiRealm.write {
                    let date = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "YYYY/MM/DD/HH:mm:ss:SSS"
                    let dateString = dateFormatter.string(from: date)
                    uiRealm.create(QuestionAndAnswerDatabase.self, value: [dateString,text,[]], update: true)
                }
                self.editQuestionTableView.reloadData()
            }
        }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToEditAnswer"{
            if let destination = segue.destination as? EditAnswer{
                if let indexPath = editQuestionTableView.indexPathForSelectedRow{
                    destination.questionAndAnswer = questionAndAnswer
                    destination.aSelectedQuestion = questionAndAnswer[indexPath.row].question
                    destination.indexPathOfSelectedQuestion = indexPath
                }
            }
        }
    }
}
//UITableView相關的delegate
extension EditQuestion:UITableViewDelegate,UITableViewDataSource{
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
    //每個row右側的驚嘆號標示
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //產生一個修改問題文字的提示頁
        addAlertController(title: self.questionAndAnswer[indexPath.row].question) { (bool:Bool, textInTexfield:String?) in
            if bool == true{
                guard let text = textInTexfield  else{
                    print("textInTexfield is nil")
                    return
                }
                //因為只是修改questionArray的question標題,所以只要修改標題文字
                try! uiRealm.write {
                    self.questionAndAnswer[indexPath.row].question = text
                }
                self.editQuestionTableView.reloadData()
            }
        }
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
//刪除或修改Question的func
extension EditQuestion{
    //1.生成一個AlertController(帶1個textField跟2個button)。2.判斷輸入的title是不是nil。3.依照2的結果回傳一個。
    func addAlertController(title:String?,completion:@escaping (Bool,String?)->()){
        //產生一個輸入新問題的提示頁
        let newQuestionAlert = UIAlertController(title: "請輸入新問題", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        newQuestionAlert.addTextField {(textField:UITextField) in
            textField.placeholder = "請輸入文字"
        }
        if title != nil{
            newQuestionAlert.title = "請修改問題"
            newQuestionAlert.textFields?.first?.placeholder = nil
            newQuestionAlert.textFields?.first?.text = title
        }
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){
            //如果newQuestionAlert.textFields?[0].text有值且不是空字串，
            //就新增一個QuestionAndAnswer物件到database裡面
            (action:UIAlertAction) in
            let textInTexfield = newQuestionAlert.textFields?.first?.text
            if textInTexfield != nil && textInTexfield != ""{
                completion(true,textInTexfield)
            }else{
                completion(false,nil)
            }
        }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil)
        newQuestionAlert.addAction(okAction)
        newQuestionAlert.addAction(cancelAction)
        self.present(newQuestionAlert, animated: true, completion: nil)
    }
}
