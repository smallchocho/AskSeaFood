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
            return try! Realm(configuration: Realm.Configuration(fileURL: nil, inMemoryIdentifier: "test", encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, objectTypes: nil))
        } else {
            return try! Realm();
            
        }
    }
}
