//
//  UserViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/20.
//  Copyright © 2016年 fundot. All rights reserved.
//  展示用户的信息，包括很多种状态

import UIKit
//import JMServicesKit
class UserViewController: RootTableViewController {
    /// table head View
    fileprivate var headView: UserHeadView!
    /// 订单模型
    fileprivate var order: OrderModel!
    /// 发起订单的User
    fileprivate lazy var user: UserAccount = {
        return UserAccount()
    }()
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - orderid: 订单id
    ///   - status: 订单状态
    init(_ order: OrderModel) {
        super.init(nibName: nil, bundle: nil)
        self.order = order
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = getOrderStatus(self.order.state)
        initTableView()
        requestData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UI
extension UserViewController {
    @objc func seeorNotBtnDone() {
        //跳转到待挑选，过期
    }
    fileprivate func initTableHeaderView() {
        tableView.tableHeaderView = nil
        /// 未见面的view
        if self.order.state == 7 || self.order.state == 4 {
            let headView = Bundle.main.loadNibNamed("NotMeetView", owner: self, options: nil)?.last as! NotMeetView
            if self.order.state == 4 {
                headView.seeBtn.addTarget(self, action: #selector(seeBtnDone), for: .touchUpInside)
                headView.title.text = "该订单已取消"
                if isBoy {
                    headView.detail.text = "请在1小时内选择心仪女生"
                }else{
                    headView.detail.text = "请在1小时内选择心仪男生"
                }
            }
            headView.frame = CGRect(x: 0, y: 0, w: screenW, h: screenW-50)
            tableView.tableHeaderView = headView
        }else {
            /// 用户的view
            headView = Bundle.main.loadNibNamed("UserHeadView", owner: self, options: nil)?.last as! UserHeadView
            headView.frame = CGRect(x: 0, y: 0, w: screenW, h: screenW-50)
            headView.detailView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(detailToMapDone)))
            tableView.tableHeaderView = headView
        }
    }
    func initTableView() {
        tableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        /// test 方法嵌套
        func doSumThing() {
            FDLog("test 方法嵌套")
        }
        initTableHeaderView()
        initTableFooterView()
    }
    fileprivate func initTableFooterView() {
        tableView.tableFooterView = nil
        if self.order.state == 5 || self.order.state == 11 {
            if isBoy {
                let tipsView = WaitingHeadView(frame: CGRect(x: 0, y: 0, w: screenW, h: 60))
                tipsView.tips.text = "你与她即将见面，不要爽约，主动联系对方好感度倍增！见面后请主动提示对方输入见面暗号，4小时内输入，对方即可领取诚意红包。"
                tableView.tableFooterView = tipsView
            }else{
                let foot = UIView(frame: CGRect(x: 0, y: 0, w: screenW, h: 160))
                let footerView = UserWaitingBtnView("请输入见面暗号")
                footerView.delegate = self
                footerView.frame = CGRect(x: 0, y: 0, w: screenW, h: 100)
                foot.addSubview(footerView)
                let tipsView = WaitingHeadView(frame: CGRect(x: 0, y: footerView.frame.maxY, w: screenW, h: 60))
                tipsView.tips.text = "你与他即将见面，不要爽约，主动联系对方好感度倍增！见面后请和男生索取见面暗号，4小时内输入即可领取诚意红包。"
                tableView.tableFooterView = foot
            }
            
        }
        /// 发布中，待挑选都是可选的
        if self.order.state == 1{
            let footerView = UserWaitingBtnView("见", notSee:"不见")
            footerView.delegate = self
            footerView.frame = CGRect(x: 0, y: 0, w: screenW, h: 100)
            tableView.tableFooterView = footerView
        }
        if self.order.state == 2 {
            let footerView: UserWaitingBtnView!
            if isBoy {
                footerView = UserWaitingBtnView("就她了")
            }else{
                footerView = UserWaitingBtnView("就他了")
            }
            footerView.delegate = self
            footerView.frame = CGRect(x: 0, y: 0, w: screenW, h: 100)
            tableView.tableFooterView = footerView
        }
        if self.order.state == 8 {
            let footerView = UserWaitingBtnView("邀请再次发起")
            footerView.delegate = self
            footerView.frame = CGRect(x: 0, y: 0, w: screenW, h: 100)
            tableView.tableFooterView = footerView
        }
    }
    @objc private func detailToMapDone() {
        if (self.order != nil) {
            
            let map = MapViewController(self.order.address, lat: Double(self.order.address_lat)/1e6, lon: Double(self.order.address_lon)/1e6)
            self.navigationController?.pushViewController(map, animated: true)
        }
    }
}

// MARK: - UserWaitingBtnViewDelegate
extension UserViewController: UserWaitingBtnViewDelegate {
    func secretBtnDone() {
        
        if (self.order.state == 2) {
            /// 说明是惦记的 就她了 ,发起人选择约会用hu
            requestAgreeMeetBoth()
            return
        }
        if self.order.state == 5 || self.order.state == 11 {
            //输入见面暗号
            let alertController = UIAlertController(title: "请输入见面暗号", message: "输入暗号后才能获得男生红包", preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "见面暗号"
            })
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (alertAction) in
                
            }))
            alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { (alertAction) in
                if (alertController.textFields?[0].text!)! == "" {
                    makeToast("请输入暗号")
                    return
                }
                self.compareCipher((alertController.textFields?[0].text!)!)
                alertController.dismiss(animated: true, completion: nil)
            }))
            self.navigationController?.present(alertController, animated: true, completion: { 
                
            })
        }
        if self.order.state == 8 {
            //邀请再次发起
            self.navigationController!.popToRootViewController(animated: true)
        }
    }
    func seeBtnDone() {
        updateAcceptStatus()
    }
    func notSeeBtnDone() {
        updateRefuseStatus()
    }
}
// MARK: - UITableViewDelegate
extension UserViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UserCell(style: .default, reuseIdentifier:"UserCell")
        cell.selectionStyle = .none
        let frame = dataArray[indexPath.row] as! UserFrame
        cell.statusFrame = frame
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let frame = dataArray[indexPath.row] as! UserFrame
        return frame.cellHeight
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.order.state == 12 || self.order.state == 13{
            let headView = Bundle.main.loadNibNamed("UserSectionHeadVIew", owner: self, options: nil)?.last as! UserSectionHeadVIew
            if self.order.state == 13 {
                headView.image.image = UIImage(named: "yiguoqi_nv")
                headView.title.text = "当前订单已过期"
            }else {
                headView.title.text = "已拒绝"
            }
            return headView
        }
        return nil

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.order.state == 12 || self.order.state == 13 {
            return 44
        }
        return 0.000001
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let frame = dataArray[indexPath.row] as! UserFrame
        if frame.status.title == "见面位置" {
            let map = MapViewController(self.order.address, lat: Double(self.order.address_lat)/1e6, lon: Double(self.order.address_lon)/1e6)
            self.navigationController?.pushViewController(map, animated: true)
        }
    }
}

