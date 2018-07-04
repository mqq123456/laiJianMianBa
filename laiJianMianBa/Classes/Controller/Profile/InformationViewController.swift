//
//  InformationViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/26.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class InformationViewController: RootTableViewController {
    fileprivate var scrollViewVC : UnlimitedSlideVC!
    
    /// 断头信息
    fileprivate lazy var headString : [String] =  ["","他人印象","基本资料","我的社交帐号","我的兴趣"]
    
    /// 标题信息
    fileprivate lazy var titleString : NSArray = NSArray(array: [[UserAccountViewModel.standard.account?.name ?? "","我的钱包",isBoy == true ? "她想见你" : "他想见你"],[""],["行业","工作领域","公司","家乡","个性签名"],["我的微信号"],["","","","",""]])
    
    fileprivate lazy var impress: [ImpressModel] = {
       return [ImpressModel]()
    }()
    fileprivate lazy var impressTags: [ZWTagModel] = {
        return [ZWTagModel]()
    }()
    /// 图标信息
    fileprivate lazy var iconString : [String] = ["bianjiziliao_meishi","bianjiziliao_yundong","bianjiziliao_yinyue","bianjiziliao_dianying","bianjiziliao_shuji"]
    
    /// 动态计算兴趣cell高度
    fileprivate lazy var heights = [50.0,50,50,50,50]
    
    /// 特人印象cell高度
    fileprivate lazy var impressionHeight = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// head
        title = UserAccountViewModel.standard.account?.name
        initTableView()
        initNavBtns()
        /// 获取他人印象评价
        requestEvaluation()
       // setUserImpress()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

