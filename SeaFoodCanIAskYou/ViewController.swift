//
//  ViewController.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/15.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    var askQuestion:[String] = ["中午吃什麼？","Yes Or No?","我該告白嗎？","師傅愛吃什麼？"]

    @IBOutlet weak var askPickView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //可延遲啟動畫面消失的時間
        Thread.sleep(forTimeInterval: 1.4)
        //設定pickView的文字顏色
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return askQuestion.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return askQuestion[row]
    }

}

