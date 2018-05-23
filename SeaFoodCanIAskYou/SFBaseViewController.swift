//
//  SFViewController.swift
//  SeaFoodCanIAskYou
//
//  Created by 黃聖傑 on 2018/5/23.
//  Copyright © 2018年 Justin Huang. All rights reserved.
//

import UIKit
class SFBaseViewController:UIViewController{
    func pressentAlertController(alertTitle:String?,alertMessage:String?,yesActionTitle:String?,yesActionHandler:((UIAlertAction)->Void)?,noActionTitle:String?,noActionHandler:((UIAlertAction)->Void)?){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        if let yesTitle = yesActionTitle {
            let yesAction = UIAlertAction(title: yesTitle, style: UIAlertActionStyle.default, handler: yesActionHandler)
            alert.addAction(yesAction)
        }
        if let noTitle = noActionTitle {
            let noAction = UIAlertAction(title: noTitle, style: UIAlertActionStyle.cancel, handler: noActionHandler)
            alert.addAction(noAction)
        }
        present(alert, animated: true, completion: nil)
    }
    func openUrlInSafari(url:String){
        if let urlOfSafari = URL(string:url){
            UIApplication.shared.open(urlOfSafari, options: [:], completionHandler: nil)
        }
    }
}
