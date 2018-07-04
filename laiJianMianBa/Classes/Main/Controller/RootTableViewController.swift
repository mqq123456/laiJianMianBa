//
//  RootTableViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/19.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit

class RootTableViewController: RootViewController {
    
    /// lazy tableView
    lazy var tableView: UITableView = {
        let tempTableView = UITableView (frame: self.view.bounds, style: UITableViewStyle.grouped)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        return tempTableView
    }()
    /// lazy dataArray
    public lazy var dataArray : NSMutableArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension RootTableViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
}