// MARK: - UI
extension InformationViewController {
    fileprivate func initHeadView() {
        if UserAccountViewModel.standard.account!.getHeadsCount() >= 2 {
            scrollViewVC = UnlimitedSlideVC()
            scrollViewVC.delegate = self
            scrollViewVC.isPageControl = NSNumber(value: true as Bool)
            self.addChildViewController(scrollViewVC)
            scrollViewVC.view.frame = CGRect(x: 0, y: 0, width: screenW, height: screenW);
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapAction(_:)))
            scrollViewVC.view.addGestureRecognizer(tap)
            tableView.tableHeaderView = scrollViewVC.view
        }else{
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenW))
            imageView.backgroundColor = UIColor.white
            imageView.kf.setImage(with: URL(string: UserAccountViewModel.standard.account!.avatar), placeholder: UIImage(named: ""), options: nil, progressBlock: { (_, _) in
                
            }, completionHandler: { (image, error, _, _) in
                
            })
            tableView.tableHeaderView = imageView
        }
    }
    func initTableView() {
        initHeadView()
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "InformationCell")
        tableView.register(UINib(nibName: "InfoHobbyCell", bundle: nil), forCellReuseIdentifier: "InfoHobbyCell")
        tableView.register(UINib(nibName: "InfoInputCell", bundle: nil), forCellReuseIdentifier: "InfoInputCell")
         tableView.register(UINib(nibName: "InfoNameCell", bundle: nil), forCellReuseIdentifier: "InfoNameCell")
        tableView.register(ImpressionCell.self, forCellReuseIdentifier: "ImpressionCell")
    }
    func initNavBtns() {
        let rightBtn = UIButton(x: 0, y: 0, w: 40, h: 40, target: self, action: #selector(rightBtnDone))
        rightBtn.contentMode = .right
        rightBtn.setTitle("编辑", for: .normal)
        rightBtn.setTitleColor(UIColor.gray, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
    }
    @objc func rightBtnDone() {
        let edit = EditViewController()
        edit.delegate = self
        let nav = RootNavigationController(rootViewController: edit)
        self.navigationController?.present(nav, animated: true, completion: {
            
        })
    }
}

// MARK: - UnlimitedSlideVCDelegate
extension InformationViewController: UnlimitedSlideVCDelegate {
    func backDataSourceArray() -> NSMutableArray {
        return NSMutableArray(array: (UserAccountViewModel.standard.account?.headImgs)!);
    }
    
    func backScrollerViewForWidthAndHeight() -> CGSize {
        return CGSize(width: screenW, height: screenW)
    }
    func handleTapAction(_ tap:UITapGestureRecognizer)->Void{
        //let page : Int = scrollViewVC.backCurrentClickPicture()
    }
}

// MARK: - UITableViewDelegate
extension InformationViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = ImpressionCell(style: .default, reuseIdentifier: "ImpressionCell")
            cell.selectionStyle = .none
            cell.titles = impressTags
            impressionHeight = Double(cell.height!)
            return cell
        }
        if indexPath.section == 2 || indexPath.section == 3  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoInputCell", for: indexPath) as! InfoInputCell
            cell.selectionStyle = .none
            cell.title.text = (titleString[indexPath.section] as! NSArray)[indexPath.row] as? String
            if indexPath.row == 0 && indexPath.section == 2 {
                cell.input.text = UserAccountViewModel.standard.account!.industry
            }else if indexPath.row == 0 && indexPath.section == 3 {
                cell.input.text = UserAccountViewModel.standard.account!.weChatAccount
            }else if indexPath.row == 1 {
                cell.input.text = UserAccountViewModel.standard.account!.occupation
            }else if indexPath.row == 2 {
                cell.input.text = UserAccountViewModel.standard.account!.company
            }else if indexPath.row == 3 {
                cell.input.text = UserAccountViewModel.standard.account!.hometown
            }else if indexPath.row == 4 {
                cell.input.text = UserAccountViewModel.standard.account!.signature
            }
            return cell
        }
        if indexPath.section == 4 {
            let cell = Bundle.main.loadNibNamed("InfoHobbyCell", owner: self, options: nil)?.last as! InfoHobbyCell
            cell.selectionStyle = .none
            cell.icon.image = UIImage(named: iconString[indexPath.row])
            if indexPath.row == 0 {
                var array = [ZWTagModel]()
                for hobby in UserAccountViewModel.standard.account!.getFoodHobbys()  {
                    let model = ZWTagModel()
                    model.title = hobby.iclass
                    model.textColor = UIColor("b5331c")
                    model.borderColor = UIColor("f7b0a4")
                    model.backgroundColor = UIColor("f7b0a4")
                    array.append(model)
                }
                cell.titles = array
                cell.placeHorder.text = "请填写喜欢的食物"
            }
            if indexPath.row == 1 {
                var array = [ZWTagModel]()
                for hobby in UserAccountViewModel.standard.account!.getSportsHobbys()  {
                    let model = ZWTagModel()
                    model.title = hobby.iclass
                    model.textColor = UIColor("13602d")
                    model.borderColor = UIColor("cfead8")
                    model.backgroundColor = UIColor("cfead8")
                    array.append(model)
                }
                cell.titles = array
                cell.placeHorder.text = "请填写喜欢的运动"
            }
            if indexPath.row == 2 {
                var array = [ZWTagModel]()
                for hobby in UserAccountViewModel.standard.account!.getMusicHobbys()  {
                    let model = ZWTagModel()
                    model.title = hobby.iclass
                    model.textColor = UIColor("344da1")
                    model.borderColor = UIColor("b6c0de")
                    model.backgroundColor = UIColor("b6c0de")
                    array.append(model)
                }
                cell.titles = array
                cell.placeHorder.text = "请填写喜欢的音乐"
            }
            if indexPath.row == 3 {
                var array = [ZWTagModel]()
                for hobby in UserAccountViewModel.standard.account!.getMoveHobbys()  {
                    let model = ZWTagModel()
                    model.title = hobby.iclass
                    model.textColor = UIColor("5157d")
                    model.borderColor = UIColor("b6c0de")
                    model.backgroundColor = UIColor("b6c0de")
                    array.append(model)
                }
                cell.titles = array
                cell.placeHorder.text = "请填写喜欢的电影"
            }
            if indexPath.row == 4 {
                var array = [ZWTagModel]()
                for hobby in UserAccountViewModel.standard.account!.getBookHobbys()  {
                    let model = ZWTagModel()
                    model.title = hobby.iclass
                    model.textColor = UIColor("a98110")
                    model.borderColor = UIColor("feeebf")
                    model.backgroundColor = UIColor("feeebf")
                    array.append(model)
                }
                cell.placeHorder.text = "请填写喜欢的书籍"
                cell.titles = array
            }
            heights[indexPath.row] = Double(cell.height!)
            return cell
        }
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = Bundle.main.loadNibNamed("InfoNameCell", owner: self, options: nil)?.last as! InfoNameCell
            cell.selectionStyle = .none
            var titles = [String]()
            if isBoy == true {
                titles.append(" \(UserAccountViewModel.standard.account!.age!)")
            }
            if isBoy == false {
                titles.append(" \(UserAccountViewModel.standard.account!.age!)")
            }
            if UserAccountViewModel.standard.account!.birthday() != "" {
                titles.append(ZWTagModel.calculateConstellation(withMonth: UserAccountViewModel.standard.account!.birthday()))
            }
            if UserAccountViewModel.standard.account!.height! != 0 {
                titles.append("\(UserAccountViewModel.standard.account!.height!)cm")
            }
            if UserAccountViewModel.standard.account!.income! != "" {
                titles.append("\(UserAccountViewModel.standard.account!.income!)")
            }
            cell.tags = titles
            cell.labelbackgroundColor = "04bec2"
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "InformationCell", for: indexPath)
        cell.textLabel!.text = (titleString[indexPath.section] as! NSArray)[indexPath.row] as? String
        cell.textLabel?.textColor = UIColor("333333")
        if indexPath.row != 0 {
            cell.accessoryType = .disclosureIndicator
        } else {
             cell.accessoryType = .none
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return CGFloat(impressionHeight)
        }
        if indexPath.section == 4 {
            return CGFloat(heights[indexPath.row])
        }
        if indexPath.section == 0 && indexPath.row == 0 {
            return 70
        }
        return 50
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (titleString[section] as! NSArray).count as Int
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headString.count as Int
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.00001
        }
        return 40
    }
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headString[section]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 && indexPath.row == 1 { // 我的钱包
            navigationController?.pushViewController(WalletViewController(), animated: true)
        }
        if indexPath.section == 0 && indexPath.row == 2 {// 错过的见面
            navigationController?.pushViewController(MissViewController(), animated: true)
        }
    }
}
extension InformationViewController: EditViewControllerDelegate {
    func editSuccessBack() {
        tableView.reloadData()
        title = UserAccountViewModel.standard.account?.name
        if (UserAccountViewModel.standard.account?.getHeadsCount())! >= 2 {
            // 说明是
            tableView.tableHeaderView?.removeFromSuperview()
            // 重新添加头
            initHeadView()
        }
        makeToast("个人信息修改成功")
    }
}
// MARK: - JMAPIDelegate
extension InformationViewController {
    func requestEvaluation() {
        let request = RequestUserDetailModel()
        request.id = UserAccountViewModel.standard.account?.uId
        request.impress = true
        api.jmGetUserDetail(request)
    }
    func jmGetUserDetailDone(request: RequestUserDetailModel, response: ResponseUserDetailModel) {
        //个人印象
        var i = 0
        for (key,value) in response.user.impressions {
            i += 1
            let model = ZWTagModel()
            model.title = key + " " + "X\(value)"
            model.textColor = UIColor.white
            model.backgroundColor = UIColor(getTagsSelectedColor(i))
            self.impressTags.append(model)
        }
        tableView.reloadData()
    }
    
}
