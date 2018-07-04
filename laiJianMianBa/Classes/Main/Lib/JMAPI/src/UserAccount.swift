//
//  UserAccount.swift
//  DS11WB
//
//  Created by xiaomage on 16/4/6.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

open class UserAccount: NSObject, NSCoding {
    // MARK:- 属性
    /** devtoken */
    public var devtoken : String?
    /** 用户ID */
    public var uId : Int!
    /** 昵称 */
    public var name: String!
    /** 性别 */
    public var sex: Int!
    /** 身高 */
    public var height: Int!
    /** 头像 */
    public var avatar: String!
    /** 生日 */
    public var birthTime: TimeInterval!
    public func birthday() -> String {
        let date = Date(timeIntervalSince1970: self.birthTime)
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd"
        let str = dformatter.string(from: date)
        return str
    }
    /** 年龄 */
    public var age: String!
    /** 行业 */
    public var industry: String!
    /** 收入 */
    public var income: String!
    /** 个性签名 */
    public var signature: String!
    /** 微信帐号 */
    public var weChatAccount: String!
    /** 手机号 */
    public var phone: String!
    /** 公司 */
    public var company: String!
    /** 家乡 */
    public var hometown: String!
    /** openid */
    public var openid: String!
    /** 注册时间 */
    public var regtime: String!
    /** 兴趣爱好 */
    public var interest: String!
    /** 星座 */
    public var sign: String!
    /** 职业 */
    public var occupation: String!
    /** 头像数据 */
    public var headImgs: [String]!
    /** 他人印象 */
    public var impressions: [String: Any]!
    /** 消息推送标识 */
    public var push_token: String!
    /** 支付open id */
    public var pay_open_id: String!
    /** 支付union id */
    public var pay_union_id: String!
    /** 创建时间（unix时间' */
    public var create_time: String!
    /** 获取用户上传头像的数量 */
    open func getHeadsCount() -> Int{
        if self.headImgs.count >= 2 {
            if headImgs[1] == "" {
                return 1
            }else{
                return self.headImgs.count
            }
        }
        return self.headImgs.count
    }
    /** 饮食爱好 */
    open func getFoodHobbys() -> [InterestModel] {
        let int = self.interest
        let arra = int?.components(separatedBy: ",")
        var foodHobbys: [InterestModel]! = [InterestModel]()
        for str in arra! {
            let title = str.components(separatedBy: "|")
            if title.count >= 3 {
                let model: InterestModel = InterestModel()
                model.id = title[0]
                model.type = title[1]
                model.iclass = title[2]
                model.isSelected = true
                if title[1] == "0" {
                    foodHobbys.append(model)
                }
            }
        }
        return foodHobbys
    }
    /** 运动爱好 */
    open func getSportsHobbys() -> [InterestModel]{
        let int = UserAccountViewModel.standard.account?.interest
        let arra = int?.components(separatedBy: ",")
        var sportsHobbys: [InterestModel]! = [InterestModel]()
        for str in arra! {
            let title = str.components(separatedBy: "|")
            if title.count >= 3 {
                let model: InterestModel = InterestModel()
                model.id = title[0]
                model.type = title[1]
                model.iclass = title[2]
                model.isSelected = true
                if title[1] == "1" {
                    sportsHobbys.append(model)
                }
            }
        }
        return sportsHobbys
    }
    /** 音乐爱好 */
    open func getMusicHobbys() -> [InterestModel] {
        let int = UserAccountViewModel.standard.account?.interest
        let arra = int?.components(separatedBy: ",")
        var musicHobbys: [InterestModel]! = [InterestModel]()
        for str in arra! {
            let title = str.components(separatedBy: "|")
            if title.count >= 3 {
                let model: InterestModel = InterestModel()
                model.id = title[0]
                model.type = title[1]
                model.iclass = title[2]
                model.isSelected = true
                if title[1] == "2" {
                    musicHobbys.append(model)
                }
            }
        }
        return musicHobbys
    }
    /** 电影爱好 */
    open func getMoveHobbys() -> [InterestModel] {
        let int = UserAccountViewModel.standard.account?.interest
        let arra = int?.components(separatedBy: ",")
        var moveHobbys: [InterestModel]! = [InterestModel]()
        for str in arra! {
            let title = str.components(separatedBy: "|")
            if title.count >= 3 {
                let model: InterestModel = InterestModel()
                model.id = title[0]
                model.type = title[1]
                model.iclass = title[2]
                model.isSelected = true
                if title[1] == "3" {
                    moveHobbys.append(model)
                }
            }
        }
        return moveHobbys
    }
    /** 读书爱好 */
    open func getBookHobbys() -> [InterestModel] {
        let int = UserAccountViewModel.standard.account?.interest
        let arra = int?.components(separatedBy: ",")
        var bookHobbys: [InterestModel]! = [InterestModel]()
        for str in arra! {
            let title = str.components(separatedBy: "|")
            if title.count >= 3 {
                let model: InterestModel = InterestModel()
                model.id = title[0]
                model.type = title[1]
                model.iclass = title[2]
                model.isSelected = true
                if title[1] == "4" {
                    bookHobbys.append(model)
                }
            }
        }
        return bookHobbys
    }
    /** 获取行业模型 */
    open func getArea() -> [InterestModel] {
        let model: InterestModel = InterestModel()
        model.iclass = self.industry
        model.iclass = self.occupation
        model.isSelected = false
        model.type = "5"
        model.id = "0"
        return [model]
    }
    /** 获取职业模型 */
    open func getJob() -> [InterestModel] {
        let model: InterestModel = InterestModel()
        model.iclass = self.occupation
        model.isSelected = false
        model.type = "6"
        model.id = "0"
        return [model]
    }
    /** 获取家乡模型 */
    open func getHomeTown() -> [InterestModel] {
        let model: InterestModel = InterestModel()
        model.iclass = self.hometown
        model.isSelected = false
        model.type = "7"
        model.id = "0"
        return [model]
    }
    class func createDateString(_ timeInterval : TimeInterval) -> String {
        // 1.创建时间格式化对象
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        // 2.转成NSDate类型
        let createDate = Date.init(timeIntervalSince1970: timeInterval)
        // 3.创建当前时间
        let nowDate = NSDate()
        // 4.计算创建时间和当前时间的时间差
        let interval = Int(nowDate.timeIntervalSince(createDate))
        if interval < 0 {
            fmt.dateFormat = "明天 HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        // 今天
        if interval < 60 * 60 * 24 && interval > 0 {
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
    required public override init() {
        super.init()
    }
    override open func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    // MARK:- 重写description属性
    override open var description : String {
        return ""
    }
    // MARK:- 归档&解档
    /// 解档的方法
    public required init?(coder aDecoder: NSCoder) {
        devtoken = aDecoder.decodeObject(forKey: "devtoken") as? String
        uId = aDecoder.decodeObject(forKey: "uId") as? Int
        create_time = aDecoder.decodeObject(forKey: "id") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        sex = aDecoder.decodeObject(forKey: "sex") as? Int
        age = aDecoder.decodeObject(forKey: "age") as? String
        height = aDecoder.decodeObject(forKey: "height") as? Int
        avatar = aDecoder.decodeObject(forKey: "avatar") as? String
        birthTime = aDecoder.decodeObject(forKey: "birthTime") as? TimeInterval
        industry = aDecoder.decodeObject(forKey: "industry") as? String
        income = aDecoder.decodeObject(forKey: "income") as? String
        signature = aDecoder.decodeObject(forKey: "signature") as? String
        weChatAccount = aDecoder.decodeObject(forKey: "weChatAccount") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        company = aDecoder.decodeObject(forKey: "company") as? String
        hometown = aDecoder.decodeObject(forKey: "hometown") as? String
        openid = aDecoder.decodeObject(forKey: "openid") as? String
        regtime = aDecoder.decodeObject(forKey: "regtime") as? String
        interest = aDecoder.decodeObject(forKey: "interest") as? String
        sign = aDecoder.decodeObject(forKey: "sign") as? String
        occupation = aDecoder.decodeObject(forKey: "occupation") as? String
        headImgs = aDecoder.decodeObject(forKey: "headImgs") as? [String]
        push_token = aDecoder.decodeObject(forKey: "push_token") as? String
        pay_open_id = aDecoder.decodeObject(forKey: "pay_open_id") as? String
        pay_union_id = aDecoder.decodeObject(forKey: "pay_union_id") as? String
        create_time = aDecoder.decodeObject(forKey: "create_time") as? String
        impressions = aDecoder.decodeObject(forKey: "impressions") as? [String:Any]
    }
    
    /// 归档方法
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(devtoken, forKey: "devtoken")
        aCoder.encode(uId, forKey: "uId")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(sex, forKey: "sex")
        aCoder.encode(age, forKey: "age")
        aCoder.encode(height, forKey: "height")
        aCoder.encode(avatar, forKey: "avatar")
        aCoder.encode(birthTime, forKey: "birthTime")
        aCoder.encode(industry, forKey: "industry")
        aCoder.encode(income, forKey: "income")
        aCoder.encode(signature, forKey: "signature")
        aCoder.encode(weChatAccount, forKey: "weChatAccount")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(company, forKey: "company")
        aCoder.encode(hometown, forKey: "hometown")
        aCoder.encode(openid, forKey: "openid")
        aCoder.encode(regtime, forKey: "regtime")
        aCoder.encode(interest, forKey: "interest")
        aCoder.encode(sign, forKey: "sign")
        aCoder.encode(occupation, forKey: "occupation")
        aCoder.encode(headImgs, forKey: "headImgs")
        aCoder.encode(push_token, forKey: "push_token")
        aCoder.encode(pay_open_id, forKey: "pay_open_id")
        aCoder.encode(pay_union_id, forKey: "pay_union_id")
        aCoder.encode(create_time, forKey: "create_time")
        aCoder.encode(impressions, forKey: "impressions")
    }
    
    
    /// 计算年龄
    ///
    /// - Parameter time: 需要计算的日期时间戳
    /// - Returns: 返回年龄
    open class func ageWithDateOfBirth(_ time: TimeInterval) -> String {
        let newDate = Date.init(timeIntervalSince1970: Double(time))
        
        // 出生日期转换 年月日
        let unitFlags = Set<Calendar.Component>([.day, .month, .year])
        let calendar = Calendar.current
        let components1 = calendar.dateComponents(unitFlags, from: newDate as Date)
        let brithDateYear  = components1.year;
        let brithDateDay   = components1.day;
        let brithDateMonth = components1.month;
        
        // 获取系统当前 年月日
        let components2 = NSCalendar.current.dateComponents(unitFlags, from: Date())
        let currentDateYear  = components2.year;
        let currentDateDay   = components2.day;
        let currentDateMonth = components2.month;
        
        // 计算年龄
        var iAge = currentDateYear! - brithDateYear! - 1;
        if ((currentDateMonth! > brithDateMonth!) || (currentDateMonth! == brithDateMonth! && currentDateDay! >= brithDateDay!)) {
            iAge += 1
        }
        
        return "\(iAge)";
        
    }
  
    public class func parseData(_ userDict: NSDictionary) -> UserAccount {
        let user: UserAccount = UserAccount()
        user.devtoken = userDict.object(forKey: "devtoken") as? String ?? ""
        user.uId = userDict.object(forKey: "id") as? Int ?? 0
        user.name = userDict.object(forKey: "name") as? String ?? ""
        user.sex = userDict.object(forKey: "sex") as? Int ?? 0
        user.height = userDict.object(forKey: "height") as? Int ?? 0
        user.birthTime = userDict.object(forKey: "birthday") as? TimeInterval ?? 0
        user.age = UserAccount.ageWithDateOfBirth(user.birthTime)
        user.industry = userDict.object(forKey: "area") as? String ?? ""
        user.income = userDict.object(forKey: "income") as? String ?? ""
        user.signature = userDict.object(forKey: "signature") as? String ?? ""
        user.weChatAccount = userDict.object(forKey: "weixin") as? String ?? ""
        user.phone = userDict.object(forKey: "phone") as? String ?? ""
        user.company = userDict.object(forKey: "company") as? String ?? ""
        user.hometown = userDict.object(forKey: "hometown") as? String ?? ""
        user.openid = userDict.object(forKey: "openid") as? String ?? ""
        user.regtime = userDict.object(forKey: "regtime") as? String ?? ""
        user.interest = userDict.object(forKey: "interest") as? String ?? ""
        user.sign = userDict.object(forKey: "sign") as? String ?? ""
        user.occupation = userDict.object(forKey: "job") as? String ?? ""
        user.push_token = userDict.object(forKey: "push_token") as? String ?? ""
        user.pay_open_id = userDict.object(forKey: "pay_open_id") as? String ?? ""
        user.pay_union_id = userDict.object(forKey: "pay_union_id") as? String ?? ""
        user.create_time = userDict.object(forKey: "create_time") as? String ?? ""
        ///
        user.impressions = userDict.object(forKey: "impress") as? [String:Any] ?? [String:Any]()
        /// 头像
        let uImages = userDict.object(forKey: "heads") as? NSString ?? ""
        var headImages = uImages.components(separatedBy: ",")
        if headImages.last == "" {
            headImages.removeLast()
        }
        user.headImgs = headImages
        user.avatar = headImages.first ?? ""
        user.interest = userDict.object(forKey: "interest") as? String ?? ""
        user.sign = ZWTagModel.calculateConstellation(withMonth: user.birthday())
        let int = userDict.object(forKey: "interest") as? String ?? ""
        let arra = int.components(separatedBy: ",")
        var foodHobbys: [InterestModel]! = [InterestModel]()
        var sportsHobbys: [InterestModel]! = [InterestModel]()
        var musicHobbys: [InterestModel]! = [InterestModel]()
        var moveHobbys: [InterestModel]! = [InterestModel]()
        var bookHobbys: [InterestModel]! = [InterestModel]()
        for str in arra {
            let title = str.components(separatedBy: "|")
            if title.count >= 3 {
                let model: InterestModel = InterestModel()
                model.id = title[0]
                model.type = title[1]
                model.iclass = title[2]
                if title[1] == "0" {
                    foodHobbys.append(model)
                }
                if title[1] == "1" {
                    sportsHobbys.append(model)
                }
                if title[1] == "2" {
                    musicHobbys.append(model)
                }
                if title[1] == "3" {
                    moveHobbys.append(model)
                }
                if title[1] == "4" {
                    bookHobbys.append(model)
                }
            }
        }
        
        return user
    }
}
