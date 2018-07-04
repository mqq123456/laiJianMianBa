//
//  SelectedViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/12.
//  Copyright © 2017年 fundot. All rights reserved.
//  挑选完成

import UIKit
//import JMServicesKit
class SelectedViewController: RootViewController {
    /// 职业
    @IBOutlet weak var occ: UILabel!
    /// 性别
    @IBOutlet weak var sex: UILabel!
    /// 年龄
    @IBOutlet weak var name: UILabel!
    /// 头像
    @IBOutlet weak var head: UIImageView!
    
    @IBOutlet weak var desc: UILabel!
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - orderid: 订单id
    ///   - status: 订单状态
    fileprivate var user: UserAccount!
    init(_ user: UserAccount) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let count = self.navigationController?.viewControllers.count
        if count! >= 2 {
            if (self.navigationController?.viewControllers[count!-2].isKind(of: UserViewController.self))! {
                var views = self.navigationController?.viewControllers
                views?.remove(at: count!-2)
                self.navigationController?.viewControllers = views!
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "待挑选"
        head.kf.setImage(with: URL(string: user.avatar), placeholder: UIImage(named:"loading"), options: nil, progressBlock: { (_, _) in
            
        }) { (image, error, _, _) in
            
        }
        sex.textColor = globalColor()
        if user.sex == 1 {
            sex.text = "♂"
        }else {
            sex.text = "♀"
        }
        
        self.name.text = user.name
        self.occ.text = user.occupation + " | " + user.age! + "岁"
        if isBoy {
            self.desc.text = "对方正在行使女生权力，将于1小时内做出选择，\n等待期间可以继续接受邀请。\n等待是为了更好的遇见。"
        }else{
            self.desc.text = "对方正在行使男生权力，将于1小时内做出选择，\n等待期间可以继续接受邀请。\n等待是为了更好的遇见。"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
