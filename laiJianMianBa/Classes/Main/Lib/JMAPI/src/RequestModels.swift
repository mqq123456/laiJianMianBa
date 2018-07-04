//
//  RequestModels.swift
//  JMServicesKit
//
//  Created by HeQin on 16/12/26.
//  Copyright © 2016年 fundot. All rights reserved.
//

import Foundation

// MARK: - RequestUserLoginModel
open class RequestUserLoginModel: NSObject {
    private let type: String = "login_user"
    /** 用户ＩＤ 、或用户手机号或用户OPENID(wechat) */
    open var userkey: Int!
    /** 手机号 */
    open var phone: String!
    /** 极光推送ID */
    open var devtoken: String!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.userkey != nil {dict["userkey"] = self.userkey}
        if self.devtoken != nil {dict["devtoken"] = self.devtoken}
        if self.phone != nil {dict["phone"] = self.phone}
        return dict
    }
}
// MARK: - RequestUserDetailModel
open class RequestUserDetailModel: NSObject {
    private let type: String = "get_user"
    /** 用户ＩＤ 、或用户手机号或用户OPENID(wechat) */
    open var id: Int!
    /** 印象 */
    open var impress: Bool!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.id != nil {dict["id"] = self.id}
        if self.impress != nil {dict["impress"] = self.impress}
        return dict
    }
}
// MARK: - RequestUserRegisterModel
open class RequestUserRegisterModel: NSObject {
    private let type: String = "register_user"
    /** 用户手机号 */
    open var phone: String!
    /** 性别 */
    open var sex: Int!
    /** pushID */
    open var push_token: String!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.phone != nil {dict["phone"] = self.phone}
        if self.sex != nil {dict["sex"] = self.sex}
        if self.push_token != nil {dict["push_token"] = self.push_token}
        return dict
    }
    
}
// MARK: - RequestUserChangeModel
open class RequestUserChangeModel: NSObject {
    private let type: String = "update_user"
    /** 用户ＩＤ */
    open var userid: Int!
    /** 手机号 */
    open var phone: String!
    /** 用户名 */
    open var name: String!
    /** 用户头像 */
    open var heads: String!
    /** 性别 */
    open var sex: String!
    /** 兴趣（多个兴趣与,号分割） */
    open var interest: String!
    /** 职业 */
    open var job: String!
    /** 生日 */
    open var birthday: TimeInterval!
    /** openid */
    open var openid: String!
    /** 身高 */
    open var height: Int!
    /** 收入 */
    open var income: String!
    /** 个性签名 */
    open var signature: String!
    /** 微信号 */
    open var weixin: String!
    /** 城市code */
    open var citycode: String!
    /** 微信号 */
    open var company: String!
    /** 城市code */
    open var hometown: String!
    /** lat */
    open var lat: Int!
    /** lon */
    open var lon: Int!
    /** 行业 */
    open var area: String!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.userid != nil { dict["id"] = self.userid}
        if self.phone != nil {dict["phone"] = self.phone}
        if self.name != nil {dict["name"] = self.name}
        if self.heads != nil {dict["heads"] = self.heads}
        if self.sex != nil {dict["sex"] = self.sex}
        if self.interest != nil {dict["interest"] = self.interest}
        if self.job != nil {dict["job"] = self.job}
        if self.birthday != nil {dict["birthday"] = self.birthday}
        if self.openid != nil {dict["openid"] = self.openid}
        if self.height != nil {dict["height"] = self.height}
        if self.income != nil {dict["income"] = self.income}
        if self.signature != nil {dict["signature"] = self.signature}
        if self.weixin != nil {dict["weixin"] = self.weixin}
        if self.citycode != nil {dict["citycode"] = self.citycode}
        if self.company != nil {dict["company"] = self.company}
        if self.hometown != nil {dict["hometown"] = self.hometown}
        if self.area != nil {dict["area"] = self.area}
        if self.lat != nil {dict["lat"] = self.lat}
        if self.lon != nil {dict["lon"] = self.lon}
        return dict
    }
}

