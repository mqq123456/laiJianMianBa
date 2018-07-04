//
//  JMAPIDelegate.swift
//  JMServicesKit
//
//  Created by HeQin on 17/1/20.
//  Copyright © 2017年 fundot. All rights reserved.
//

import Foundation
import UIKit

// MARK: - JMAPIDelegate
@objc public protocol JMAPIDelegate: NSObjectProtocol {
    
    /// 请求失败的统一回调
    ///
    /// - Parameter request: 失败对应的请求参数模型
    @objc optional func jmRequestFail(_ request: Any, error: NSError)
    /// 用户登陆
    ///
    /// - Parameters:
    ///   - request: RequestUserLoginModel
    ///   - response: ResponseUserLoginModel
    @objc optional func jmGetUserLoginDone(request: RequestUserLoginModel, response: ResponseUserLoginModel)
    /// 获取用户详情回调
    ///
    /// - Parameters:
    ///   - request: RequestUserDetailModel
    ///   - response: ResponseUserDetailModel
    @objc optional func jmGetUserDetailDone(request: RequestUserDetailModel, response: ResponseUserDetailModel)
    /// 添加用户回调
    ///
    /// - Parameters:
    ///   - request: RequestUserRegisterModel
    ///   - response: ResponseUserRegisterModel
    @objc optional func jmUserRegisterDone(request: RequestUserRegisterModel, response: ResponseUserRegisterModel)
    
    /// 用户信息修改
    ///
    /// - Parameters:
    ///   - request: RequestUserChangeModel
    ///   - response: ResponseUserChangeModel
    @objc optional func jmUserChangeDone(request: RequestUserChangeModel, response: ResponseUserChangeModel)
    
    /// 设置用户印象
    ///
    /// - Parameters:
    ///   - request: RequestSetUserImpressModel
    ///   - response: ResponseSetUserImpressModel
    @objc optional func jmSetUserImpressDone(request: RequestSetUserImpressModel, response: ResponseSetUserImpressModel)
    
    
    
    // MARK: - 业务相关
    
    /// 发起约会回调
    ///
    /// - Parameters:
    ///   - request: RequestSendDateModel
    ///   - response: ResponseSendDateModel
    @objc optional func jmSendDateDone(request: RequestSendDateModel, response: ResponseSendDateModel)
    
    /// 创建约会列表
    ///
    /// - Parameters:
    ///   - request: RequestSendOrderListModel
    ///   - response: ResponseSendOrderListModel
    @objc optional func jmSendOrderListDone(request: RequestSendOrderListModel, response: ResponseSendOrderListModel)

    /// 订单详情
    ///
    /// - Parameters:
    ///   - request: RequestOrderDetailModel
    ///   - response: ResponseOrderDetailModel
    @objc optional func jmOrderDetailDone(request: RequestOrderDetailModel, response: ResponseOrderDetailModel)
    
    /// 错过的约会
    ///
    /// - Parameters:
    ///   - request: RequestMissPeopleModel
    ///   - response: ResponseMissPeopleModel
    @objc optional func jmMissPeopleDone(request: RequestMissPeopleModel, response: ResponseMissPeopleModel)
    
    /// 我收到的邀请列表
    ///
    /// - Parameters:
    ///   - request: RequestReceivedInvitationModel
    ///   - response: ResponseReceivedInvitationModel
    @objc optional func jmReceivedInvitationDone(request: RequestReceivedInvitationModel, response: ResponseReceivedInvitationModel)
    
    /// 预支付
    ///
    /// - Parameters:
    ///   - request: RequestReadyPayModel
    ///   - response: ResponseReadyPayModel
    @objc optional func jmReadyPayDone(request: RequestReadyPayModel, response: ResponseReadyPayModel)
    
    /// 加参数列表
    ///
    /// - Parameters:
    ///   - request: RequestUpdateAcceptStatusModel
    ///   - response: ResponseUpdateAcceptStatusModel
    @objc optional func jmUpdateAcceptStatusDone(request: RequestUpdateAcceptStatusModel, response: ResponseUpdateAcceptStatusModel)
    
    /// 评价tags
    ///
    /// - Parameters:
    ///   - request: RequestUpdateRefuseStatusModel
    ///   - response: ResponseUpdateRefuseStatusModel
    @objc optional func jmUpdateRefuseStatusDone(request: RequestUpdateRefuseStatusModel, response: ResponseUpdateRefuseStatusModel)
    
    /// 评价tags
    ///
    /// - Parameters:
    ///   - request: RequestAcceptOrderUsersModel
    ///   - response: ResponseAcceptOrderUsersModel
    @objc optional func jmAcceptOrderUsersDone(request: RequestAcceptOrderUsersModel, response: ResponseAcceptOrderUsersModel)
    
    /// 评价tags
    ///
    /// - Parameters:
    ///   - request: RequestAgreeMeetBothModel
    ///   - response: ResponseAgreeMeetBothModel
    @objc optional func jmAgreeMeetBothDone(request: RequestAgreeMeetBothModel, response: ResponseAgreeMeetBothModel)
    
    /// 评价tags
    ///
    /// - Parameters:
    ///   - request: RequestCompareCipherModel
    ///   - response: ResponseCompareCipherModel
    @objc optional func jmCompareCipherDone(request: RequestCompareCipherModel, response: ResponseCompareCipherModel)
    
    /// 评价tags
    ///
    /// - Parameters:
    ///   - request: RequestGetBoardDataModel
    ///   - response: ResponseGetBoardDataModel
    @objc optional func jmGetBoardDataDone(request: RequestGetBoardDataModel, response: ResponseGetBoardDataModel)
    
    /// 评价tags
    ///
    /// - Parameters:
    ///   - request: RequestGetByToUserIdWithPageModel
    ///   - response: ResponseGetByToUserIdWithPageModel
    @objc optional func jmGetByToUserIdWithPageDone(request: RequestGetByToUserIdWithPageModel, response: ResponseGetByToUserIdWithPageModel)
    
    
}
