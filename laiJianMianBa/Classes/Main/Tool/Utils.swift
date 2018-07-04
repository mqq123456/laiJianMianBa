//
//  Utils.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/18.
//  Copyright © 2016年 fundot. All rights reserved.
//

import Foundation
import UIKit
//import JMServicesKit
import SVProgressHUD
// MARK:- 应用常量
let APP_VERSION = "1.0"//应用版本号
let APP_DATA_VERSION = "1.0"//数据版本号
let APP_PLAT = "0"//平台IOS
let APP_CHANNEL = "appStore"//渠道名称
let WXPAY_URL = "pay/appweixin"


let wxAPPKEY = "wx248654a2abf7326d"
let wxSECRET = "d4624c36b6795d1d99dcf0547af5443d"

// MARK:- 通知常量
let WXPayNotification = NSNotification.Name(rawValue: "WXPayNotification")
let WXAuthNotification = NSNotification.Name(rawValue: "WXAuthNotification")
let OrderStatusChangeRefresh = NSNotification.Name(rawValue: "OrderStatusChangeRefresh")
let JMReloadList = NSNotification.Name(rawValue: "JMReloadList")
//func urlString(_ name: String)->NSString{return NSString.init(string: "jaiJianMianBa://"+name)}

// MARK:- RGB
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) ->(UIColor) { return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a) }
/// 男生和女生的色调
func globalColor() -> UIColor { if UserAccountViewModel.standard.account?.sex == 1 { return RGBA(r: 4, g: 190, b: 194, a: 1) } else { return RGBA(r: 255, g: 110, b: 141, a: 1) }}
// MARK:- Log
func FDLog<T> (_ message: T, file: String = #file, funcName: String = #function,lineNum: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName):(\(lineNum))- \(message)");
    #endif
}
func getLabelRect (text: NSString, fontSize: CGFloat) -> CGRect { let attributes = [NSFontAttributeName:UIFont.systemFont(ofSize:fontSize)]; let rect : CGRect = text.boundingRect(with: CGSize(width: screenW-100, height: 20), options: NSStringDrawingOptions.usesLineFragmentOrigin , attributes:attributes , context: nil); return rect }
// MARK:- 机型
let IS_IOS8 = (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0
let IS_IOS10 = (UIDevice.current.systemVersion as NSString).doubleValue >= 10.0
/**  iphone4 */
let IPHONE4 = (UIScreen.main.bounds.size.height == 480 ? true : false)
/**  iphone5 */
let IPHONE5 = (UIScreen.main.bounds.size.height == 568 ? true : false)
/**  iphone6 */
let IPhone6 = (UIScreen.main.bounds.size.height == 667 ? true : false)
/** iphone6P */
let IPhone6Plus = (UIScreen.main.bounds.size.height == 736 ? true : false)

// MARK:- 屏幕尺寸
let screenH = UIScreen.main.bounds.height 
let screenW = UIScreen.main.bounds.width
let startY = CGFloat(64)
// MARK:- 默认图片
let placehorder = UIImage(named: "placehorder")
// MARK:- 判断字符串是否为空
func trimString(str: String)->String{let nowStr = str.trimmingCharacters(in: NSCharacterSet.whitespaces)
    return nowStr}
// MARK:- 单例
private let sharedKraken = TheOneAndOnlyKraken()
class TheOneAndOnlyKraken {
    class var sharedInstance: TheOneAndOnlyKraken {
        return sharedKraken
    }
}

let LocationPoi = UserDefaults.standard.object(forKey: "LocationPoi") as? String ?? ""

func removeUserDefautKeys() {
    let userDefautKeys = ["latitude","longitude"]
    for item in userDefautKeys {
        UserDefaults.standard.removeObject(forKey: item)
    }
}
let isBoy: Bool = {
    if (UserAccountViewModel.standard.account?.sex == 1){
        return true
    } else {
        return false
    }
}()
func makeToast(_ toast: String) {
    SVProgressHUD.show(nil, status: toast)
}

func getOrderStatus(_ status: Int) -> String {
    
    if status == 1 {return "发布中"}
    if status == 2 { return "待挑选"}
    if status == 3 { return "无回应"}
    if status == 4 { return "已取消"}
    if status == 5 {return "待见面"}
    if status == 6 { return "待评价"}
    if status == 7 {return "未见面" }
    if status == 8 { return "已见面"}
    if status == 10 { return "待挑选"}
    if status == 11 { return "待见面"}
    if status == 12 { return "已拒绝"}
    if status == 13 { return "已过期"}
    if status == 14 { return "无回应"}
    return ""
}
func getTagsSelectedColor(_ index: Int) -> String {
    if index % 8 == 0 {return "36c5ff" }
    if index % 8 == 1 {return "ff6e8d"}
    if index % 8 == 2 {return "fea56a"}
    if index % 8 == 3 {return "dd6df9"}
    if index % 8 == 4 {return "6e94ff"}
    if index % 8 == 5 {return "51ca79"}
    if index % 8 == 6 {return "8283c6"}
    if index % 8 == 7 {return "c19275"}
    return "fff"
}


// MARK: - onceToken
public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform. or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
