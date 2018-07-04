//
//  NetworkRequest.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/17.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit

private let NetworkRequestShareInstance = NetworkRequest()

open class NetworkRequest {
    open class var sharedInstance : NetworkRequest {
        return NetworkRequestShareInstance
    }
}
public extension NetworkRequest {
    
    //MARK: - POST 请求
    public func postRequest(urlString : String, params : [String : Any], success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "text/plain;text/json",
            "Accept": "application/json"
        ]
        request(urlString, method: .post, parameters: params,encoding: JSONEncoding(options: []), headers: headers)
            .validate(contentType: ["application/json", "text/json", "text/javascript","text/html","text/plain"])
            .responseJSON { (response) in
                switch response.result{
                case .success:
                    if let value = response.result.value as? [String: AnyObject] {
                        let json = JSON(value)
                        #if DEBUG//处于开发阶段
                            print("response = \(json)" )
                        #else//处于发布阶段
                            
                        #endif
                        success(value)
                                            }
                case .failure(let error):
                    failture(error)
                    //print("error:\(error)")
                }
                
        }
    }

}
