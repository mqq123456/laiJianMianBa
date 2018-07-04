//
//  JMCommom.swift
//  JMServicesKit
//
//  Created by HeQin on 16/12/22.
//  Copyright © 2016年 fundot. All rights reserved.
//

import Foundation
import UIKit


// MARK:- 应用常量
let version = "1.0"//应用版本号
let url = "http://123.57.218.66:8000/fdate/"//接口地址
let channelid = "channelid"//渠道名称
let ip = "123.57.218.66"//ip
/// head
let head: [String : String] = ["version": "10010110", "channelid": "C200001"]
func urlString(_ name: String)->NSString{return NSString.init(string: "jaiJianMianBa://"+name)}
