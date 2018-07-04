//
//  WalletViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/26.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class WalletViewController: RootViewController {

    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var bringBtn: UIButton!
    @IBOutlet weak var tips: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的钱包"
        tips.text = "1.提现会将余额全部提现到你的微信帐号\n2.每日仅限提现1次\n3.提现到账周期24小时\n4.如有疑问，请拨打客服电话13261147500"
        bringBtn.layer.cornerRadius = 25
        bringBtn.clipsToBounds = true
        NotificationCenter.default.addObserver(self, selector: #selector(authNotification(no:)), name: WXAuthNotification, object: nil)
    }
    @IBAction func weixinBtnDOne(_ sender: Any) {
        sendAuthRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension WalletViewController {
    fileprivate func sendAuthRequest() {
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "12345"
        WXApi.sendAuthReq(req, viewController: self, delegate: UIApplication.shared.delegate as! AppDelegate)
    }
    @objc fileprivate func authNotification(no: NSNotification)
    {
        if let code = no.userInfo?[AnyHashable("code")] as? String {
            if code != "" {
              //  getAccessToken(code)
            }
        }
    }
//    func getAccessToken(_ code: String) {
//        let requestUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=\(wxAPPKEY)&secret=\(wxSECRET)&code=\(code)&grant_type=authorization_code"
//        NetworkRequest.sharedInstance.getRequest(urlString: requestUrl, params: [:], success: { (resp) in
//            let token: String = resp["access_token"] as! String
//            let openid: String = resp["openid"] as! String
//            self.getUserInfo(token, openid: openid)
//        }) { (error) in
//            
//        }
//        
//    }
//    func getUserInfo(_ token: String, openid: String) {
//         let requestUrl = "https://api.weixin.qq.com/sns/userinfo?access_token=\(token)&openid=\(openid)"
//        NetworkRequest.sharedInstance.getRequest(urlString: requestUrl, params: [:], success: { (resp) in
//            //let headimgurl: String = resp["headimgurl"] as! String
//            //let nickname: String = resp["nickname"] as! String
//        }) { (error) in
//            
//        }
//    }
}
/*
 Recevice UserInfo:
 {
 city = Chaoyang;
 country = CN;
 headimgurl = "http://wx.qlogo.cn/mmopen/FrdAUicrPIibcpGzxuD0kjfssQogj3icL8QTJQYUCLpgzSnvY6rJFGORreicPUiaPCzojwNlsXq4ibbc8e3gGFricWqJU5ia7ibicLVhfT/0";
 language = "zh_CN";
 nickname = "\U706b\U9505\U6599";
 openid = "oyAaTjkR8T6kcKWyA4VPYDa_Wy_w";
 privilege =     (
 );
 province = Beijing;
 sex = 1;
 unionid = "o1A_Bjg52MglJiEjhLmB8SyYfZIY";
 }
 */

