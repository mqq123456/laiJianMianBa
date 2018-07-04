//
//  CategoryViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/7.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
/// 代理，返回被选择的数据模型
protocol CategoryViewControllerDelegate {
    func dismiss(_ message: [InterestModel], type: String)
}
/// 分类
class CategoryViewController: RootTableViewController {
    public var delegate: CategoryViewControllerDelegate!
    fileprivate var type:String!
    
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - type: 类型,1-活动明细（key-value)， 2-印象明细  3-热词 4-兴趣
    ///   - iclass: type=4时有效，兴趣分类 1-美食 2-运动 3-音乐 4-电影 5-书籍 （可扩展）
    init(_ type: String) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 加载数据
        let accountPath = Bundle.main.path(forResource: "conf", ofType: "plist")
        let dict:NSDictionary? = NSDictionary(contentsOfFile: accountPath!)
        var array = [String]()
        var myArray = [InterestModel]()
        if type == "0" {
            title = "美食"
            array = dict?["food"] as! [String]
            myArray = (UserAccountViewModel.standard.account?.getFoodHobbys())!
        }
        if type == "1" {
            title = "运动"
            array = dict?["sports"] as! [String]
            myArray = (UserAccountViewModel.standard.account?.getSportsHobbys())!
        }
        if type == "2" {
            title = "音乐"
            array = dict?["music"] as! [String]
            myArray = (UserAccountViewModel.standard.account?.getMusicHobbys())!
        }
        if type == "3" {
            title = "电影"
            array = dict?["move"] as! [String]
            myArray = (UserAccountViewModel.standard.account?.getMoveHobbys())!
        }
        if type == "4" {
            title = "书籍"
            array = dict?["book"] as! [String]
            myArray = (UserAccountViewModel.standard.account?.getBookHobbys())!
        }
        if type == "5" {
            title = "行业"
            array = dict?["area"] as! [String]
            myArray = (UserAccountViewModel.standard.account?.getArea())!
        }
        if type == "6" {
            title = "工作领域"
            array = dict?["job"] as! [String]
            myArray = (UserAccountViewModel.standard.account?.getJob()) ?? [InterestModel]()
        }
        if type == "7" {
            title = "家乡"
            array = dict?["hometown"] as! [String]
            myArray = (UserAccountViewModel.standard.account?.getHomeTown())!
        }
        for i in 0 ..< array.count {
            let model = InterestModel()
            model.id = "\(i)"
            model.isSelected = false
            model.iclass = array[i]
            model.type = self.type
            for myclass in myArray {
                if model.iclass == myclass.iclass {
                    // 说明是之前被选中的
                    model.isSelected = true
                }
            }
            self.dataArray.add(model)
        }
        for item in myArray {
            if array.contains(item.iclass) {
                
            }else{
                self.dataArray.add(item)
            }
        }
        self.view.addSubview(tableView)
        tableView.register(UINib(nibName: "CategoryHeadCell", bundle: nil), forCellReuseIdentifier: "CategoryHeadCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dissmissDelegate()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UITableViewDelegate
extension CategoryViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryHeadCell", for: indexPath) as! CategoryHeadCell
            
            if type == "0" {
                cell.title.text = "创建自己的美食"
            }else if type == "1" {
                cell.title.text = "创建自己的运动"
            }else if type == "2" {
                cell.title.text = "创建自己的音乐"
            }else if type == "3" {
                cell.title.text = "创建自己的电影"
            }else if type == "4"{
                cell.title.text = "创建自己的书籍"
            }else if type == "5"{
                cell.title.text = "创建自己的行业"
            }else if type == "6"{
                cell.title.text = "创建自己的工作领域"
            }else{
                cell.title.text = "创建自己的家乡"
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            let model = self.dataArray[indexPath.row-1] as? InterestModel
            cell.textLabel!.text = model?.iclass
            if (model?.isSelected)! {
                cell.accessoryType = .detailButton
                cell.accessoryView = UIImageView(image: UIImage(named: "hangye_yixuanze"))
                cell.accessoryView?.frame = CGRect(x: 0, y: 0, w: 14, h: 10)
            }else{
                cell.accessoryView = nil
                cell.accessoryType = .none
            }
            if (model?.isSelected)! {
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            }else{
                cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
            }
            return cell
        }
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count + 1
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let input = InputViewController()
            input.delegate = self
            input.type = self.type
            let nav = RootNavigationController(rootViewController: input)
            self.navigationController?.present(nav, animated: true, completion: {
            })
        }else{
            if type == "5" || type == "6" || type == "7" {
                var data = [InterestModel]()
                for i in 0 ..< self.dataArray.count {
                    let model = self.dataArray[i] as? InterestModel
                    model?.isSelected = false
                    if i == indexPath.row-1 {
                        model?.isSelected = true
                    }
                    data.append(model!)
                }
                self.dataArray.removeAllObjects()
                self.dataArray.addObjects(from: data)
                self.navigationController!.popViewController(animated: true)
            }else{
                let model = self.dataArray[indexPath.row-1] as? InterestModel
                model?.isSelected = !(model?.isSelected)!
            }
            tableView.reloadData()
        }
    }
}
extension CategoryViewController: InputViewControllerDelegate {
    func addCustormParseDone(_ parse: InterestModel) {
        dataArray.add(parse)
        tableView.reloadData()
        dissmissDelegate()
    }
    fileprivate func dissmissDelegate() {
        /// 我觉得可以在这个地方合成模型，传递给上个界面
        var array = [InterestModel]()
        for category  in self.dataArray {
            if ((category as? InterestModel) != nil) {
                let cate:InterestModel = (category as? InterestModel)!
                if cate.isSelected == true {
                    array.append(cate)
                }
            }
        }

        delegate.dismiss(array, type:type)
    }
}

