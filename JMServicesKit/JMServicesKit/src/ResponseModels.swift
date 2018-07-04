//
//  ResponseModels.swift
//  JMServicesKit
//
//  Created by HeQin on 16/12/26.
//  Copyright © 2016年 fundot. All rights reserved.
//

import Foundation
// MARK: - ResponseBaseModel
open class ResponseBaseModel: NSObject {
    open var status: String!
    open var message: String!
}
// MARK: - InterestModel
open class InterestModel: NSObject {
    open var id: String!
    open var type: String!
    open var iclass: String!
    open var isSelected: Bool!
    // MARK:- 自定义构造函数
    required public override init() {
        
    }
}

// MARK: - ResponseUserLoginModel
open class ResponseUserLoginModel: ResponseBaseModel {
    open var user: UserAccount!
    class func parseJson(_ dict: NSDictionary) -> ResponseUserLoginModel {
        let response = ResponseUserLoginModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        if let message = dict.object(forKey: "data") as? NSDictionary{
            let user: UserAccount = UserAccount.parseData(message)
            response.user = user
            return response
        }else{
            
        }
        return response
    }
}
// MARK: - ResponseUserDetailModel
open class ResponseUserDetailModel: ResponseBaseModel {
    open var user: UserAccount!
    class func parseJson(_ dict: NSDictionary) -> ResponseUserDetailModel {
        let response = ResponseUserDetailModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        if let message = dict.object(forKey: "data") as? NSDictionary{
            let user: UserAccount = UserAccount.parseData(message)
            response.user = user
            return response
        }else{
            
        }
        return response
    }
}
// MARK: - ResponseUserAddModel
open class ResponseUserRegisterModel: ResponseBaseModel {
    open var user: UserAccount!
    class func parseJson(_ dict: NSDictionary) -> ResponseUserRegisterModel {
        let response = ResponseUserRegisterModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as! String!
            return response
        }
        if let data = dict["data"] as? [String : Any] {
            let user: UserAccount = UserAccount.parseData(data as NSDictionary)
            response.user = user
        }
        return response
    }
}
// MARK: - ResponseUserChangeModel
open class ResponseUserChangeModel: ResponseBaseModel {
    open var user: UserAccount!
    class func parseJson(_ dict: NSDictionary) -> ResponseUserChangeModel {
        let response = ResponseUserChangeModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        if let data = dict.object(forKey: "data") as? NSDictionary{
            let user: UserAccount = UserAccount.parseData(data)
            response.user = user
            return response
        }else{
            
        }
        return response
    }
    
}


// MARK: - ResponseSetUserImpressModel
open class ResponseSetUserImpressModel: ResponseBaseModel {
    open var user: UserAccount!
    class func parseJson(_ dict: NSDictionary) -> ResponseSetUserImpressModel {
        let response = ResponseSetUserImpressModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        return response
    }
    
}
// MARK: - DateList
open class DateList {
    open var id: Int!
    open var user_id: Int!
    open var money: Int!
    open var lat: Int!
    open var lon: Int!
    open var time: Int!
    open var addr: String!
    open var desc: String!
    open var state: Int!
    open var create_time: Int!
    open var from_phone: String!
    open var from_weixin: String!
    open var from_sex: Int!
    open var cipher: String!
    open var to_peoples: Int!
    open var to_user_id: Int!
    required public init() {
        
    }
}
// MARK: - ResponseSendOrderListModel
open class ResponseSendOrderListModel: ResponseBaseModel {
    open var orders: [DateList]!
    class func parseJson(_ dict: NSDictionary) -> ResponseSendOrderListModel {
        let response = ResponseSendOrderListModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as! String!
            return response
        }
        if let data = dict.object(forKey: "data") as? NSDictionary ,let orders = data["orders"] as? [NSDictionary]{
            var joinListArray = [DateList]()
            for dict: NSDictionary in orders {
                let joinList = DateList()
                joinList.id = dict["id"] as? Int ?? 0
                joinList.user_id = dict["user_id"] as? Int ?? 0
                joinList.money = dict["money"] as? Int ?? 0
                joinList.lat = dict["lat"] as? Int ?? 0
                joinList.lon = dict["lon"] as? Int ?? 0
                joinList.time = dict["time"] as? Int ?? 0
                joinList.addr = dict["addr"] as? String ?? ""
                joinList.desc = dict["desc"] as? String ?? ""
                joinList.state = dict["state"] as? Int ?? 0
                joinList.from_phone = dict["from_phone"] as? String ?? ""
                joinList.create_time = dict["create_time"] as? Int ?? 0
                joinList.from_weixin = dict["from_weixin"] as? String ?? ""
                joinList.from_sex = dict["from_sex"] as? Int ?? 0
                joinList.cipher = dict["cipher"] as? String ?? ""
                joinList.to_peoples = dict["to_peoples"] as? Int ?? 0
                joinList.to_user_id = dict["to_user_id"] as? Int ?? 0
                joinListArray.append(joinList)
            }
            response.orders = joinListArray
        }else{
            response.orders = [DateList]()
        }
        return response
    }
}
// MARK: - ResponseSendDateModel
open class ResponseSendDateModel: ResponseBaseModel {
    open var serialno: String!
    open var orderid: Int!
    class func parseJson(_ dict: NSDictionary) -> ResponseSendDateModel {
        let response = ResponseSendDateModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as! String!
            return response
        }
        if let data = dict.object(forKey: "data") as? NSDictionary {
            response.orderid = data.object(forKey: "id") as? Int ?? 0
            let serialno = data.object(forKey: "to_peoples") as? Int ?? 0
            response.serialno  = NSString(format: "%d" , serialno) as String!
        }else {
            response.orderid = 0
            response.serialno = ""
        }
        return response
    }
}

