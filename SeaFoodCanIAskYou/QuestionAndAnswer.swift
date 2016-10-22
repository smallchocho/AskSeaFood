//
//  questionAndAnswer.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/20.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import Foundation
class QuestionAndAnswer {
    var question = ""
    var answer = [String]()
    init(question q:String,answer a:[String]){
        self.question = q
        self.answer = a
    }
}
var questionAndAnswer:[QuestionAndAnswer] = [
    QuestionAndAnswer(question:"假日哪邊的黃線可以停車？", answer:["你看不到我你看不到我","你看不到我你看不到我"]),
    QuestionAndAnswer(question:"師父我想問其他的問題", answer:["你看不到我你看不到我","你看不到我你看不到我"]),
    QuestionAndAnswer(question:"Yes or No", answer:["Yes","No"]),
    QuestionAndAnswer(question: "我該告白嗎？", answer: ["現在不衝更待何時","別去，砲灰"]),
    QuestionAndAnswer(question: "中午吃什麼？", answer: ["霸王豬腳","自助餐","金仙蝦捲","雞肉飯"]),
    QuestionAndAnswer(question: "師父愛吃什麼？", answer: ["Seafood","應該是Seafood","那就Seafood吧","總之就是Seafood"])
]
