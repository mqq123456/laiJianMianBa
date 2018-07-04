//
//  NonresponseViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/19.
//  Copyright © 2016年 fundot. All rights reserved.
//  没有回应界面

import UIKit
//import JMServicesKit
/// tableView，分两部分，以虚线分隔，上部分headView，下部分footerView
class NonresponseViewController: RootTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "无回应"
        initTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UI
extension NonresponseViewController {
    func initTableView()  {
        let headView = Bundle.main.loadNibNamed("NonHeaderView", owner: self, options: nil)?.last as? NonHeaderView
        headView?.frame = CGRect(x: 0, y: 0, w: screenW, h: screenW*0.7)
        tableView.tableHeaderView = headView
        let footerView = NonFooterView(frame: CGRect(x: 0, y: 0, w: screenW, h: screenW*0.8)) as NonFooterView
        footerView.delegate = self
        tableView.tableFooterView = footerView
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor.white
    }
}

// MARK: - NonFooterViewDelegate
extension NonresponseViewController: NonFooterViewDelegate {
    func redBtnDone() {
        self.navigationController!.popToRootViewController(animated: true)
    }
    func infoBtnDone() {
        let edit = EditViewController()
        let nav = RootNavigationController(rootViewController: edit)
        self.navigationController?.present(nav, animated: true, completion: {
            
        })
    }
}