open class RequestSetUserImpressModel: NSObject {
    private let type: String = "set_user_impress"
    /** 用户ＩＤ  */
    open var userid: Int!
    /** orderid  */
    open var order_id: Int!
    /** 用户印象  */
    open var impress:[String] = []
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.userid != nil { dict["id"] = self.userid}
        if self.order_id != nil { dict["order_id"] = self.order_id}
        if self.impress.count != 0 {dict["impress"] = self.impress}
        return dict
    }
}

// MARK: - RequestSendDateModel
open class RequestSendDateModel: NSObject {
    private let type: String = "create_order"
    /** 用户ＩＤ  */
    open var user_id: Int!
    /** 时间 */
    open var time: TimeInterval!
    /** 位置 */
    open var addr: String!
    /** 坐标 */
    open var lon: Int!
    /** 坐标 */
    open var lat: Int!
    /** 红包额 */
    open var money: Int!
    /** 描述（见面做什么） */
    open var desc: String!
    /** 发起人电话 */
    open var from_phone: String!
    /** 发起人微信号 */
    open var from_weixin: String!
    /** 发起人性别：男1女2 */
    open var from_sex: Int!
    
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.user_id != nil { dict["user_id"] = self.user_id}
        if self.time != nil {dict["time"] = self.time}
        if self.addr != nil {dict["addr"] = self.addr}
        if self.lon != nil {dict["lon"] = self.lon}
        if self.lat != nil {dict["lat"] = self.lat}
        if self.money != nil {dict["money"] = self.money}
        if self.desc != nil {dict["desc"] = self.desc}
        if self.from_phone != nil {dict["from_phone"] = self.from_phone}
        if self.from_weixin != nil {dict["from_weixin"] = self.from_weixin}
        if self.from_sex != nil {dict["from_sex"] = self.from_sex}
        return dict
    }
}
open class RequestSendOrderListModel: NSObject {
    private let type: String = "get_send_orders"
    /** 用户ＩＤ  */
    open var user_id: Int!
    open var page_index: Int!
    private var page_count: Int = 10
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        dict["page_count"] = self.page_count
        if self.user_id != nil { dict["user_id"] = self.user_id}
        if self.page_index != nil {dict["page_index"] = self.page_index}
        return dict
    }
}

// MARK: - RequestReceivedInvitationModel
open class RequestReceivedInvitationModel: NSObject {
    private let type: String = "get_received_orders"
    /** 用户ID */
    open var to_user_id: Int!
    open var page_index: Int!
    private var page_count: Int = 10
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        dict["page_count"] = self.page_count
        if self.to_user_id != nil { dict["to_user_id"] = self.to_user_id}
        if self.page_index != nil {dict["page_index"] = self.page_index}
        return dict
    }
    
}
// MARK: - RequestOrderDetailModel
open class RequestOrderDetailModel: NSObject {
    private let type: String = "get_order_detail"
    /** 订单ID */
    open var order_id: Int!
    /** 订单ID */
    open var user_id: Int!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.order_id != nil { dict["order_id"] = self.order_id}
        if self.user_id != nil { dict["user_id"] = self.user_id}
        return dict
    }
    
}
// MARK: - RequestMissPeopleModel
open class RequestMissPeopleModel: NSObject {
    private let type: String = "login_user"
    open var userid: String!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.userid != nil { dict["userid"] = self.userid}
        return dict
    }
    
}

// MARK: - RequestReadyPayModel
open class RequestReadyPayModel: NSObject {
    private let type: String = "get_pay_params_by_order"
    /** 支付唯一号（防重复） */
    open var id: Int!
    /** 金额 */
    let spbill_create_ip = "123.57.218.66"
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        dict["spbill_create_ip"] = self.spbill_create_ip
        if self.id != nil { dict["id"] = self.id}
        return dict
    }
    
}