// MARK: - JMAPIDelegate
extension UserViewController: ReloadDelegate {
    // MARK: -  见，不见
    func updateAcceptStatus() {
        self.activityView.startAnimating()
        let request = RequestUpdateAcceptStatusModel()
        request.order_id = self.order.orderid
        request.user_id = UserAccountViewModel.standard.account?.uId
        api.jmUpdateAcceptStatus(request)
    }
    // MARK: -  不见
    func updateRefuseStatus() {
        self.activityView.startAnimating()
        let request = RequestUpdateRefuseStatusModel()
        request.order_id = self.order.orderid
        request.user_id = UserAccountViewModel.standard.account?.uId
        api.jmUpdateRefuseStatus(request)
    }
    // MARK: -  就他了
    func requestAgreeMeetBoth() {
        self.activityView.startAnimating()
        let request = RequestAgreeMeetBothModel()
        request.order_id = self.order.orderid
        request.to_user_id = self.order.to_uid
        api.jmAgreeMeetBoth(request)
    }
    // MARK: -  输入见面暗号
    func compareCipher(_ cipher: String) {
        self.activityView.startAnimating()
        let request = RequestCompareCipherModel()
        request.order_id = self.order.orderid
        request.cipher = cipher
        api.jmCompareCipher(request)
    }
    func jmCompareCipherDone(request: RequestCompareCipherModel, response: ResponseCompareCipherModel) {
        self.activityView.stopAnimating()
        if response.status == "ok" {
            self.requestData()
        }
    }
    // MARK: -  见Done
    func jmUpdateAcceptStatusDone(request: RequestUpdateAcceptStatusModel, response: ResponseUpdateAcceptStatusModel) {
        self.activityView.stopAnimating()
        if response.status == "ok" {
            self.requestData()
        }
    }
    // MARK: -  就他了Done
    func jmUpdateRefuseStatusDone(request: RequestUpdateRefuseStatusModel, response: ResponseUpdateRefuseStatusModel) {
        self.activityView.stopAnimating()
        if response.status == "ok" {
            self.requestData()
        }
    }
    // MARK: -  就他了Done
    func jmAgreeMeetBothDone(request: RequestAgreeMeetBothModel, response: ResponseAgreeMeetBothModel) {
        self.activityView.stopAnimating()
        if response.status == "ok" {
            let count = self.navigationController?.viewControllers.count
            if count! >= 2 {
                if (self.navigationController?.viewControllers[count!-2].isKind(of: WaitingSelectListViewController.self))! {
                    var views = self.navigationController?.viewControllers
                    views?.remove(at: count!-2)
                    self.navigationController?.viewControllers = views!
                }
            }
            self.requestData()
        }
    }
    // MARK: - 请求订单详情
    func requestData()  {
        self.dataArray.removeAllObjects()
        self.activityView.startAnimating()
        let request = RequestOrderDetailModel()
        request.order_id = self.order.orderid
        request.user_id = UserAccountViewModel.standard.account?.uId
        api.jmmOrderDetail(request)
    }
    // MARK: - 请求订单对应的用户详情
    func getUserDetail() {
        let model: RequestUserDetailModel = RequestUserDetailModel()
        if self.order.to_uid == 0 {
            model.id = self.order.from_uid
        }else{
            model.id = self.order.to_uid
        }
        self.api.jmGetUserDetail(model)
    }
    func jmOrderDetailDone(request: RequestOrderDetailModel, response: ResponseOrderDetailModel) {
        self.activityView.stopAnimating()
        if response.status == "ok" {
            if response.order != nil {
                /// 如果状态发生改变，刷新列表
                if response.order.state != self.order.state {
                    NotificationCenter.default.post(name: JMReloadList, object: self)
                }
                if response.order.state == 10 && UserAccountViewModel.standard.account?.uId != response.order.from_uid {
                    //跳转到待挑选
                    let selected = SelectedViewController(self.user)
                    self.navigationController?.pushViewController(selected, animated: true)
                }
                if response.order.state == 6 {
                    var uid = response.order.from_uid
                    if response.order.from_uid == UserAccountViewModel.standard.account?.uId {
                        uid = response.order.to_uid
                    }
                    let evaluate = EvaluateViewController(self.order.orderid, uid:uid!)
                    evaluate.delegate = self
                    self.navigationController?.pushViewController(evaluate, animated: true)
                }
                self.title = getOrderStatus(response.order.state)
                let to_uid = self.order.to_uid
                self.order = response.order
                if self.order.state == 10 || self.order.state == 2 {
                    self.order.to_uid = to_uid
                }
                if self.order.state == 13  {
                    self.order.to_uid = response.order.from_uid
                }
                initTableHeaderView()
                initTableFooterView()
                getUserDetail()
                if self.order.state != 0 && self.order.state != 2 && self.order.state != 10 {
                    if self.order.state == 5 && isBoy {
                        let frame = UserFrame()
                        let model = UserModel()
                        model.title = "见面暗号"
                        model.detail = response.order.cipher
                        model.detailColor = "ec3c0d"
                        frame.status = model
                        dataArray.add(frame)
                    }
                    
                    let frame4 = UserFrame()
                    let model4 = UserModel()
                    model4.title = "见面做什么"
                    model4.detail = response.order.des
                    frame4.status = model4
                    dataArray.add(frame4)
                    
                    let frame1 = UserFrame()
                    let model1 = UserModel()
                    model1.title = "时间"
                    model1.detail = response.order.order_time_string
                    frame1.status = model1
                    dataArray.add(frame1)
                    
                    let frame2 = UserFrame()
                    let model2 = UserModel()
                    model2.title = "见面位置"
                    model2.detail = response.order.address
                    frame2.status = model2
                    dataArray.add(frame2)
                    
                    let frame = UserFrame()
                    let model = UserModel()
                    model.title = "见面红包"
                    model.detail = "\(response.order.money!)元"
                    model.detailColor = "ec3c0d"
                    frame.status = model
                    dataArray.add(frame)
                    
                }
                
                tableView.reloadData()
            }
        }
    }
    func jmGetUserDetailDone(request: RequestUserDetailModel, response: ResponseUserDetailModel) {
        if response.status == "ok" {
            self.user = response.user
            if self.order.state == 8 || self.order.state == 10 || self.order.state == 2 {
                var impressTags = [ZWTagModel]()
                //个人印象
                var i = 0
                for (key,value) in response.user.impressions {
                    i += 1
                    let model = ZWTagModel()
                    model.title = key + " " + "X\(value)"
                    model.textColor = UIColor.white
                    model.backgroundColor = UIColor(getTagsSelectedColor(i))
                    impressTags.append(model)
                }
                for index in 0 ..< impressTags.count {
                    let impress = impressTags[index]
                    impress.backgroundColor = UIColor(getTagsSelectedColor(index))
                }
                if self.order.state == 8 {
                    let frame = UserFrame()
                    let model = UserModel()
                    model.title = "见面印象"
                    model.detail = ""
                    model.detailColor = ""
                    model.tags = impressTags
                    frame.status = model
                    dataArray.add(frame)
                }
                if self.order.state == 2 || self.order.state == 10 { //待挑选
                    if self.order.from_uid == UserAccountViewModel.standard.account?.uId {
                        let frame = UserFrame()
                        let model = UserModel()
                        model.title = "见面印象"
                        model.detail = ""
                        model.detailColor = ""
                        
                        model.tags = impressTags
                        frame.status = model
                        dataArray.add(frame)
                        
                        let frame1 = UserFrame()
                        let model1 = UserModel()
                        model1.title = "星座"
                        model1.detail = self.user.sign
                        frame1.status = model1
                        dataArray.add(frame1)
                        
                        let frame2 = UserFrame()
                        let model2 = UserModel()
                        model2.title = "身高"
                        model2.detail = "\(self.user.height!)cm"
                        frame2.status = model2
                        dataArray.add(frame2)
                    }else{
                        
                    }
                }
                tableView.reloadData()
            }
            if headView != nil {
                headView.user = response.user
            }
        }
    }
    func reloadUI() {
        self.requestData()
    }
}