// MARK: - ImpressModel
open class ImpressModel: NSObject {
    open var impress: String!
    open var sex: String!
    open var id: String!
    open var impress_color: String!
    open var isSelected: Bool!
    open var selected_color: String!
}

// MARK: - OrderModel
open class OrderModel: NSObject {
    open var state: String!
    open var uid: String!
    open var phone: String!
    open var paymoney: String!
    open var des: String!
    open var address_lat: String!
    open var address: String!
    open var orderid: String!
    open var to_peoples: String!
    open var order_time: String!
    open var _cipher: String!
    open var citycode: String!
    open var address_lng: String!
    open var to_uid: String!
    
}
// MARK: - ResponseGetParseListModel
open class ResponseOrderDetailModel: ResponseBaseModel {
    open var order: OrderModel!
    class func parseJson(_ dict: NSDictionary) -> ResponseOrderDetailModel {
        let response = ResponseOrderDetailModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        if let message = dict.object(forKey: "message") as? NSDictionary ,let orderDict = message["order"] as? [NSDictionary]{
            for dict in orderDict {
                let order = OrderModel()
                order.state = dict["state"] as? String ?? ""
                order.uid = dict["uid"] as? String ?? ""
                order.phone = dict["phone"] as? String ?? ""
                order.paymoney = dict["paymoney"] as? String ?? ""
                order.des = dict["des"] as? String ?? ""
                order.address_lat = dict["address_lat"] as? String ?? ""
                order.address = dict["address"] as? String ?? ""
                order.orderid = dict["orderid"] as? String ?? ""
                order.to_peoples = dict["to_peoples"] as? String ?? ""
                order.order_time = dict["order_time"] as? String ?? ""
                order._cipher = dict["_cipher"] as? String ?? ""
                order.citycode = dict["citycode"] as? String ?? ""
                order.address_lng = dict["address_lng"] as? String ?? ""
                order.to_uid = dict["to_uid"] as? String ?? ""
                response.order = order
            }
        }
    
        return response
    }
}
// MARK: - MissModel
open class MissModel: NSObject {
    open var state: String!
    open var uid: String!
    open var phone: String!
    open var paymoney: String!
    open var address_lat: String!
    open var address: String!
    open var orderid: String!
    open var to_peoples: String!
    open var _cipher: String!
    open var citycode : String!
    open var address_lng : String!
    open var to_uid : String!
    open var order_time : String!
    open var desc : String!
    ///TODO 服务端 缺
    open var name : String!
    open var age : String!
    open var sex : String!
    open var head : String!
    
}
// MARK: - ResponseMissPeopleModel
open class ResponseMissPeopleModel: ResponseBaseModel {
    open var orders: [MissModel]!
    class func parseJson(_ dict: NSDictionary) -> ResponseMissPeopleModel {
        let response = ResponseMissPeopleModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        if let message = dict.object(forKey: "message") as? NSDictionary, let order = message["order"] as? [NSDictionary] {
            var orders = [MissModel]()
            for dict: NSDictionary in order {
                let miss = MissModel()
                miss.state = dict["state"] as? String ?? ""
                miss.uid = dict["uid"] as? String ?? ""
                miss.phone = dict["phone"] as? String ?? ""
                miss.paymoney = dict["paymoney"] as? String ?? ""
                
                miss.desc = dict["des"] as? String ?? ""
                miss.address_lat = dict["address_lat"] as? String ?? ""
                miss.address = dict["address"] as? String ?? ""
                miss.orderid = dict["orderid"] as? String ?? ""
                miss.to_peoples = dict["to_peoples"] as? String ?? ""
                miss.order_time = dict["order_time"] as? String ?? ""
                miss._cipher = dict["_cipher"] as? String ?? ""
                miss.citycode = dict["citycode"] as? String ?? ""
                miss.address_lng = dict["address_lng"] as? String ?? ""
                miss.to_uid = dict["to_uid"] as? String ?? ""
                miss.citycode = dict["citycode"] as? String ?? ""
                miss.name = dict["name"] as? String ?? ""
                miss.age = dict["age"] as? String ?? ""
                miss.sex = dict["sex"] as? String ?? ""
                miss.head = dict["head"] as? String ?? ""
                orders.append(miss)
            }
            response.orders = orders
        }else{
            response.orders = [MissModel]()
        }
        return response
    }
    
}

