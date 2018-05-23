//
//  RealmProvider.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2018/5/22.
//  Copyright © 2018年 Justin Huang. All rights reserved.
//

import Foundation
import RealmSwift
class SFRealmProvider {
    class func realm() -> Realm {
        if let _ = NSClassFromString("XCTest") {
            let realm = try! Realm(configuration: Realm.Configuration(fileURL: nil, inMemoryIdentifier: "test", encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, objectTypes: nil))
            return realm
        } else {
            let realm = try! Realm()
            return realm
            
        }
    }
    class func setDefaultData(){
        //存取LacalDatabase
        try! uiRealm.write {
            if uiRealm.objects(SFQuestionAndAnswerDatabase.self).first == nil{
                uiRealm.create(SFQuestionAndAnswerDatabase.self, value:
                    ["0","Yes or No",
                     [Answer(value:["Yes"]),
                      Answer(value:["No"])]
                    ], update: true)
                uiRealm.create(SFQuestionAndAnswerDatabase.self, value:
                    ["1","我該告白嗎？",
                     [Answer(value:["現在不衝更待何時？"]),
                      Answer(value:["別去，砲灰"])]
                    ], update: true)
                uiRealm.create(SFQuestionAndAnswerDatabase.self, value:
                    ["2","中午吃什麼？",
                     [Answer(value:["霸王豬腳"]),
                      Answer(value:["自助餐"]),
                      Answer(value:["金仙蝦捲"]),
                      Answer(value:["雞肉飯"])]
                    ], update: true)
                uiRealm.create(SFQuestionAndAnswerDatabase.self, value:
                    ["3","師父愛吃什麼？",
                     [Answer(value:["Seafood"]),
                      Answer(value:["應該是Seafood"]),
                      Answer(value:["那就Seafood吧"]),
                      Answer(value:["總之就是Seafood"])]
                    ], update: true)
            }
        }
    }
}
