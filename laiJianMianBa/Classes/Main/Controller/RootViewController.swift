//
//  RootViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/19.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class RootViewController: UIViewController {
    /// 跳转的值传递，因为通知有很多，这里为了方便使用
    public var ext: NSDictionary!
    /// 定义全局的请求api
    public lazy var api: JMAPI = {
        let api = JMAPI()
        api.delegate = self
        return api
    }()
    public lazy var activityView: UIActivityIndicatorView = {
        let activityview = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityview.frame = CGRect(x: self.view.centerX, y: self.view.centerY, w: 30, h: 30)
        activityview.center = self.view.center
        activityview.color = UIColor.gray
        activityview.hidesWhenStopped = true
        self.view.addSubview(activityview)
        return activityview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension RootViewController: JMAPIDelegate {
    func jmRequestFail(_ request: Any, error: NSError) {
        FDLog(error)
        self.activityView.stopAnimating()
    }
}
extension RootViewController {
    // MARK: - 根据规定的字符串跳转
    public func push(_ url: NSString, ext: NSDictionary) {
        if url.hasPrefix("jaiJianMianBa://") {
            // 0.获取命名空间
            guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
                FDLog("没有获得命名空间")
                return
            }
            
            let head = url.components(separatedBy: "jaiJianMianBa://") as NSArray
            guard head.count>1 else {
                return
            }
            let name = head[1] as! String
            
            // 1.根据字符串获取对应的Class
            guard let ChildVcClass = NSClassFromString(nameSpace + "." + name + "ViewController") else {
                FDLog("没有获取到字符串对应的Class")
                return
            }
            
            // 2.将对应的AnyObject转成控制器的类型
            guard let childVcType = ChildVcClass as? RootViewController.Type else {
                FDLog("没有获取对应控制器的类型")
                return
            }
            
            // 3.创建对应的控制器对象
            let childVc:RootViewController = childVcType.init()
            childVc.ext = ext
            self.navigationController?.pushViewController(childVc, animated: true)
        }
    }
}
