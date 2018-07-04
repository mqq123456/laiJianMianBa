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
open class DateList : OrderModel{
    open var from_sex: Int!
    open var to_peoples: Int!
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
                joinList.orderid = dict["id"] as? Int ?? 0
                joinList.from_uid = dict["user_id"] as? Int ?? 0
                joinList.money = dict["money"] as? Int ?? 0
                joinList.address_lat = dict["lat"] as? Int ?? 0
                joinList.address_lon = dict["lon"] as? Int ?? 0
                joinList.order_time = dict["time"] as? TimeInterval ?? 0
                joinList.order_time_string = UserAccount.createDateString(joinList.order_time)
                joinList.address = dict["addr"] as? String ?? ""
                joinList.des = dict["desc"] as? String ?? ""
                joinList.state = dict["state"] as? Int ?? 0
                joinList.from_sex = UserAccountViewModel.standard.account?.sex
                joinList.cipher = dict["cipher"] as? String ?? ""
                joinList.to_peoples = dict["to_peoples"] as? Int ?? 0
                joinList.to_uid = dict["to_user_id"] as? Int ?? 0
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

// MARK: - OrderModel
open class OrderModel: NSObject {
    /** 订单状态 */
    open var state: Int!
    /** 订单发起用户的id */
    open var from_uid: Int!
    /** 订单接收人的id */
    open var to_uid: Int!
    /** 订单描述。吃个饭，喝个咖啡 */
    open var des: String!
    /** 订单经纬度 */
    open var address_lat: Int!
    open var address_lon: Int!
    /** 订单地址 */
    open var address: String!
    /** 订单id */
    open var orderid: Int!
    /** 订单时间 */
    open var order_time: TimeInterval!
    /** money */
    open var money: Int!
    /** 订单时间string */
    open var order_time_string: String!
    /** 订单暗号 */
    open var cipher: String!
}
// MARK: - ResponseOrderDetailModel
open class ResponseOrderDetailModel: ResponseBaseModel {
    open var order: OrderModel!
    class func parseJson(_ dict: NSDictionary) -> ResponseOrderDetailModel {
        let response = ResponseOrderDetailModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        if let data = dict.object(forKey: "data") as? NSDictionary {
            let order = OrderModel()
            order.state = data["state"] as? Int ?? 0
            order.from_uid = data["user_id"] as? Int ?? 0
            order.to_uid = data["to_user_id"] as? Int ?? 0
            order.des = data["desc"] as? String ?? ""
            order.address_lat = data["lat"] as? Int ?? 0
            order.address_lon = data["lon"] as? Int ?? 0
            order.address = data["addr"] as? String ?? ""
            order.orderid = data["id"] as? Int ?? 0
            order.order_time = data["time"] as? TimeInterval ?? 0
            order.order_time_string = UserAccount.createDateString(order.order_time)
            order.cipher = data["cipher"] as? String ?? ""
            order.money = data["money"] as? Int ?? 0
            response.order = order
            
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
open class ReceivedUserModel : OrderModel {
    /** 发单方信息 */
    open var from_sex: Int!
    open var from_avatar: String!
    open var from_birthday: Int!
    open var from_job: String!
    open var from_name: String!
    open var from_age: String!
}
// MARK: - ResponseReceivedInvitationModel
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
                joinList.orderid = dict["order_id"] as? Int ?? 0
                joinList.order_time = dict["order_time"] as? TimeInterval ?? 0
                joinList.order_time_string = UserAccount.createDateString(joinList.order_time)
                joinList.address = dict["order_addr"] as? String ?? ""
                joinList.des = dict["order_desc"] as? String ?? ""
                joinList.from_uid = dict["from_user_id"] as? Int ?? 0
                joinList.from_name = dict["name"] as? String ?? ""
                joinList.to_uid = UserAccountViewModel.standard.account?.uId
                joinList.money = dict["money"] as? Int ?? 0
                joinList.state = dict["state"] as? Int ?? 0
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

// MARK: - ResponseReadyPayModel
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
            response.package = data["packager"] as? String ?? ""
            response.noncestr = data["noncestr"] as? String ?? ""
            response.timestamp = data["timestamp"] as? uint ?? 0
            response.sign = data["sign"] as? String ?? ""
        }
        return response
    }
}
// MARK: - ResponseUpdateAcceptStatusModel
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
open class AcceptOrderUsersModel : OrderModel {
    open var to_name: String!
    open var to_sex: Int!
    open var to_birthday: Int!//生日
    open var to_age: String!//生日
    open var to_job: String!//职业
    open var to_heads: String! //头像地址（多个地址）
    open var to_signature: String! //个性签名
}
// MARK: - ResponseAcceptOrderUsersModel
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
                model.orderid = item["order_id"] as? Int ?? 0
                model.order_time = item["order_time"] as? TimeInterval ?? 0
                model.address = item["order_addr"] as? String ?? ""
                model.des = item["order_desc"] as? String ?? ""
                model.money = item["money"] as? Int ?? 0
                model.to_uid = item["to_user_id"] as? Int ?? 0
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
// MARK: - ResponseAgreeMeetBothModel
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
// MARK: - ResponseCompareCipherModel
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

open class HomeUsers: NSObject {
    open var male_name: String!
    open var female_name: String!
    open var money: Int!
}
open class HomeHeads: NSObject {
    open var head: String!
    open var lat: Double!
    open var lon: Double!
}
// MARK: - ResponseGetBoardDataModel
open class ResponseGetBoardDataModel: ResponseBaseModel {
    open var users:[HomeUsers]!
    open var heads:[HomeHeads]!
    class func parseJson(_ dict: NSDictionary) -> ResponseGetBoardDataModel {
        let response = ResponseGetBoardDataModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        if let data = dict.object(forKey: "data") as? NSDictionary ,let users = data.object(forKey: "users") as? [NSDictionary],let heads = data.object(forKey: "heads") as? [NSDictionary] {
            var array = [HomeUsers]()
            for item in users {
                let model = HomeUsers()
                let male_name = item["male_name"] as? String ?? ""
                var male_a = String()
                for i in 0 ..< male_name.characters.count {
                    if i == 0 {
                        male_a.append(male_name.characters.first!)
                    }else if i == male_name.characters.count - 1 {
                        male_a.append(male_name.characters.last!)
                    }else{
                        male_a.append("*")
                    }
                }
                model.male_name = item["male_name"] as? String ?? ""
                model.female_name = item["female_name"] as? String ?? ""
                model.money = item["money"] as? Int ?? 0
                array.append(model)
            }
            response.users = array
            var headArray = [HomeHeads]()
            for item in heads {
                let model = HomeHeads()
                model.head = item["head"] as? String ?? ""
                model.lat = Double(item["lat"] as? Double ?? 0)/1e6
                model.lon = Double(item["lon"] as? Double ?? 0)/1e6
                headArray.append(model)
            }
            response.heads = headArray
        }else{
            response.users = [HomeUsers]()
            response.heads = [HomeHeads]()
        }
        return response
    }
}
open class GetByToUserIdWithPageOrderModel: OrderModel {
    open var heads: String!
    open var name: String!
    open var birthday: Int!
    open var job: String!
    open var signature: String!
    open var from_sex: Int!
}
// MARK: - ResponseGetByToUserIdWithPageModel
open class ResponseGetByToUserIdWithPageModel: ResponseBaseModel {
    open var order: GetByToUserIdWithPageOrderModel!
    class func parseJson(_ dict: NSDictionary) -> ResponseGetByToUserIdWithPageModel {
        let response = ResponseGetByToUserIdWithPageModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        if let data = dict.object(forKey: "data") as? NSDictionary ,let order = data.object(forKey: "order") as? NSDictionary {
            let model = GetByToUserIdWithPageOrderModel()
            model.orderid = order["order_id"] as? Int ?? 0
            model.order_time = order["order_time"] as? TimeInterval ?? 0
            model.order_time_string = UserAccount.createDateString(model.order_time)
            model.address = order["order_addr"] as? String ?? ""
            model.des = order["order_desc"] as? String ?? ""
            model.money = order["money"] as? Int ?? 0
            model.state = order["state"] as? Int ?? 0
            model.heads = (order["heads"] as? String ?? "").components(separatedBy: ",").first
            model.name = order["name"] as? String ?? ""
            model.birthday = order["birthday"] as? Int ?? 0
            model.job = order["job"] as? String ?? ""
            model.signature = order["signature"] as? String ?? ""
            model.from_sex = order["from_sex"] as? Int ?? 0
            response.order = model
        }else{
            response.order = nil
        }
        return response
    }
}
// MARK: - ImpressModel
open class ImpressModel: NSObject {
    open var impress: String!
    open var sex: Int!
    open var id: Int!
    open var impress_color: String!
    open var isSelected: Bool!
    open var selected_color: String!
}

// MARK: - ResponseGetImpressModel
open class ResponseGetImpressModel: ResponseBaseModel {
    open var impress: [ImpressModel]!
    class func parseJson(_ dict: NSDictionary) -> ResponseGetImpressModel {
        let response = ResponseGetImpressModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        if let data = dict.object(forKey: "data") as? [NSDictionary] {
            var impressArray = [ImpressModel]()
            var i = 0
            for item in data {
                let impress = ImpressModel()
                impress.id = item["id"] as? Int ?? 0
                impress.sex = item["sex"] as? Int ?? 0
                impress.impress = item["impress"] as? String ?? ""
                impress.isSelected = false
                impress.selected_color = getTagsSelectedColor(i)
                impressArray.append(impress)
                i += 1
            }
            response.impress = impressArray
        }else{
            response.impress = [ImpressModel]()
        }
        return response
    }
}
// MARK: - ResponseSetPhotoMatchModel
open class ResponseSetPhotoMatchModel: ResponseBaseModel {
    class func parseJson(_ dict: NSDictionary) -> ResponseSetPhotoMatchModel {
        let response = ResponseSetPhotoMatchModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        return response
    }
}

// MARK: - ResponseUpdateOrderStateMeetedModel
open class ResponseUpdateOrderStateMeetedModel: ResponseBaseModel {
    class func parseJson(_ dict: NSDictionary) -> ResponseUpdateOrderStateMeetedModel {
        let response = ResponseUpdateOrderStateMeetedModel()
        response.status = dict.object(forKey: "status") as! String!
        if response.status != "ok" {
            response.message = dict.object(forKey: "message") as? String ?? ""
            return response
        }
        return response
    }
}
