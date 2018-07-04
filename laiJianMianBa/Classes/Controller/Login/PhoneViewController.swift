//
//  PhoneViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/20.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class PhoneViewController: RootViewController {
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var vcode: UITextField!
    @IBOutlet var getVcodeBtn: UIButton!
    @IBOutlet weak var goBtn: UIButton!
    public var sex: Int!
    fileprivate var countdownTimer: Timer?
    fileprivate var remainingSeconds: Int = 0 {
        willSet {
            getVcodeBtn.setTitle("\(newValue)", for: .normal)
            
            if newValue <= 0 {
                getVcodeBtn.setTitle("验证码", for: .normal)
                isCounting = false
            }
        }
    }
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                remainingSeconds = 60
                getVcodeBtn.backgroundColor = UIColor.gray
                
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                getVcodeBtn.backgroundColor = UIColor("FFB400")
            }
            getVcodeBtn.isEnabled = !newValue
        }
    }
    @objc func updateTime() {
        remainingSeconds -= 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "开启见面之旅"
        getVcodeBtn.layer.cornerRadius = 20
        getVcodeBtn.clipsToBounds = true
        goBtn.layer.cornerRadius = 25
        goBtn.clipsToBounds = true
        if self.sex == 1 {
            goBtn.backgroundColor = RGBA(r: 4, g: 190, b: 194, a: 1)
            getVcodeBtn.backgroundColor = RGBA(r: 4, g: 190, b: 194, a: 1)
        }else{
            goBtn.backgroundColor = RGBA(r: 255, g: 110, b: 141, a: 1)
            getVcodeBtn.backgroundColor = RGBA(r: 255, g: 110, b: 141, a: 1)
        }
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(returnKeyBoard)))
    }
    @objc func returnKeyBoard(){
        self.view.endEditing(true)
    }

    @IBAction func vcodeBtnClick(_ sender: Any) {
        let str = NSString(string: self.phone.text!)
        if str.hasPrefix("1") && str.length == 11 {
            
        }else{
            makeToast("请输入正确的手机号")
            return
        }
        isCounting = true
        SMSSDK.getVerificationCode(by: SMSGetCodeMethodSMS, phoneNumber: phone.text!, zone: "86", customIdentifier: nil) { (error) in
            if (error != nil) { //失败了
                FDLog("获取验证码失败了")
                makeToast("验证码获取失败")
                FDLog(error)
            } else { // 成功了
                FDLog("获取验证码成功了")
            }
        }
    }
    @IBAction func goBtnClick(_ sender: Any) {
        self.view.endEditing(true)
        let phone = NSString(string: self.phone.text!)
        if phone.hasPrefix("1") && phone.length == 11 {
            
        }else{
            makeToast("请输入正确的手机号")
            return
        }
        let str = NSString(string: self.vcode.text!)
        if str.length == 4 {
            
        }else{
            makeToast("请输入正确的验证码")
            return
        }
        
//        SMSSDK.commitVerificationCode(vcode.text!, phoneNumber: self.phone.text!, zone: "86") { (info, error) in
//            if info == nil {
//                makeToast("手机号验证失败")
//                FDLog("手机号验证失败了 ＝ \(error)")
//            } else {
//                FDLog("手机号验证成功了 ＝ \(info)")
                let request: RequestUserLoginModel = RequestUserLoginModel()
                request.phone = self.phone.text!
                self.api.jmGetUserLogin(request)
//            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - JMAPIDelegate
extension PhoneViewController {
    func jmGetUserLoginDone(request: RequestUserLoginModel, response: ResponseUserLoginModel) {
        FDLog(response)
        /// 如果用户都不存在，那么添加用户，跳转完善资料
        /// 如果用户存在，但是用户资料不完整，跳转完善资料
        /// 如果用户资料完整，直接跳转首页
        if response.status == "ok" {
            UserAccountViewModel.standard.saveAccount(account: response.user)
            if response.user.name != "" && response.user.birthTime != 0 {
                UIApplication.shared.keyWindow?.rootViewController = RootNavigationController(rootViewController: HomeViewController())
            }else{
                let per = PerfectInformationViewController()
                per.uId = response.user.uId
                navigationController?.pushViewController(per, animated: true)
            }
        } else if response.status == "none_target" {
            let model = RequestUserRegisterModel()
            model.phone = self.phone.text
            model.sex = sex
            model.push_token = JPUSHService.registrationID()
            api.jmUserRegister(model)
        }else{
            makeToast(response.message)
        }
    }
    func jmUserRegisterDone(request: RequestUserRegisterModel, response: ResponseUserRegisterModel) {
        if response.status == "ok" {
            let request: RequestUserLoginModel = RequestUserLoginModel()
            request.phone = self.phone.text!
            self.api.jmGetUserLogin(request)
        }else{
            makeToast(response.message)
        }
    }
}