// MARK: - RequestUpdateAcceptStatusModel
open class RequestUpdateAcceptStatusModel: NSObject {
    private let type: String = "update_accept_status"
    /** 订单ID */
    open var order_id: Int!
    /** 用户ID */
    open var user_id: Int!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.order_id != nil { dict["order_id"] = self.order_id}
        if self.user_id != nil { dict["user_id"] = self.user_id}
        return dict
    }
}
// MARK: - RequestUpdateRefuseStatusModel
open class RequestUpdateRefuseStatusModel: NSObject {
    private let type: String = "update_refuse_status"
    /** 订单ID */
    open var order_id: Int!
    /** 用户ID */
    open var user_id: Int!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.order_id != nil { dict["order_id"] = self.order_id}
        if self.user_id != nil { dict["user_id"] = self.user_id}
        return dict
    }
}
// MARK: - RequestAcceptOrderUsersModel
open class RequestAcceptOrderUsersModel: NSObject {
    private let type: String = "get_accept_order_users"
    /** 订单ID */
    open var order_id: Int!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.order_id != nil { dict["order_id"] = self.order_id}
        return dict
    }
}
// MARK: - RequestAcceptOrderUsersModel
open class RequestAgreeMeetBothModel: NSObject {
    private let type: String = "agree_meet_both"
    /** 订单ID */
    open var order_id: Int!
    /** 被邀请人user_id */
    open var to_user_id: Int!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.order_id != nil { dict["order_id"] = self.order_id}
        if self.to_user_id != nil { dict["to_user_id"] = self.to_user_id}
        return dict
    }
}
// MARK: - RequestAcceptOrderUsersModel
open class RequestCompareCipherModel: NSObject {
    private let type: String = "compare_cipher"
    /** 订单ID */
    open var order_id: Int!
    /** 暗号 */
    open var cipher: String!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.order_id != nil { dict["order_id"] = self.order_id}
        if self.cipher != nil { dict["cipher"] = self.cipher}
        return dict
    }
}
// MARK: - RequestGetBoardDataModel
open class RequestGetBoardDataModel: NSObject {
    private let type: String = "get_board_data"
    /** 订单ID */
    open var sex: Int!
    /** 经纬度 */
    open var lat: Int!
    open var lon: Int!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.sex != nil { dict["sex"] = self.sex}
        if self.lat != nil { dict["lat"] = self.lat}
        if self.lon != nil { dict["lon"] = self.lon}
        return dict
    }
}
// MARK: - RequestGetBoardDataModel
open class RequestGetByToUserIdWithPageModel: NSObject {
    private let type: String = "get_random_invite"
    /** 订单ID */
    open var to_user_id: Int!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.to_user_id != nil { dict["to_user_id"] = self.to_user_id}
        return dict
    }
}
// MARK: - RequestGetImpressModel
open class RequestGetImpressModel: NSObject {
    private let type: String = "get_impress"
    /** 性别 */
    open var sex: Int!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.sex != nil { dict["sex"] = self.sex}
        return dict
    }
}

// MARK: - RequestSetPhotoMatchModel
open class RequestSetPhotoMatchModel: NSObject {
    private let type: String = "set_photo_match"
    open var order_id: Int!
    open var from_user_id: Int!
    open var to_user_id: Int!
    open var photo_match: Int!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.order_id != nil { dict["order_id"] = self.order_id}
        if self.from_user_id != nil { dict["from_user_id"] = self.from_user_id}
        if self.to_user_id != nil { dict["to_user_id"] = self.to_user_id}
        if self.photo_match != nil { dict["photo_match"] = self.photo_match}
        return dict
    }
}

// MARK: - RequestSetPhotoMatchModel
open class RequestUpdateOrderStateMeetedModel: NSObject {
    private let type: String = "update_order_state_meeted"
    open var order_id: Int!
    open var user_id: Int!
    func parseData() -> [String : Any] {
        var dict =  [String : Any]()
        dict["type"] = self.type
        if self.order_id != nil { dict["order_id"] = self.order_id}
        if self.user_id != nil { dict["user_id"] = self.user_id}
        return dict
    }
}
