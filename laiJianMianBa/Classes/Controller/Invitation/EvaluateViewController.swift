//
//  EvaluateViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/13.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit
protocol ReloadDelegate {
    func reloadUI()
}

//import JMServicesKit
class EvaluateViewController: RootTableViewController {
    
    public var delegate: ReloadDelegate!
    /// 所有的印象
    fileprivate lazy var impress: [ImpressModel] = [ImpressModel]()
    /// 被用户选择的印象
    fileprivate lazy var selectedImpress: [ImpressModel] = [ImpressModel]()
    /// 头部试图
    fileprivate var headVIew: EvaluateHeadView!
    /// 被评价用户的id
    fileprivate var uid: Int!
    /// 订单id
    fileprivate var orderid: Int!
    /// 照片是否相符
    fileprivate var similar: Int!
    
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - orderid: 订单id
    ///   - status: 订单状态
    init(_ orderid: Int, uid: Int) {
        super.init(nibName: nil, bundle: nil)
        self.orderid = orderid
        self.uid = uid
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "待评价"
        initTableView()
        getEvaluationIds()
        getUserDetail()
        self.similar = 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
// MARK: - UI
extension EvaluateViewController {
    func initTableView()  {
        /// headView
        headVIew = Bundle.main.loadNibNamed("EvaluateHeadView", owner: self, options: nil)?.last as? EvaluateHeadView
        headVIew?.frame = CGRect(x: 0, y: 0, w: screenW, h: screenW*0.7)
        tableView.tableHeaderView = headVIew
        /// footerVIew
        let footerView = UIView(x: 0, y: 0, w: screenW, h: 100)
        footerView.backgroundColor = UIColor.white
        let footBtn = UIButton(x: screenW/2 - 120, y: 30, w: 240, h: 50, target: self, action: #selector(footBtnDone))
        footBtn.layer.cornerRadius = 25
        footBtn.clipsToBounds = true
        footBtn.setTitle("确认评价", for: .normal)
        footBtn.backgroundColor = RGBA(r: 4, g: 190, b: 194, a: 1)
        footBtn.setTitleColor(UIColor.white, for: .normal)
        footerView.addSubview(footBtn)
        tableView.tableFooterView = footerView
        /// cell add
        view.addSubview(tableView)
        let nib = UINib(nibName: "EvaluateCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EvaluateCell")
        tableView.separatorStyle = .none
    }
}

// MARK: - UITableViewDelegate
extension EvaluateViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EvaluateCell", for: indexPath) as! EvaluateCell
        cell.selectionStyle = .none
        cell.dataArray = self.impress
        cell.delegate = self
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenW * 937 / 1242
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func selected(_ imp:[ImpressModel]) {
        self.selectedImpress = imp
    }
}

// MARK: - JMAPIDelegate, EvaluateCellDelegate
extension EvaluateViewController: EvaluateCellDelegate {
// MARK: Requests
    internal func similar(_ similar: Int) {
        self.similar = similar
    }
    @objc fileprivate func footBtnDone(){
        self.activityView.startAnimating()
        setPhotoMatch()
        let request = RequestSetUserImpressModel()
        request.userid = self.uid
        var impres = [String]()
        for item in self.selectedImpress {
            impres.append(item.impress)
        }
        request.impress = impres
        request.order_id = self.orderid
        api.jmSetUserImpress(request)
    }
    func setPhotoMatch() {
        let request = RequestSetPhotoMatchModel()
        request.order_id = self.orderid
        request.from_user_id = UserAccountViewModel.standard.account?.uId
        request.to_user_id = self.uid
        request.photo_match = similar
        api.jmSetPhotoMatch(request)
    }
    func getEvaluationIds() {
        let request = RequestGetImpressModel()
        var sex = 1
        if UserAccountViewModel.standard.account?.sex == 1 {
            sex = 2
        }else{
            sex = 1
        }
        request.sex = sex
        self.api.jmGetImpress(request)
    }
    /// 获取用户详情 2001
    func getUserDetail() {
        self.activityView.startAnimating()
        let request = RequestUserDetailModel()
        request.id = self.uid
        self.api.jmGetUserDetail(request)
    }
    func updateOrderStateMeeted() {
        let request = RequestUpdateOrderStateMeetedModel()
        request.order_id = self.orderid
        request.user_id = UserAccountViewModel.standard.account?.uId
        api.jmUpdateOrderStateMeeted(request)
    }
    func jmUpdateOrderStateMeetedDone(request: RequestUpdateOrderStateMeetedModel, response: ResponseUpdateOrderStateMeetedModel) {
        if response.status == "ok" {
            delegate.reloadUI()
            self.navigationController!.popViewController(animated: false)
        }
    }
    func jmSetUserImpressDone(request: RequestSetUserImpressModel, response: ResponseSetUserImpressModel) {
        if response.status == "ok" {
            updateOrderStateMeeted()
        }
    }
    func jmGetUserDetailDone(request: RequestUserDetailModel, response: ResponseUserDetailModel) {
        self.activityView.stopAnimating()
        if response.status == "ok" {
            headVIew.status = response.user
        }
    }
    func jmSetPhotoMatchDone(request: RequestSetPhotoMatchModel, response: ResponseSetPhotoMatchModel) {
        
    }
    func jmGetImpressDone(request: RequestGetImpressModel, response: ResponseGetImpressModel) {
        if response.status == "ok" {
            self.impress = response.impress
            tableView.reloadData()
        }
    }
   
}
