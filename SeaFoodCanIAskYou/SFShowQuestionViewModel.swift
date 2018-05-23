//
//  SFShowQuestionViewModel.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2018/5/19.
//  Copyright © 2018年 Justin Huang. All rights reserved.
//

import Foundation
import RealmSwift
class SFShowQuestionViewModel{
    var questionAndAnswer:Results<SFQuestionAndAnswerDatabase>!{
        didSet{
            self.reloadTableVIew?()
        }
    }
    init() {
        self.loadData()
    }
    func loadData(){
        
        questionAndAnswer = uiRealm.objects(SFQuestionAndAnswerDatabase.self)
    }
    
    var reloadTableVIew:(()->())?
}
