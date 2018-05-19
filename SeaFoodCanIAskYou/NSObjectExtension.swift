//
//  NSObjectExtension.swift
//  G-Cool
//
//  Created by 黃聖傑 on 2018/3/27.
//  Copyright © 2018年 FinData. All rights reserved.
//

import Foundation
extension NSObject{
    func className()->String{
     return String(describing: type(of: self))
    }
    static func className()->String{
        return String(describing:self)
    }
}