// MARK: - ReceivedUserModel
open class ReceivedUserModel : NSObject {
    open var id: Int!
    open var order_id: Int!
    open var order_time: Int!
    open var order_time_string: String!
    open var order_addr: String!
    open var order_desc: String!
    open var from_user_id: Int!
    open var from_phone: String!
    open var from_weixin: String!
    open var from_name: String!
    open var to_user_id: Int!
    open var to_phone: String!
    open var to_weixin: String!
    open var to_name: String!
    open var to_sex: Int!
    open var create_time: Int!
    open var money: Int!
    open var state: Int!
    open var msg_state: Int!
    open var from_job: String!
    open var from_avatar: String!
    open var from_birthday: Int!
    open var from_age: String!
    open var from_sex: Int!
}
// MARK: - ResponseReceivedInvitationModel 3012 取我收到的邀请列表
open class ResponseReceivedInvitationModel: ResponseBaseModel {
    /** ReceivedUserModel */
    open  var userlist: [ReceivedUserModel]!
    
    class func parseJson(_ dict: NSDictionary) -> ResponseReceivedInvitationModel {
        let response = ResponseReceivedInvitationModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        if let message = dict.object(forKey: "data") as? NSDictionary, let datelist = message["orders"] as? [NSDictionary] {
            var joinListArray = [ReceivedUserModel]()
            for dict: NSDictionary in datelist {
                let joinList = ReceivedUserModel()
                
                joinList.id = dict["id"] as? Int ?? 0
                joinList.order_id = dict["order_id"] as? Int ?? 0
                joinList.order_time = dict["order_time"] as? Int ?? 0
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "yyyy年MM月dd日"
                let date = Date.init(timeIntervalSince1970: dict["order_time"] as? TimeInterval ?? 0)
                let newDate = dateformatter.string(from: date)
                joinList.order_time_string = newDate
                joinList.order_addr = dict["order_addr"] as? String ?? ""
                joinList.order_desc = dict["order_desc"] as? String ?? ""
                joinList.from_user_id = dict["from_user_id"] as? Int ?? 0
                joinList.from_phone = dict["from_phone"] as? String ?? ""
                joinList.from_weixin = dict["from_weixin"] as? String ?? ""
                joinList.from_name = dict["name"] as? String ?? ""
                joinList.to_user_id = dict["to_user_id"] as? Int ?? 0
                joinList.to_phone = dict["to_phone"] as? String ?? ""
                joinList.to_weixin = dict["to_weixin"] as? String ?? ""
                joinList.to_name = dict["to_name"] as? String ?? ""
                joinList.to_sex = dict["to_sex"] as? Int ?? 0
                joinList.create_time = dict["create_time"] as? Int ?? 0
                joinList.money = dict["money"] as? Int ?? 0
                joinList.state = dict["state"] as? Int ?? 0
                joinList.msg_state = dict["msg_state"]  as? Int ?? 0
                joinList.from_job = dict["job"] as? String ?? ""
                let string = NSString(string: dict["heads"] as? String ?? "")
                let heads = string.components(separatedBy: ",")
                joinList.from_avatar = ""
                for item in heads {
                    if item != "" {
                        joinList.from_avatar = item
                        break
                    }
                }
                joinList.from_birthday = dict["birthday"] as? Int ?? 0
                joinList.from_age = UserAccount.ageWithDateOfBirth(dict["birthday"] as? TimeInterval ?? 0)
                joinList.from_sex = dict["from_sex"] as? Int ?? 0
                joinListArray.append(joinList)
            }
            response.userlist = joinListArray
            return response
        } else {
            response.userlist = [ReceivedUserModel]()
        }
        return response
    }

}

