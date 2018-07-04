//
//  WaitingSelectListViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/21.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class WaitingSelectListViewController: RootViewController {
    /// collectionView
    fileprivate var colView: UICollectionView!
    /// 数据
    fileprivate lazy var dataArray : NSMutableArray = NSMutableArray()
    /// 订单ID
    fileprivate var orderid: Int!
    /// 初始化方法
    ///
    /// - Parameter orderid: 订单id
    init(_ orderid: Int) {
        super.init(nibName: nil, bundle: nil)
        self.orderid = orderid
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "待挑选"
        requestData()
        initCollectionView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UI
extension WaitingSelectListViewController {
    func initCollectionView() {
        let headView = WaitingHeadView(frame: CGRect(x: 0, y: 64, w: screenW, h: 60))
        if isBoy {
            headView.tips.text = "以下妹子都已选择与你见面，请查看资料选择最为心动的一位去见面吧！如我见面未成功，诚意红包会全额退还。"
        }else{
            headView.tips.text = "以下帅哥都已附带诚意红包与你见面，请查看资料选择最为心动的一位去见面吧！"
        }
        self.view.addSubview(headView)
        let layout = UICollectionViewFlowLayout();
        colView = UICollectionView(frame: CGRect.init(x: 0, y: 64+60, width: UIScreen.main.bounds.width, height: self.view.bounds.height-64 - 60), collectionViewLayout: layout)
        colView.backgroundColor = UIColor.white
        colView?.register(WaitingListCell.self, forCellWithReuseIdentifier: "WaitingListCell")
        colView?.delegate = self
        colView?.dataSource = self
        //layout.itemSize = CGSize(width: 375, height: 300)
        colView.backgroundColor = UIColor.white
        view.addSubview(colView!)
    }
}
// MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension WaitingSelectListViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaitingListCell", for: indexPath) as! WaitingListCell
        cell.statusFrame = dataArray[indexPath.row] as! WaitingListFrame
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let frame = dataArray[indexPath.row] as! WaitingListFrame
        let user = UserViewController(frame.status)
        self.navigationController?.pushViewController(user, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WaitingSelectListViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = dataArray[indexPath.row] as! WaitingListFrame
        return CGSize(width: (screenW-30)/2, height: frame.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
}

// MARK: - JMAPIDelegate
extension WaitingSelectListViewController {
    /// 请求待挑选数据
    func requestData()  {
        self.activityView.startAnimating()
        let request = RequestAcceptOrderUsersModel()
        request.order_id = self.orderid
        api.jmAcceptOrderUsers(request)
    }
    func jmAcceptOrderUsersDone(request: RequestAcceptOrderUsersModel, response: ResponseAcceptOrderUsersModel) {
        self.activityView.stopAnimating()
        if response.status == "ok" {
            for item in response.users {
                let frame = WaitingListFrame()
                frame.status = item
                self.dataArray.add(frame)
            }
        }
        colView.reloadData()
    }
}
