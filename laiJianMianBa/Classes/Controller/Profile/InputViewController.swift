//
//  InputViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/26.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
protocol InputViewControllerDelegate {
    func addCustormParseDone(_ parse: InterestModel)
}

class InputViewController: RootViewController {
    public var delegate: InputViewControllerDelegate!
    /// 行业＝5 工作领域＝6
    public var type: String!
    @IBOutlet weak var textView: InputTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        textView.becomeFirstResponder()
        if type == "0" {
            textView.placeHolderLabel.text = "添加饮食爱好"
        }
        if type == "1" {
            textView.placeHolderLabel.text = "添加运动爱好"
        }
        if type == "2" {
            textView.placeHolderLabel.text = "添加音乐爱好"
        }
        if type == "3" {
            textView.placeHolderLabel.text = "添加电影爱好"
        }
        if type == "4" {
            textView.placeHolderLabel.text = "添加书籍爱好"
        }
        if type == "5" {
            textView.placeHolderLabel.text = "添加行业"
        }
        if type == "6" {
            textView.placeHolderLabel.text = "添加工作领域"
        }
        if type == "7" {
            textView.placeHolderLabel.text = "添加家乡"
        }
        initNavBtns()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - UI
extension InputViewController {
    func initNavBtns() {
        let leftBtn = UIButton(x: 0, y: 0, w: 40, h: 40, target: self, action: #selector(leftBtnDone))
        leftBtn.contentMode = .right
        leftBtn.setTitle("取消", for: .normal)
        leftBtn.setTitleColor(UIColor.gray, for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
        
        let rightBtn = UIButton(x: 0, y: 0, w: 40, h: 40, target: self, action: #selector(rightBtnDone))
        rightBtn.contentMode = .right
        rightBtn.setTitle("保存", for: .normal)
        rightBtn.setTitleColor(UIColor.gray, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
    }
    @objc func leftBtnDone() {
        self.navigationController?.dismiss(animated: true, completion: {
            
        })
    }
    @objc func rightBtnDone() {
        ///
        if textView.text == "" {
            return
        }
        self.view.endEditing(true)
        /// 修改用户信息
        let req = RequestUserChangeModel()
        var str = UserAccountViewModel.standard.account?.interest
        if type == "0" || type == "1" || type == "2" || type == "3" || type == "4"{
            str?.append(",0|\(type!)|\(textView.text!)")
        }
        req.interest = str
        req.userid = UserAccountViewModel.standard.account?.uId
        if type == "5" {
            req.area = textView.text
        }else if type == "6"{
            req.job = textView.text
        }else if type == "7" {
            req.hometown = textView.text
        }
        api.jmUserChange(req)
        self.activityView.startAnimating()
    }
   
}
// MARK:- UITextView的代理方法
extension InputViewController : UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        self.textView.placeHolderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.view.endEditing(true)
            rightBtnDone()
            return false
        }
        return true
    }
}
extension InputViewController {
    func jmUserChangeDone(request: RequestUserChangeModel, response: ResponseUserChangeModel) {
        self.activityView.stopAnimating()
        // 获取用户详情
        if response.status == "ok" {
            getUserDetail()
        }else{
            makeToast(response.message)
        }
    }
    func getUserDetail() {
        let request = RequestUserDetailModel()
        request.id = UserAccountViewModel.standard.account?.uId
        api.jmGetUserDetail(request)
    }
    func jmGetUserDetailDone(request: RequestUserDetailModel, response: ResponseUserDetailModel) {
        self.activityView.stopAnimating()
        if response.status == "ok" {
            UserAccountViewModel.standard.saveAccount(account: response.user)
            //用户信息修改成功！
            let parse  = InterestModel()
            parse.id = "0"
            parse.iclass = textView.text!
            parse.type = self.type
            parse.isSelected = true
            delegate.addCustormParseDone(parse)
            self.dismiss(animated: true, completion: {
                
            })
        }
    }
}
