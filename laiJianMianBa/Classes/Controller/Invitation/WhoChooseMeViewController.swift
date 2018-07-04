//
//  WhoChooseMeViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/22.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit

class WhoChooseMeViewController: RootViewController {
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
        title = "谁选择了我"
        //requestData()
        initCollectionView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UI
extension WhoChooseMeViewController {
    func initCollectionView() {
        let layout = UICollectionViewFlowLayout();
        colView = UICollectionView(frame: CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.width, height: self.view.bounds.height-64 - 80), collectionViewLayout: layout)
        colView.backgroundColor = UIColor.white
        colView?.register(WaitingListCell.self, forCellWithReuseIdentifier: "WaitingListCell")
        colView?.delegate = self
        colView?.dataSource = self
        colView.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0)
        //layout.itemSize = CGSize(width: 375, height: 300)
        colView.backgroundColor = UIColor.red
        colView?.register(WhoChooseMeHeadView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        view.addSubview(colView!)
        let footerView = UserWaitingBtnView("再次邀请发起")
        footerView.delegate = self
        footerView.frame = CGRect(x: 0, y: colView.frame.maxY, w: screenW, h: 80)
        self.view.addSubview(footerView)
    }
}
extension WhoChooseMeViewController: UserWaitingBtnViewDelegate{
    /// 见
    internal func seeBtnDone() {
        
    }
    /// 不见
    func notSeeBtnDone(){
        
    }
    func secretBtnDone() {
        
    }
}
// MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension WhoChooseMeViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WaitingListCell", for: indexPath) as! WaitingListCell
       // cell.statusFrame = dataArray[indexPath.row] as! WaitingListFrame
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let frame = dataArray[indexPath.row] as! WaitingListFrame
        //        //let user = UserViewController(frame.status.orderid,status:frame.status.state)
        //        user.accept_uid = frame.status.accept_uid
        //        self.navigationController?.pushViewController(user, animated: true)
    }
    // 返回HeadView的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenW, height: 220)
    }
    // 返回自定义HeadView或者FootView，我这里以headview为例
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath as IndexPath) as? WhoChooseMeHeadView
        return reusableview!
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WhoChooseMeViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // let frame = dataArray[indexPath.row] as! WaitingListFrame
        return CGSize(width: (screenW-30)/2, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
}

// MARK: - JMAPIDelegate
extension WhoChooseMeViewController {
    /// 请求待挑选数据
    func requestData()  {
        self.activityView.startAnimating()
    }
}
