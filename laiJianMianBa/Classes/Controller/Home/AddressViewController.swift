//
//  AddressViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/21.
//  Copyright © 2016年 fundot. All rights reserved.
//  选择见面地址界面

import UIKit
//import JMServicesKit

class AddressViewController: RootTableViewController {
    var delegate: HomeControllerBackDelegate!
    
    /// 搜索api
    fileprivate lazy var searchApi: AMapSearchAPI = {
        let search = AMapSearchAPI()
        search?.delegate = self
        return search!
    }()
    /// 输入框
    fileprivate var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        var height:CGFloat = 50
        if IPHONE4 || IPHONE5 {
            height = 40
        }else if IPhone6 {
            height = 44
        }
        title = "见面位置"
        let imageView = UIImageView(frame: CGRect(x: 15, y:64 + 20, w: screenW-30, h: height))
        if isBoy {
            imageView.image = UIImage(named: "jianmianweizhi_nan")
        }else{
            imageView.image = UIImage(named: "jianmianweizhi_nv")
        }
        self.view.addSubview(imageView)
        textField = UITextField(x: 30, y:64 + 20, w: screenW-120, h: height)
        textField.borderStyle = .none
        textField.placeholder = "仅限正规营业场所AA"
        textField.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(textField)
        let searchBtn = UIButton(x: textField.frame.maxX , y: 20 + 64, w: 80, h: height, target: self, action: #selector(searchDone))
        textField.delegate = self
        textField.becomeFirstResponder()
        view.addSubview(searchBtn)
        searchBtn.backgroundColor = UIColor.clear
        
        let tipsLabel = UILabel(frame: CGRect(x: 30, y: textField.frame.maxY + 5, w: screenW-40, h: 21))
        tipsLabel.text = "体现绅士风度，倡导男生买单！"
        tipsLabel.font = UIFont.systemFont(ofSize: 14)
        tipsLabel.textColor = globalColor()
        self.view.addSubview(tipsLabel)
        
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AddressCell")
        tableView.frame = CGRect(x: 0, y: tipsLabel.frame.maxY + 5, w: screenW, h: screenH-tipsLabel.frame.maxY - 5)
        self.view.addSubview(tableView)
    }
    @objc fileprivate func searchDone() {
        if self.textField.text == "" {
            makeToast("请输入信息")
            return
        }
        self.activityView.startAnimating()
        self.view.endEditing(true)
        let request: AMapPOIAroundSearchRequest = AMapPOIAroundSearchRequest()
        request.keywords = self.textField.text!
        request.types = "餐厅|咖啡厅|台球|电影院"
        let lat = UserDefaults.standard.object(forKey: "latitude") as? Double ?? 0
        let lon = UserDefaults.standard.object(forKey: "longitude") as? Double ?? 0
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(lat), longitude: CGFloat(lon))
        request.radius = 5000
        searchApi.aMapPOIAroundSearch(request)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - UITextFieldDelegate
extension AddressViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.searchDone()
        return true
    }
}
// MARK: - UITableViewDelegate,UITableViewDataSource
extension AddressViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath)
        let poi = self.dataArray[indexPath.row] as? AMapPOI
        cell.textLabel?.textColor = UIColor("333333")
        cell.textLabel!.text = poi?.name
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let poi = self.dataArray[indexPath.row] as? AMapPOI
        delegate.addressBack((poi?.name)!,location: poi!.location)
        self.navigationController!.popViewController(animated: true)
    }
}

// MARK: - AMapSearchDelegate
extension AddressViewController: AMapSearchDelegate {
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        self.activityView.stopAnimating()
    }
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        /// 搜索回调
        self.activityView.stopAnimating()
        self.dataArray.removeAllObjects()
        self.dataArray.addObjects(from: response.pois)
        tableView.reloadData()
    }
}