// MARK: - ResponseReadyPayModel 4003 预支付
open class ResponseReadyPayModel: ResponseBaseModel {
    open  var appid: String!
    open  var partnerid: String!
    open  var prepayid: String!
    open  var package: String!
    open  var noncestr: String!
    open  var timestamp: uint!
    open  var sign: String!
    class func parseJson(_ dict: NSDictionary) -> ResponseReadyPayModel {
        let response = ResponseReadyPayModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        if let data = dict.object(forKey: "data") as? NSDictionary  {
            response.appid = data["appid"] as? String ?? ""
            response.partnerid = data["partnerid"] as? String ?? ""
            response.prepayid = data["prepayid"] as? String ?? ""
            response.package = data["package"] as? String ?? ""
            response.noncestr = data["noncestr"] as? String ?? ""
            response.timestamp = data["timestamp"] as? uint ?? 0
            response.sign = data["sign"] as? String ?? ""
        }
        return response
    }
}
// MARK: - ResponseUpdateAcceptStatusModel 4003 预支付
open class ResponseUpdateAcceptStatusModel: ResponseBaseModel {
    class func parseJson(_ dict: NSDictionary) -> ResponseUpdateAcceptStatusModel {
        let response = ResponseUpdateAcceptStatusModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        return response
    }
}
// MARK: - ResponseUpdateRefuseStatusModel 4003 预支付
open class ResponseUpdateRefuseStatusModel: ResponseBaseModel {
    class func parseJson(_ dict: NSDictionary) -> ResponseUpdateRefuseStatusModel {
        let response = ResponseUpdateRefuseStatusModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        return response
    }
}
open class AcceptOrderUsersModel : NSObject {
    open var state: Int!
    open var order_id: Int!
    open var order_time: Int!
    open var order_addr: String!
    open var order_desc: String!
    open var money: Int!
    open var to_user_id: Int!
    open var to_name: String!
    open var to_sex: Int!
    open var to_birthday: Int!//生日
    open var to_age: String!//生日
    open var to_job: String!//职业
    open var to_heads: String! //头像地址（多个地址）
    open var to_signature: String! //个性签名
}
// MARK: - ResponseAcceptOrderUsersModel 4003 预支付
open class ResponseAcceptOrderUsersModel: ResponseBaseModel {
    open var users:[AcceptOrderUsersModel]!
    class func parseJson(_ dict: NSDictionary) -> ResponseAcceptOrderUsersModel {
        let response = ResponseAcceptOrderUsersModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        if let data = dict.object(forKey: "data") as? NSDictionary ,let users = data.object(forKey: "users") as? [NSDictionary] {
            var array = [AcceptOrderUsersModel]()
            for item in users {
                let model = AcceptOrderUsersModel()
                model.state = item["state"] as? Int ?? 0
                model.order_id = item["order_id"] as? Int ?? 0
                model.order_time = item["order_time"] as? Int ?? 0
                model.order_addr = item["order_addr"] as? String ?? ""
                model.order_desc = item["order_desc"] as? String ?? ""
                model.money = item["money"] as? Int ?? 0
                model.to_user_id = item["to_user_id"] as? Int ?? 0
                model.to_name = item["to_name"] as? String ?? ""
                model.to_sex = item["to_sex"] as? Int ?? 0
                model.to_birthday = item["to_birthday"] as? Int ?? 0
                model.to_age = UserAccount.ageWithDateOfBirth((item["to_birthday"] as? TimeInterval)!)
                model.to_job = item["to_job"] as? String ?? ""
                model.to_heads = item["to_heads"] as? String ?? ""
                model.to_signature = item["to_signature"] as? String ?? ""
                array.append(model)
            }
            response.users = array
        }else{
            response.users = [AcceptOrderUsersModel]()
        }
        return response
    }
}
// MARK: - ResponseAgreeMeetBothModel 4003 预支付
open class ResponseAgreeMeetBothModel: ResponseBaseModel {
    class func parseJson(_ dict: NSDictionary) -> ResponseAgreeMeetBothModel {
        let response = ResponseAgreeMeetBothModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        return response
    }
}
// MARK: - ResponseCompareCipherModel 4003 预支付
open class ResponseCompareCipherModel: ResponseBaseModel {
    class func parseJson(_ dict: NSDictionary) -> ResponseCompareCipherModel {
        let response = ResponseCompareCipherModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        return response
    }
}
// MARK: - ResponseGetBoardDataModel
open class ResponseGetBoardDataModel: ResponseBaseModel {
    class func parseJson(_ dict: NSDictionary) -> ResponseGetBoardDataModel {
        let response = ResponseGetBoardDataModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        return response
    }
}
// MARK: - ResponseGetByToUserIdWithPageModel
open class ResponseGetByToUserIdWithPageModel: ResponseBaseModel {
    class func parseJson(_ dict: NSDictionary) -> ResponseGetByToUserIdWithPageModel {
        let response = ResponseGetByToUserIdWithPageModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        return response
    }
}
