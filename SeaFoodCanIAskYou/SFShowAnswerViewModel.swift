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
            self.saveSinPowerInfo()
        }
    }
    var sinPowerCounter = 0{
        didSet{
            self.reloadSinPowerView?()
            self.saveSinPowerInfo()
        }
    }
    var ansQuestion:List<Answer>!
    init() {
        self.loadSinPowerInfo()
    }
    var reloadSinPowerView:(()->())?
    
    func saveSinPowerInfo(){
        UserDefaults.standard.set(sinPowerHeight, forKey: "sinPowerHeight")
        UserDefaults.standard.set(sinPowerCounter, forKey: "sinPowerCounter")
        UserDefaults.standard.synchronize()
    }
    func loadSinPowerInfo(){
        if UserDefaults.standard.float(forKey: "sinPowerHeight") != 0{
            sinPowerHeight = CGFloat(UserDefaults.standard.float(forKey: "sinPowerHeight"))
        }
        if UserDefaults.standard.integer(forKey: "sinPowerCounter") != 0{
            sinPowerCounter = UserDefaults.standard.integer(forKey: "sinPowerCounter")
        }
    }
    
    func upSinPowerBarAndSinCounter(){
        if sinPowerCounter < 87 && sinPowerCounter >= 80{
            sinPowerCounter += 7
        }
        if sinPowerCounter < 80 {
            sinPowerCounter += 10
        }
        if sinPowerHeight < UIScreen.main.bounds.height * 0.324{
            sinPowerHeight += UIScreen.main.bounds.height * 0.036
        }
    }
    func downSinPowerBarAndSinCounter(){
        if sinPowerCounter <= 87 && sinPowerCounter > 80 {
            sinPowerCounter -= 7
        }
        if sinPowerCounter <= 80 && sinPowerCounter >= 10{
            self.sinPowerCounter -= 10
        }
        
        if self.sinPowerHeight >= UIScreen.main.bounds.height * 0.036{
            self.sinPowerHeight -= UIScreen.main.bounds.height * 0.036
        }
    }
}
