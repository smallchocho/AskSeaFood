//
//  YelloLineInfo.swift
//  SeaFoodCanIAskYou
//
//  Created by Justin Huang on 2016/10/22.
//  Copyright © 2016年 Justin Huang. All rights reserved.
//

import Foundation
class YelloLineInfo{
    var titleInfo:String?
    var parkingTimeInfo:String?
    var addressInfo:String?
    init(title:String,parkingTime:String,address:String) {
        self.titleInfo = title
        self.parkingTimeInfo = parkingTime
        self.addressInfo = address
    }
}
var YelloLineData:[YelloLineInfo] = [
    YelloLineInfo(title: "台北市中山區八德路2段281號", parkingTime:"00~24", address: "台北市中山區八德路2段281號"),
    YelloLineInfo(title: "台北市中山區民族東路180號", parkingTime:"00~24", address: "台北市中山區民族東路180號"),
    YelloLineInfo(title: "台北市中山區民權東路3段8號", parkingTime:"00~24", address: "台北市中山區民權東路3段9號"),
    YelloLineInfo(title: "台北市中山區長安東路14號", parkingTime:"00~24", address: "台北市中山區長安東路一段14號"),
    YelloLineInfo(title: "台北市中山區長安東路19號", parkingTime:"00~24", address: "台北市中山區長安東路一段19號")
]
