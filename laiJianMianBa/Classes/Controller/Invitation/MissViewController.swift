//
//  MissViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/26.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class MissViewController: RootTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = isBoy == true ? "她想见你" : "他想见你"
        initTableView()
        requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UI
extension MissViewController {
    func initTableView() {
        /// head
        let headVIew = Bundle.main.loadNibNamed("MissHeadView", owner: self, options: nil)?.last as! MissHeadView
        headVIew.frame = CGRect(x: 0, y: 0, w: screenW, h: screenW*0.7)
        tableView.tableHeaderView = headVIew
        tableView.register(MissCell.self, forCellReuseIdentifier: "MissCell")
        view.addSubview(tableView)
    }
}

// MARK: - UITableViewDelegate
extension MissViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MissCell", for: indexPath) as! MissCell
        let frame = dataArray[indexPath.row] as! MissFrame
        cell.statusFrame = frame
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let frame = dataArray[indexPath.row] as! MissFrame
        return frame.cellHeight
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let frame = dataArray[indexPath.row] as! MissFrame
//        let user = UserViewController(frame.status.orderid, status: frame.status.state)
//        self.navigationController?.pushViewController(user, animated: true)
        
    }
}

// MARK: - JMAPIDelegate
extension MissViewController {
    func requestData()  {
//        self.activityView.startAnimating()
//        let request = RequestMissPeopleModel()
//        request.userid = UserAccountViewModel.standard.account!.uId
//        api.jmmMissPeople(request)
    }
    func jmMissPeopleDone(request: RequestMissPeopleModel, response: ResponseMissPeopleModel) {
        self.activityView.stopAnimating()
        if response.status == "ok" {
            for model in response.orders {
                let frame = MissFrame()
                frame.status = model
                dataArray.add(frame)
            }
            tableView.reloadData()
        }
    }
}
