//
//  InvitationCellViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/21.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
import MJRefresh
class InvitationCellViewController: RootTableViewController {
    /// 1我发出去的，3我收到的
    fileprivate var type: Int!
    /// tableview reg id
    fileprivate var identify: String!
    fileprivate var page: Int!
    /// 初始化方法
    ///
    /// - Parameter type: 类型，1为我发出的，2为我收到的
    init(type: Int) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
        self.page = 1
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        initTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNotification), name: JMReloadList, object: nil)
    }
    @objc func reloadNotification() {
        self.tableView.contentOffset = CGPoint(x: 0, y: 0)
        headerRefresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UI
extension InvitationCellViewController {
    func initTableView()  {
        switch type {
        case 1:
            tableView.register(SendReleaseCell.self, forCellReuseIdentifier: "SendReleaseCell")
            identify = "SendReleaseCell"
        case 3:
            tableView.register(ReceivedReleaseCell.self, forCellReuseIdentifier: "ReceivedReleaseCell")
            tableView.separatorStyle = .none
            identify = "ReceivedReleaseCell"
            
        default:
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
        tableView.frame = CGRect(x: 0, y: 0, w: screenW, h: screenH-64-50)
        view.addSubview(tableView)
        
        if (tableView.responds(to: #selector(setter: UITableViewCell.separatorInset))) {
            tableView.separatorInset = .zero
        }
        
        if (tableView.responds(to: #selector(setter: UIView.layoutMargins))) {
            tableView.layoutMargins = .zero
        }
        
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { 
            /// 发起请求
            self.headerRefresh()
        })
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { 
            /// 发起加载更多请求
            self.footerRefresh()
        })
        self.tableView.mj_footer.isHidden = true
    }
}
// MARK: - UITableViewDelegate,UITableViewDataSource
extension InvitationCellViewController : ReloadDelegate{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch type {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as! SendReleaseCell
            cell.statusFrame = dataArray[indexPath.row] as! SendReleaseFrame
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as! ReceivedReleaseCell
            cell.statusFrame = dataArray[indexPath.row] as! ReceivedReleaseFrame
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath)
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch type {
        case 1:
            let frame: SendReleaseFrame = dataArray[indexPath.row] as! SendReleaseFrame
            return frame.cellHeight
        case 3:
            let frame: ReceivedReleaseFrame = dataArray[indexPath.row] as! ReceivedReleaseFrame
            return frame.cellHeight
        default:
            return 44
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = .zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = .zero
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if type == 1 {
            let frame: SendReleaseFrame = dataArray[indexPath.row] as! SendReleaseFrame
            if frame.status.state == 1 {
                // 发布中
                let sending = SendingViewController("\(frame.status.to_peoples!)")
                self.navigationController?.pushViewController(sending, animated: true)
            }else if frame.status.state == 2 {
                //待挑选
                let waiting = WaitingSelectListViewController(frame.status.orderid)
                self.navigationController?.pushViewController(waiting, animated: true)
            }else if frame.status.state == 3 {
                //无回应
                let non = NonresponseViewController()
                self.navigationController?.pushViewController(non, animated: true)
            }else if frame.status.state == 6 {
                // 待评价
                let evaluate = EvaluateViewController(frame.status.orderid, uid:frame.status.to_uid)
                evaluate.delegate = self
                self.navigationController?.pushViewController(evaluate, animated: true)
            }else {
                //以取消,待见面，未见面，以见面
                let user = UserViewController(frame.status)
                self.navigationController?.pushViewController(user, animated: true)
            }
        }else{
            let frame: ReceivedReleaseFrame = dataArray[indexPath.row] as! ReceivedReleaseFrame
           if frame.status.state == 6 {
                // 待评价
                let evaluate = EvaluateViewController(frame.status.orderid, uid:frame.status.from_uid)
                evaluate.delegate = self
                self.navigationController?.pushViewController(evaluate, animated: true)
            }else if frame.status.state == 14 {
                // 无回应
                let non = UserViewController(frame.status)
                self.navigationController?.pushViewController(non, animated: true)
           }else if frame.status.state == 10 {
            // 待挑选
            let user = UserAccount()
            user.name = frame.status.from_name
            user.age = frame.status.from_age
            user.avatar = frame.status.from_avatar
            user.occupation = frame.status.from_job
            user.sex = frame.status.from_sex
            let non = SelectedViewController(user)
            self.navigationController?.pushViewController(non, animated: true)
           } else {
                // 以取消,待见面，未见面，以见面，以过期，以拒绝
                let user = UserViewController(frame.status)
                self.navigationController?.pushViewController(user, animated: true)
            }
        }
        
    }
    func reloadUI() {
        reloadNotification()
    }
    
}
extension InvitationCellViewController {
    fileprivate func headerRefresh() {
        self.page = 1
        request()
    }
    fileprivate func footerRefresh() {
        self.page = self.page + 1
        request()
    }
    private func request() {
        if type == 1 {
            let request =  RequestSendOrderListModel()
            request.user_id = UserAccountViewModel.standard.account?.uId
            request.page_index = self.page
            api.jmSendOrderList(request)
        }else {
            let request = RequestReceivedInvitationModel()
            request.to_user_id = UserAccountViewModel.standard.account?.uId
            request.page_index = self.page
            api.jmmReceivedInvitation(request)
        }
    }
    func requestData() {
        self.activityView.startAnimating()
        request()
    }
    func jmReceivedInvitationDone(request: RequestReceivedInvitationModel, response: ResponseReceivedInvitationModel) {
        if response.status == "ok" {
            if self.page == 1 {
                self.activityView.stopAnimating()
                /// 说明是下拉刷新
                self.tableView.mj_header.endRefreshing()
                self.dataArray.removeAllObjects()
                if response.userlist.count > 8 {
                    self.tableView.mj_footer.isHidden = false
                }
            }else{
                self.tableView.mj_footer.endRefreshing()
                if response.userlist.count == 0 {
                    self.tableView.mj_footer.isHidden = true
                }
            }
            for user in  response.userlist {
                let frame = ReceivedReleaseFrame()
                frame.status = user
                dataArray.add(frame)
            }
        }
        tableView.reloadData()
        
    }
    func jmSendOrderListDone(request: RequestSendOrderListModel, response: ResponseSendOrderListModel) {
        if response.status == "ok" {
            if self.page == 1 {
                self.activityView.stopAnimating()
                /// 说明是下拉刷新
                self.tableView.mj_header.endRefreshing()
                self.dataArray.removeAllObjects()
                if response.orders.count > 8 {
                    self.tableView.mj_footer.isHidden = false
                }
            }else{
                self.tableView.mj_footer.endRefreshing()
                if response.orders.count == 0 {
                    self.tableView.mj_footer.isHidden = true
                }
            }
            if response.status == "ok" {
                for row in 0 ..< response.orders.count {
                    let model = response.orders[row]
                    let frame = SendReleaseFrame()
                    frame.status = model
                    dataArray.add(frame)
                }
                tableView.reloadData()
            }
        }
        tableView.reloadData()
    }
    
}
