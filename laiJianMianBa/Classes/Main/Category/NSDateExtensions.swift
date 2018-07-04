//
//  NSDateExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 15/07/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//
import UIKit

extension NSDate {
    class func createDateString(_ timeInterval : TimeInterval) -> String {
        // 1.创建时间格式化对象
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        
        // 2.将字符串时间,转成NSDate类型
        let createDate = Date.init(timeIntervalSince1970: timeInterval)
        
        // 3.创建当前时间
        let nowDate = NSDate()
        
        // 4.计算创建时间和当前时间的时间差
        let interval = Int(nowDate.timeIntervalSince(createDate))
        
        // 今天
        if interval < 60 * 60 * 24 {
            fmt.dateFormat = "今天 HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        
        // 5.4.创建日历对象
        let calendar = Calendar.current
        
        // 5.5.处理昨天数据: 昨天 12:23
        if calendar.isDateInYesterday(createDate) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
       
        // 5.7.超过一年: 2014-02-12 13:22
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = fmt.string(from: createDate)
        return timeStr
    }
}
