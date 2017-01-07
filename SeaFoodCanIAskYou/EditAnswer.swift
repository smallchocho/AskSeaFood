//
//  EditAnswer.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/28.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit
class EditAnswer: UIViewController {
    var aSelectedQuestion = "沒有問題"
    var queAndAnsArray:[QuestionAndAnswer] = []
    var questionIndexPath:IndexPath!
    @IBAction func askAnswer(_ sender: UIBarButtonItem) {
        //產生一個輸入新答案的提示頁
        addAlertController(title: nil) {
            (bool:Bool,textInTextField:String?) in
            if bool == true{
                guard let text = textInTextField else{
                    print("textInTextField is nil")
                    return
                }
                //把新的答案存入queAndAnsArray
                self.queAndAnsArray[self.questionIndexPath.row].answer.append(text)
                //把上面修改過的資料存入UserDefault
                saveData(savedData: self.queAndAnsArray)
                //重整這個頁面的資料
                self.editAnswerTableView.reloadData()
            }
        }
    }
    @IBOutlet weak var editAnswerTableView: UITableView!
    @IBOutlet weak var selectedQuestion: UINavigationItem!
    
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



//刪除或修改Answer的func
extension EditAnswer{
    //1.生成一個AlertController(帶1個textField跟2個button)。2.判斷輸入的title是不是nil。3.依照2的結果回傳一個。
    func addAlertController(title:String?,completion:@escaping (Bool,String?)->()){
        //產生一個輸入新問題的提示頁
        let newAnswerAlert = UIAlertController(title: "請輸入新問題", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        newAnswerAlert.addTextField {(textField:UITextField) in
            textField.placeholder = "請輸入文字"
        }
        if title != nil{
            newAnswerAlert.title = "請修改問題"
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
        addAlertController(title: queAndAnsArray[questionIndexPath.row].answer[indexPath.row]){
            (bool:Bool, textInTextField:String?) in
            if bool == true{
                guard let text = textInTextField else{
                    print("textInTextField is nil")
                    return
                }
                //把修改後的答案存進queAndAnsArray
                self.queAndAnsArray[self.questionIndexPath.row].answer[indexPath.row] = text
                //把上面修改過的資料存入UserDefault
                saveData(savedData:self.queAndAnsArray)
                //重整這個頁面的資料
                self.editAnswerTableView.reloadData()
            }
        }
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
