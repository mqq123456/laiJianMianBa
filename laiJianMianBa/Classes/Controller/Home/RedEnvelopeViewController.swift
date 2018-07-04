//
//  RedEnvelopeViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/20.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class RedEnvelopeViewController: RootViewController {
    var delegate: HomeControllerBackDelegate!
    @IBOutlet weak var tipsBackView: UIView!
    @IBOutlet weak var tips: UILabel!
    /// 订单，用于男生支付女生的时候使用
    public var order: OrderModel!
    public var user: UserAccount!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "见面红包"
        tipsBackView.layer.borderColor = RGBA(r: 235, g: 219, b: 184, a: 1).cgColor
        tipsBackView.layer.borderWidth = 0.5
        tipsBackView.layer.cornerRadius = 5
        tipsBackView.clipsToBounds = true
        tips.text = "如未成功见面，红包将全额退还。\n红包金额仅代表诚意，期望你认真对待每次见面。"
        if (UserDefaults.standard.object(forKey: "CoverRedView") != nil) && (UserDefaults.standard.object(forKey: "CoverRedView") as! String == "2") {
            
        }else{
            let coverView = Bundle.main.loadNibNamed("CoverRedView", owner: self, options: nil)?.last as! CoverRedView
            coverView.frame = CGRect(x: 0, y: 0, w: screenW, h: screenH)
            coverView.isRedBag = true
            self.navigationController?.view.addSubview(coverView)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(payNotification(no:)), name: WXPayNotification, object: nil)
    }
    /// 支付完成的通知
    ///
    /// - Parameter no: 通知传递参数
    @objc func payNotification(no:Notification) {
        if self.navigationController?.topViewController == self {
            if let errorCode = no.userInfo?[AnyHashable("errCode")] as? Int32 {
                if errorCode == 0 {
                    let selected = SelectedViewController(self.user)
                    navigationController?.pushViewController(selected, animated: true)
                }
            }
        }
    }
    @IBAction func btn50Click(_ sender: Any) {
        if order != nil {
            pay("5000")
        }else{
            delegate.redEnvelopeBack("5000")
            self.navigationController!.popViewController(animated: true)
        }
    }
    @IBAction func btn100Click(_ sender: Any) {
        if order != nil {
            pay("10000")
        }else{
            delegate.redEnvelopeBack("10000")
            self.navigationController!.popViewController(animated: true)
        }
    }
    @IBAction func btn200Click(_ sender: Any) {
        if order != nil {
            pay("15000")
        }else{
            delegate.redEnvelopeBack("15000")
            self.navigationController!.popViewController(animated: true)
        }
    }
    @IBAction func btn250Click(_ sender: Any) {
        if order != nil {
            pay("20000")
        }else{
            delegate.redEnvelopeBack("20000")
            self.navigationController!.popViewController(animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
extension RedEnvelopeViewController {
    
    func pay(_ money: String) {
        if (UserDefaults.standard.object(forKey: "CoverRedView") != nil) && (UserDefaults.standard.object(forKey: "CoverRedView") as! String == "3") {
            
        }else{
            let coverView = Bundle.main.loadNibNamed("CoverRedView", owner: self, options: nil)?.last as! CoverRedView
            coverView.isRedBag = true
            coverView.frame = CGRect(x: 0, y: 0, w: screenW, h: screenH)
            self.navigationController?.view.addSubview(coverView)
            return
        }
        ///  说明是男生支付女生的订单，直接支付
//        let req = RequestReadyPayModel()
//        req.des = "支付红包"
//        req.payid = "\(self.order.uid!)_\(UserAccountViewModel.standard.account!.uId!)_\(Int(Date().timeIntervalSince1970))"
//        /// TODO
//        //req.money = money
//        req.money = "1"
//        //req.userid = UserAccountViewModel.standard.account?.uId
//        api.jmReadyPay(req)
    }
    
    func jmReadyPayDone(request: RequestReadyPayModel, response: ResponseReadyPayModel) {
        self.activityView.stopAnimating()
        if response.status == "ok" {
            wechatPay(response)
        }
    }
    // MARK: - 微信支付
    private func wechatPay(_ request: ResponseReadyPayModel)
    {
        if !WXApi.isWXAppInstalled()  {//检查一下是否可以使用微信
            // 未安装微信
            makeToast("未安装微信")
            return
            
        } else if !WXApi.isWXAppSupport() {
            // 当前版本微信不支持微信支付
            makeToast("未安装微信")
            return
        }
//        let req = PayReq()
//        req.partnerId = request.partnerid
//        req.prepayId = request.prepayid
//        req.nonceStr = request.noncestr
//        req.timeStamp = UInt32(request.timestamp)!
//        req.package = request.package
//        req.sign = request.sign
//        WXApi.send(req)
    }
    
}
