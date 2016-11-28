//
//  questionAndAnswer.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/20.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import Foundation
//為了使用UserDefault儲存資料，所以需繼承跟遵從以下類別跟協定
class QuestionAndAnswer:NSObject,NSCoding{
    var question = ""
    var answer = [String]()
    init(question q:String,answer a:[String]){
        self.question = q
        self.answer = a
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(question, forKey: "question")
        aCoder.encode(answer, forKey: "answer")
    }
    required init(coder aDecoder: NSCoder) {
        question = aDecoder.decodeObject(forKey: "question") as! String
        answer = aDecoder.decodeObject(forKey: "answer") as! [String]
    }
}



func saveData(savedData data:[QuestionAndAnswer]) {
    func archiveObject(archivedObject:[QuestionAndAnswer]) -> NSData {
        return NSKeyedArchiver.archivedData(withRootObject: archivedObject) as NSData
    }
    let archivedObject = archiveObject(archivedObject: data)
    UserDefaults.standard.set(archivedObject, forKey: "questionAndAnswer")
    UserDefaults.standard.synchronize()
}
func loadData() -> [QuestionAndAnswer]{
    //
    var data = [QuestionAndAnswer]()
    if let archivedObject = UserDefaults.standard.object(forKey: "questionAndAnswer") {
        if let unarchivedData = NSKeyedUnarchiver.unarchiveObject(with: archivedObject as! Data) as? [QuestionAndAnswer] {
            data = unarchivedData
            return data
        } else {
            print("Failed to unarchive journey")
            return data
        }
    }
    return data
}


