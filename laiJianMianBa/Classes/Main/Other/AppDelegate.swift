//
//  AppDelegate.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/16.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
//import JMServicesKit
import SVProgressHUD
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,AppStartViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        self.window?.frame = UIScreen.main.bounds
        self.window?.makeKeyAndVisible()
        rootViewController()
        IQKeyboardManager.sharedManager().enable = true
        //初始化SMSSDK，appKey和appSecret从后台申请得
        SMSSDK.registerApp("1a4889f165b24", withSecret: "c3979484ff4476dd365f5e7bc38bcff9")
        AMapServices.shared().apiKey = "f9765048af7704788ae090803c6fe3c4"
        WXApi.registerApp("wx248654a2abf7326d", withDescription: "来见面吧")
        initJPush(launchOptions)
        SVProgressHUD.setCornerRadius(5.0)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor(white: 0, alpha: 0.8))
        SVProgressHUD.setOffsetFromCenter(UIOffsetMake(0, UIScreen.main.bounds.size.height/2 - 50))
        return true
    }
 
    private func rootViewController() {
        if ez.appVersion == UserDefaults.standard.object(forKey: "appVersion") as? String {
            if (UserAccountViewModel.standard.isLogin) {
                self.window?.rootViewController = RootNavigationController(rootViewController: HomeViewController())
            } else {
                self.window?.rootViewController = RootNavigationController(rootViewController: SexViewController())
            }
        }else{
            let start = AppStartViewController()
            start.delegate = self
            self.window?.rootViewController = start
        }
    }
    func didStartApp() {
        rootViewController()
    }
    // 重写AppDelegate的handleOpenURL和openURL方法：
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) {}
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(.newData)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        JPUSHService.handleRemoteNotification(userInfo)
    }
}

// MARK: - WXApiDelegate
extension AppDelegate: WXApiDelegate{
    func onReq(_ req: BaseReq!) {
        FDLog(req)
    }
    func onResp(_ resp: BaseResp!) {
        FDLog("微信回调\(resp)")
        var errStr = ""
        if resp.errStr != nil {
            errStr = resp.errStr!
        }
        let errCode = resp.errCode
        let type = resp.type
        
        if let authResp =  resp as? SendAuthResp {
            // 说明是微信授权
            let code = authResp.code
            NotificationCenter.default.post(name: WXAuthNotification, object: self, userInfo: ["errStr": errStr,"errCode": errCode,"type": type, "code": code ?? ""])
            
        }else{
            NotificationCenter.default.post(name: WXPayNotification, object: self, userInfo: ["errStr": errStr,"errCode": errCode,"type": type])
        }
    }
}

// MARK: - JPUSHRegisterDelegate

extension AppDelegate: JPUSHRegisterDelegate {
    func initJPush(_ launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        if #available(iOS 10.0, *){
            let entiity = JPUSHRegisterEntity()
            entiity.types = Int(UNAuthorizationOptions.alert.rawValue |
                UNAuthorizationOptions.badge.rawValue |
                UNAuthorizationOptions.sound.rawValue)
            JPUSHService.register(forRemoteNotificationConfig: entiity, delegate: self)
        } else if #available(iOS 8.0, *) {
            let types = UIUserNotificationType.badge.rawValue |
                UIUserNotificationType.sound.rawValue |
                UIUserNotificationType.alert.rawValue
            JPUSHService.register(forRemoteNotificationTypes: types, categories: nil)
        }else {
            let type = UIRemoteNotificationType.badge.rawValue |
                UIRemoteNotificationType.sound.rawValue |
                UIRemoteNotificationType.alert.rawValue
            JPUSHService.register(forRemoteNotificationTypes: type, categories: nil)
        }
        
        JPUSHService.setup(withOption: launchOptions,
                           appKey: "1b8c0099dc6ae1cdf4e873b0",
                           channel: "app store",
                           apsForProduction: false)
    }
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        print(">JPUSHRegisterDelegate jpushNotificationCenter willPresent");
        let userInfo = notification.request.content.userInfo
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler(Int(UNAuthorizationOptions.alert.rawValue))// 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        print(">JPUSHRegisterDelegate jpushNotificationCenter didReceive");
        let userInfo = response.notification.request.content.userInfo
        self.window?.rootViewController?.present(InvitationViewController(), animated: false, completion: nil)
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler()
    }
}
