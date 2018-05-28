//
//  RealmProvider.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2018/5/22.
//  Copyright © 2018年 Justin Huang. All rights reserved.
//

import Foundation
import RealmSwift
class SFRealmManager {
    private init(){}
    class func main() -> Realm {
        if let _ = NSClassFromString("XCTest") {
            let realm = try! Realm(configuration: Realm.Configuration(fileURL: nil, inMemoryIdentifier: "test", encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, objectTypes: nil))
            return realm
        } else {
            let realm = try! Realm()
            return realm
            
        }
    }
    //存入基礎資料
    class func setDefaultData(){
        try! main().write {
            if main().objects(SFQuestionAndAnswerDatabase.self).first == nil{

                var data = SFQuestionAndAnswerDatabase(value: ["0","Yes or No",
                                                               [Answer(value:["Yes"]),
                                                                Answer(value:["No"])]
                    ])
                main().add(data, update: true)
                data = SFQuestionAndAnswerDatabase(value: ["1","我該告白嗎？",
                                                           [Answer(value:["現在不衝更待何時？"]),
                                                            Answer(value:["別去，砲灰"])]
                    ])
                main().add(data, update: true)
                
                data = SFQuestionAndAnswerDatabase(value: ["2","中午吃什麼？",
                                                           [Answer(value:["霸王豬腳"]),
                                                            Answer(value:["自助餐"]),
                                                            Answer(value:["金仙蝦捲"]),
                                                            Answer(value:["雞肉飯"])]
                    ])
                main().add(data, update: true)
                
                data = SFQuestionAndAnswerDatabase(value: ["3","師父愛吃什麼？",
                                                           [Answer(value:["Seafood"]),
                                                            Answer(value:["應該是Seafood"]),
                                                            Answer(value:["那就Seafood吧"]),
                                                            Answer(value:["總之就是Seafood"])]
                    ])
                main().add(data, update: true)
            }
        }
    }
    //資料修改
    class func writeData(_ completion:()->()){
        try! main().write {
            completion()
        }
    }
    //資料新增
    class func addData(_ object:Object,update:Bool){
        try! main().write {
            main().add(object, update: update)
        }
    }
    class func addData<S:Sequence>(_ objects:S) where S.Iterator.Element:Object{
        try! main().write {
            main().delete(objects)
        }
    }
    //資料刪除
    class func deleteData(_ object:Object){
        try! main().write {
            main().delete(object)
        }
    }
    //Sequence資料刪除
    class func deleatData<S: Sequence>(_ objects: S) where S.Iterator.Element: Object{
        try! main().write {
            main().delete(objects)
        }
    }
}
