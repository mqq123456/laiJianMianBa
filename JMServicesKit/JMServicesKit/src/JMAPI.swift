//
//  JMAPI.swift
//  JMServicesKit
//
//  Created by HeQin on 16/12/22.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
import Foundation

// MARK: - JMAPI
open class JMAPI: NSObject {
    /// 协议
    weak open var delegate: JMAPIDelegate?
    /// 超时时间
    open var timeout: NSInteger?
    /// 取消请求
    open func cancelAllRequests()  {
        
    }
// MARK: - 用户相关
    /// 用户登陆
    ///
    /// - Parameter request: 参数模型
    open func jmGetUserLogin(_ request: RequestUserLoginModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseUserLoginModel.parseJson(resp as NSDictionary)
            self.delegate?.jmGetUserLoginDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
    }
    /// 用户详情
    ///
    /// - Parameter request: 参数模型
    open func jmGetUserDetail(_ request: RequestUserDetailModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseUserDetailModel.parseJson(resp as NSDictionary)
            self.delegate?.jmGetUserDetailDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
    }
    /// 添加用户
    ///
    /// - Parameter request: 参数模型
    open func jmUserRegister(_ request: RequestUserRegisterModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseUserRegisterModel.parseJson(resp as NSDictionary)
            self.delegate?.jmUserRegisterDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
    }
    
    /// 用户信息修改
    ///
    /// - Parameter request: 参数模型
    open func jmUserChange(_ request: RequestUserChangeModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseUserChangeModel.parseJson(resp as NSDictionary)
            self.delegate?.jmUserChangeDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
    }
    
    
    /// 设置用户印象
    ///
    /// - Parameter request: 参数模型
    open func jmSetUserImpress(_ request: RequestSetUserImpressModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseSetUserImpressModel.parseJson(resp as NSDictionary)
            self.delegate?.jmSetUserImpressDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
    }
    
    
// MARK: - 业务相关
    /// 发起约会
    ///
    /// - Parameter request: 参数模型
    open func jmbSendDate(_ request: RequestSendDateModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseSendDateModel.parseJson(resp as NSDictionary)
            self.delegate?.jmSendDateDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
    }
    /// 获取发起的订单列表
    ///
    /// - Parameter request: 参数模型
    open func jmSendOrderList(_ request: RequestSendOrderListModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseSendOrderListModel.parseJson(resp as NSDictionary)
            self.delegate?.jmSendOrderListDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
    }
    
    /// 3014 取订单详情
    ///
    /// - Parameter request: 参数模型
    open func jmmOrderDetail(_ request: RequestOrderDetailModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseOrderDetailModel.parseJson(resp as NSDictionary)
            self.delegate?.jmOrderDetailDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
    }
    
    /// 3015 取错过的约会列表
    ///
    /// - Parameter request: 参数模型
    open func jmmMissPeople(_ request: RequestMissPeopleModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseMissPeopleModel.parseJson(resp as NSDictionary)
            self.delegate?.jmMissPeopleDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
    }
    
    /// 我收到的邀请列表
    ///
    /// - Parameter request: 参数模型
    open func jmmReceivedInvitation(_ request: RequestReceivedInvitationModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseReceivedInvitationModel.parseJson(resp as NSDictionary)
            self.delegate?.jmReceivedInvitationDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
    }
    
    /// 吊起微信支付
    ///
    /// - Parameter request: 请求参数
    open func jmReadyPay(_ request: RequestReadyPayModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseReadyPayModel.parseJson(resp as NSDictionary)
            self.delegate?.jmReadyPayDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }

    }
    
    /// 见
    ///
    /// - Parameter request: 请求参数
    open func jmUpdateAcceptStatus(_ request: RequestUpdateAcceptStatusModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseUpdateAcceptStatusModel.parseJson(resp as NSDictionary)
            self.delegate?.jmUpdateAcceptStatusDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
        
    }
    
    /// 不见
    ///
    /// - Parameter request: 请求参数
    open func jmUpdateRefuseStatus(_ request: RequestUpdateRefuseStatusModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseUpdateRefuseStatusModel.parseJson(resp as NSDictionary)
            self.delegate?.jmUpdateRefuseStatusDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
    }
    
    /// 获取接受邀请的人员
    ///
    /// - Parameter request: 请求参数
    open func jmAcceptOrderUsers(_ request: RequestAcceptOrderUsersModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseAcceptOrderUsersModel.parseJson(resp as NSDictionary)
            self.delegate?.jmAcceptOrderUsersDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
        
    }
    
    /// 就他了
    ///
    /// - Parameter request: 请求参数
    open func jmAgreeMeetBoth(_ request: RequestAgreeMeetBothModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseAgreeMeetBothModel.parseJson(resp as NSDictionary)
            self.delegate?.jmAgreeMeetBothDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
        
    }
    
    /// 输入暗号
    ///
    /// - Parameter request: 请求参数
    open func jmCompareCipher(_ request: RequestCompareCipherModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseCompareCipherModel.parseJson(resp as NSDictionary)
            self.delegate?.jmCompareCipherDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
        
    }
    /// 见面广场数据
    ///
    /// - Parameter request: 请求参数
    open func jmGetBoardData(_ request: RequestGetBoardDataModel) {
        let parse = request.parseData()
        print("request = \(JSON(parse))")
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: parse, success: { (resp) in
            let response = ResponseGetBoardDataModel.parseJson(resp as NSDictionary)
            self.delegate?.jmGetBoardDataDone!(request: request, response: response)
        }) { (error) in
            print("error = \(error)")
            self.delegate?.jmRequestFail!(request, error: error as NSError)
        }
        
    }
}

