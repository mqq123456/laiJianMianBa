//
//  UserAccountTool.swift
//  DS11WB
//
//  Created by xiaomage on 16/4/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

open class UserAccountViewModel {
    
    // MARK:- 将类设计成单例
    public static let standard : UserAccountViewModel = UserAccountViewModel()

    // MARK:- 定义属性
    public var account : UserAccount?
    
    // MARK:- 计算属性
    public var accountPath : String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accountPath as NSString).appendingPathComponent("account.plist")
    }
    public var isLogin : Bool {
        if account == nil {
            return false
        }
        return true
    }
    // MARK:- 重写init()函数
    public init () {
        // 1.从沙盒中读取中归档的信息
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
    }
    public func saveAccount(account: UserAccount) {
        // 4.将account对象保存
        NSKeyedArchiver.archiveRootObject(account, toFile: UserAccountViewModel.standard.accountPath)
        // 5.将account对象设置到单例对象中
        UserAccountViewModel.standard.account = account
    }
    public func deleteAccount() {
        let fileManager = FileManager.default
        try! fileManager.removeItem(atPath: UserAccountViewModel.standard.accountPath)
        // 5.将account对象设置到单例对象中
        UserAccountViewModel.standard.account = nil
    }
    
}
