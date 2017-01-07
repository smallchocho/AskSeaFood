//
//  EditQuestion.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/25.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
class EditQuestion: UIViewController{
    //生成題目跟答案的實體
    var questionArray:[QuestionAndAnswer] = []
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
                let tempArray = QuestionAndAnswer(question: text, answer: [String]())
                //然後存入questionArray
                self.questionArray.append(tempArray)
                //把上面修改過的資料存入UserDefault
                saveData(savedData: self.questionArray)
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
            //就新增一個QuestionAndAnswer物件到questionArray裡面
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


//UITableView相關的delegate
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
    //每個row右側的驚嘆號標示
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //產生一個輸入新問題的提示頁
        addAlertController(title: self.questionArray[indexPath.row].question) { (bool:Bool, textInTexfield:String?) in
            if bool == true{
                guard let text = textInTexfield  else{
                    print("textInTexfield is nil")
                    return
                }
                //因為只是修改questionArray的question標題,所以只要修改標題文字
                self.questionArray[indexPath.row].question = text
                saveData(savedData: self.questionArray)
                self.editQuestionTableView.reloadData()
            }
        }
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
