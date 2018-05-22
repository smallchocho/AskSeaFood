//
//  File.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2018/5/19.
//  Copyright © 2018年 Justin Huang. All rights reserved.
//

import Foundation
import RealmSwift
class SFShowAnswerViewModel{
    var sinPowerHeight:CGFloat = 0.0{
        didSet{
            self.reloadSinPowerView?()
        }
    }
    var sinPowerCount = 0{
        didSet{
            self.reloadSinPowerView?()
        }
    }
    var isUpTo87Point:Bool{
        return self.sinPowerCount >= 87
    }
    var ansQuestion:List<Answer>!
    init() {
        self.loadSinPowerInfo()
    }
    var reloadSinPowerView:(()->())?
    
    func saveSinPowerInfo(){
        UserDefaults.standard.set(sinPowerHeight, forKey: "sinPowerHeight")
        UserDefaults.standard.set(sinPowerCount, forKey: "sinPowerCounter")
        UserDefaults.standard.synchronize()
    }

    func loadSinPowerInfo(){
        if UserDefaults.standard.float(forKey: "sinPowerHeight") != 0.0{
            sinPowerHeight = CGFloat(UserDefaults.standard.float(forKey: "sinPowerHeight"))
        }
        if UserDefaults.standard.integer(forKey: "sinPowerCounter") != 0{
            sinPowerCount = UserDefaults.standard.integer(forKey: "sinPowerCounter")
        }
    }
    
    func upSinPowerBarAndSinCounter(){
        switch sinPowerCount {
        case let count where count < 87 && count >= 80:
            sinPowerCount += 7
        case let count where count < 80:
            sinPowerCount += 10
        default:
            break
        }
        
        if sinPowerHeight < UIScreen.main.bounds.height * 0.324{
            sinPowerHeight += UIScreen.main.bounds.height * 0.036
        }
    }
    func downSinPowerBarAndSinCounter(){
        switch sinPowerCount {
        case let count where count <= 87 && count > 80:
             sinPowerCount -= 7
        case let count where count <= 80 && count >= 10:
            sinPowerCount -= 10
        default:
            break
        }
        
        if self.sinPowerHeight >= UIScreen.main.bounds.height * 0.036{
            self.sinPowerHeight -= UIScreen.main.bounds.height * 0.036
        }
    }
}
