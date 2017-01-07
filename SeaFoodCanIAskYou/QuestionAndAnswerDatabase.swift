//
//  QuestionAndAnswerDatabase.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2017/1/6.
//  Copyright © 2017年 Justin Huang. All rights reserved.
//

import Foundation
import RealmSwift

class QuestionAndAnswerDatabase: Object {
    dynamic var id = ""
    dynamic var question = ""
    dynamic var answer:[String] = []
    override static func primaryKey() -> String?{
      return "id"
    }
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
