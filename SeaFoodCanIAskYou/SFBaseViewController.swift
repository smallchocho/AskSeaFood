//
//  SFViewController.swift
//  SeaFoodCanIAskYou
//
//  Created by 黃聖傑 on 2018/5/23.
//  Copyright © 2018年 Justin Huang. All rights reserved.
//

import UIKit
class SFBaseViewController:UIViewController{
    func presentAlertController(alertTitle:String?,alertMessage:String?,yesActionTitle:String?,yesActionHandler:((UIAlertAction)->Void)?,noActionTitle:String?,noActionHandler:((UIAlertAction)->Void)?){
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
    func   presentTextFieldAlertController(title:String?,message:String?,textInFieldText:String?,placeHolder:String?,yesTitle:String?,noTitle:String?,yesCompletion: ( (String?)->() )? ,noCompletion:( (String?)->() )?){
        
        let newQuestionAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        newQuestionAlert.addTextField {(textField:UITextField) in
            if let placeHolder = placeHolder{ textField.placeholder = placeHolder}
            if let tfText = textInFieldText { textField.text = tfText }
            if let yesTitle = yesTitle{
                let yesHandler:(UIAlertAction)->() = {
                    _ in yesCompletion?(textField.text)
                }
                let yesAction = UIAlertAction(title: yesTitle, style: UIAlertActionStyle.default,handler:yesHandler)
                newQuestionAlert.addAction(yesAction)
            }
            if let noTile = noTitle{
                let noHandler:(UIAlertAction)->() = {
                    _ in noCompletion?(textField.text)
                }
                let noAction = UIAlertAction(title: noTile, style: UIAlertActionStyle.cancel, handler: noHandler)
                newQuestionAlert.addAction(noAction)
            }
            self.present(newQuestionAlert, animated: true, completion: nil)
        }
        
    }
}
