//
//  EditViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/6.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit
import AliyunOSSiOS
//import JMServicesKit
protocol EditViewControllerDelegate {
    func editSuccessBack()
}

class EditViewController: RootTableViewController {
    public var delegate: EditViewControllerDelegate!
    /// 段头信息
    fileprivate lazy var headString : [String] =  ["基本资料","我的兴趣"]
    
    /// 标题信息
    fileprivate lazy var titleString : NSArray = NSArray(array: ["昵称","生日","身高","收入","微信号","行业","工作领域","公司","家乡","个性签名"])
    
    /// 图标信息
    fileprivate lazy var iconString : [String] = ["bianjiziliao_meishi","bianjiziliao_yundong","bianjiziliao_yinyue","bianjiziliao_dianying","bianjiziliao_shuji"]
    
    /// 动态计算兴趣标签cell高度
    fileprivate lazy var heights = [50.0,50,50,50,50]
    
    /// 上传头像弹框
    fileprivate var uploadAlertController:UIAlertController!
    
    /// 图片上传控制器
    fileprivate var imagePickerController:UIImagePickerController!
    
    /// 图片
    fileprivate var imgView: UIImageView!
    fileprivate var client: OSSClient = {
        /// 图片上传tast
        let edpoint = "http://oss-cn-beijing.aliyuncs.com"
        let credential = OSSPlainTextAKSKPairCredentialProvider.init(plainTextAccessKey: "LTAIvDpvG791jYxG", secretKey: "sWPWbTfLwIg6Dxq8D0DlzmMMOieZaj")
        let client = OSSClient.init(endpoint: edpoint, credentialProvider: credential!)
        let conf = OSSClientConfiguration()
        conf.maxRetryCount = 1
        conf.timeoutIntervalForRequest = 30
        conf.timeoutIntervalForResource = TimeInterval(24 * 60 * 60)
        return client
    }()
    // MARK: - 需要上传给服务器信息
    fileprivate var name: String = {
        return UserAccountViewModel.standard.account!.name
    }()
    fileprivate var head: String = {
        return UserAccountViewModel.standard.account!.avatar
    }()
    var timeInterval : TimeInterval!
    fileprivate var birthday: String = {
        return UserAccountViewModel.standard.account!.birthday()
    }()
    fileprivate var height: Int = {
        return UserAccountViewModel.standard.account!.height
    }()
    fileprivate var income: String = {
        return UserAccountViewModel.standard.account!.income
    }()
    fileprivate var weChatAccount: String = {
        return UserAccountViewModel.standard.account!.weChatAccount
    }()
    fileprivate var industry: String = {
        return UserAccountViewModel.standard.account!.industry
    }()
    fileprivate var occupation: String = {
        return UserAccountViewModel.standard.account!.occupation
    }()
    fileprivate var company: String = {
        return UserAccountViewModel.standard.account!.company
    }()
    fileprivate var hometown: String = {
        return UserAccountViewModel.standard.account!.hometown
    }()
    fileprivate var signature: String = {
        return UserAccountViewModel.standard.account!.signature
    }()
    fileprivate var headImages: [String] = {
        if (UserAccountViewModel.standard.account!.headImgs != nil) && (UserAccountViewModel.standard.account!.headImgs.count >= 6 ) {
            return UserAccountViewModel.standard.account!.headImgs
        }else{
            return [UserAccountViewModel.standard.account!.avatar,"","","","",""]
        }
    }()
    /** 饮食爱好 */
    fileprivate var foodHobbys: [InterestModel] = {
        return UserAccountViewModel.standard.account!.getFoodHobbys()
    }()
    fileprivate var isSelectCategory: Bool = {
        return false
    }()
    /** 运动爱好 */
    fileprivate var sportsHobbys: [InterestModel] = {
        return UserAccountViewModel.standard.account!.getSportsHobbys()
    }()
    /** 音乐爱好 */
    fileprivate var musicHobbys: [InterestModel] = {
        return UserAccountViewModel.standard.account!.getMusicHobbys()
    }()
    /** 电影爱好 */
    fileprivate var moveHobbys: [InterestModel] = {
        return UserAccountViewModel.standard.account!.getMoveHobbys()
    }()
    /** 读书爱好 */
    fileprivate var bookHobbys: [InterestModel] = {
        return UserAccountViewModel.standard.account!.getBookHobbys()
    }()
    
    fileprivate var images: [String]!
    fileprivate var isEditText: Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "编辑个人资料"
        initTableHeadView()
        initAlertController()
        initImagePickerController()
        initNavBtns()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
// MARK: - UI
extension EditViewController {
    func initTableHeadView()  {
        /// head
        let headView = Bundle.main.loadNibNamed("PerfectHeadImageView", owner: nil, options: nil)?.first as? PerfectHeadImageView
        headView?.frame = CGRect(x: 0, y: 0, w: screenW, h: screenW)
        headView?.img1.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(actionShow(tap:))))
        headView?.img2.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(actionShow(tap:))))
        headView?.img3.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(actionShow(tap:))))
        headView?.img4.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(actionShow(tap:))))
        headView?.img5.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(actionShow(tap:))))
        headView?.bigImg.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(actionShow(tap:))))
        tableView.tableHeaderView = headView
        
        view.addSubview(tableView)
        tableView.register(UINib(nibName: "InfoHobbyCell", bundle: nil), forCellReuseIdentifier: "InfoHobbyCell")
        tableView.register(UINib(nibName: "InfoInputCell", bundle: nil), forCellReuseIdentifier: "InfoInputCell")
    }
    func initNavBtns() {
        let leftBtn = UIButton(x: 0, y: 0, w: 40, h: 40, target: self, action: #selector(leftBtnDone))
        leftBtn.contentMode = .right
        leftBtn.setTitle("取消", for: .normal)
        leftBtn.setTitleColor(UIColor.gray, for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
        
        let rightBtn = UIButton(x: 0, y: 0, w: 40, h: 40, target: self, action: #selector(rightBtnDone))
        rightBtn.contentMode = .right
        rightBtn.setTitle("保存", for: .normal)
        rightBtn.setTitleColor(UIColor.gray, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
    }
    @objc func leftBtnDone() {
        self.navigationController?.dismiss(animated: true, completion: {
            
        })
    }
}

// MARK: - UITableViewDelegate
extension EditViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0   {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoInputCell", for: indexPath) as! InfoInputCell
            cell.selectionStyle = .none
            cell.title.text = titleString[indexPath.row] as? String
            cell.input.tag = indexPath.row + 1000
            cell.input.delegate = self
            if indexPath.row == 0 || indexPath.row == 4 || indexPath.row == 7 || indexPath.row == 9 {
                cell.input.isEnabled = true
            }else{
                cell.input.isEnabled = false
            }
            
            if (self.name != "") && indexPath.row == 0 {
                cell.input.text = self.name
            }
            if (self.birthday != "") && indexPath.row == 1 {
                cell.input.text = self.birthday
            }
            if (self.height != 0) && indexPath.row == 2 {
                cell.input.text = "\(self.height)cm"
            }
            if (self.income != "") && indexPath.row == 3 {
                cell.input.text = self.income
            }
            if (self.weChatAccount != "") && indexPath.row == 4 {
                cell.input.text = self.weChatAccount
            }
            if (self.industry != "") && indexPath.row == 5 {
                cell.input.text = self.industry
            }
            if (self.occupation != "") && indexPath.row == 6{
                cell.input.text = self.occupation
            }
            if (self.company != "") && indexPath.row == 7 {
                cell.input.text = self.company
            }
            if (self.hometown != "") && indexPath.row == 8 {
                cell.input.text = self.hometown
            }
            if (self.signature != "") && indexPath.row == 9 {
                cell.input.text = self.signature
            }
            return cell
        }else {
            let cell = Bundle.main.loadNibNamed("InfoHobbyCell", owner: self, options: nil)?.last as! InfoHobbyCell
            cell.selectionStyle = .none
            cell.icon.image = UIImage(named: iconString[indexPath.row])
            if indexPath.row == 0 {
                var array = [ZWTagModel]()
                for hobby in foodHobbys  {
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
                for hobby in sportsHobbys  {
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
                for hobby in musicHobbys  {
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
                for hobby in moveHobbys  {
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
                for hobby in bookHobbys  {
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
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return CGFloat(heights[indexPath.row])
        }
        return 44
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return titleString.count
        }
        return 5
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headString.count as Int
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headString[section]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.view.endEditing(true)
        if indexPath.section == 0 && indexPath.row == 1 {
            // 生日
            let picker = PickerView.initWith(row: 8, arr1: [], arr2: [], arr3: [])
            picker.delegate = self
            picker.show(navigationController!)
        }
        if indexPath.section == 0 && indexPath.row == 2 {
            // 身高
            let arr = NSMutableArray()
            for i in 140 ..< 201 {
                arr.add("\(i)cm")
            }
            let picker = PickerView.initWith(row: 1, arr1: arr, arr2: [], arr3: [])
            picker.delegate = self
            picker.show(navigationController!)
        }
        if indexPath.section == 0 && indexPath.row == 3 {
            // 收入
            let picker = PickerView.initWith(row: 1, arr1: ["5000-10000元","10000元-20000元","20000元以上"], arr2: [], arr3: [])
            picker.delegate = self
            picker.show(navigationController!)
        }
        if indexPath.section == 0 && indexPath.row == 5 {
            // 行业
            let category = CategoryViewController("5")
            category.delegate = self
            self.navigationController?.pushViewController(category, animated: true)
        }
        if indexPath.section == 0 && indexPath.row == 6 {
            // 工作领域
            let category = CategoryViewController("6")
            category.delegate = self
            self.navigationController?.pushViewController(category, animated: true)
        }
        if indexPath.section == 0 && indexPath.row == 8 {
            // 家乡
            let category = CategoryViewController("7")
            category.delegate = self
            self.navigationController?.pushViewController(category, animated: true)
        }
        if indexPath.section == 1 {
            let type:String = "\(indexPath.row)"
            let category = CategoryViewController(type)
            category.delegate = self
            self.navigationController?.pushViewController(category, animated: true)
        }
    }
}

// MARK: - PickerViewDelegate
extension EditViewController: PickerViewDelegate,CategoryViewControllerDelegate {
    func selectDone(_ model: PickerModel) {
        if (model.time != nil) && (model.time == "date") {
            self.timeInterval = model.timeInterval
            self.birthday = model.frist!
        }else {
            let str = NSString(string: model.frist!)
            if str.length > 5 {
                self.income = model.frist!
            }else{
                self.height = Int(NSString(string: model.frist!).intValue)
            }
        }
        self.tableView.reloadData()
    }
    func dismiss(_ message: [InterestModel], type: String) {
        if type == "0" {
            self.foodHobbys = message
        }
        if type == "1" {
            self.sportsHobbys = message
        }
        if type == "2" {
            self.musicHobbys = message
        }
        if type == "3" {
            self.moveHobbys = message
        }
        if type == "4" {
            self.bookHobbys = message
        }
        if type == "5" {
            if message.count > 0 {
                let model = message.first
                self.industry = model!.iclass
            }
        }
        if type == "6" {
            if message.count > 0 {
                let model = message.first
                self.occupation = model!.iclass
            }
        }
        if type == "7" {
            if message.count > 0 {
                let model = message.first
                self.hometown = model!.iclass
            }
        }
        isSelectCategory = true
        rightBtnDone()
        tableView.reloadData()
    }
}
// MARK: - 调用相册 UIImagePickerControllerDelegate
extension EditViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func initAlertController()
    {
        weak var blockSelf = self
        uploadAlertController = UIAlertController(title:nil, message: nil, preferredStyle:UIAlertControllerStyle.actionSheet)
        let takePhoto = UIAlertAction(title:"拍照", style:UIAlertActionStyle.default) { (action:UIAlertAction)in
            blockSelf?.actionAction(action: action)
        }
        let photoLib = UIAlertAction(title:"从相册选择", style:UIAlertActionStyle.default) { (action:UIAlertAction)in
            blockSelf?.actionAction(action: action)
        }
        let cancel = UIAlertAction(title:"取消", style:UIAlertActionStyle.cancel) { (action:UIAlertAction)in
            blockSelf?.actionAction(action: action)
        }
        self.uploadAlertController?.addAction(takePhoto)
        self.uploadAlertController?.addAction(photoLib)
        self.uploadAlertController?.addAction(cancel)
    }
    
    func initImagePickerController()
    {
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.delegate = self
        // 设置是否可以管理已经存在的图片或者视频
        self.imagePickerController.allowsEditing = true
    }
    func actionAction(action:UIAlertAction)
    {
        if action.title == "拍照" {
            self.getImageFromPhotoLib(type: .camera)
        }else if action.title == "从相册选择" || action.title == "更换头像" {
            self.getImageFromPhotoLib(type: .photoLibrary)
        }else if action.title == "删除照片" {
            
        }
    }
    func getImageFromPhotoLib(type:UIImagePickerControllerSourceType)
    {
        self.imagePickerController.sourceType = type
        //判断是否支持相册
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.present(self.imagePickerController, animated: true, completion:nil)
        }
    }
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [String :Any]){
        
        let type:String = (info[UIImagePickerControllerMediaType]as!String)
        //当选择的类型是图片
        if type == "public.image"
        {
            //let img = info[UIImagePickerControllerOriginalImage]as?UIImage
            let img = info[UIImagePickerControllerEditedImage]as? UIImage
            imgView.image = img
            let imgData = UIImageJPEGRepresentation(img!,0.5)
            uploadImage(data: imgData!, tag: imgView.tag)
            picker.dismiss(animated:true, completion:nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController){
        picker.dismiss(animated:true, completion:nil)
    }
    func actionShow(tap: UITapGestureRecognizer)  {
        imgView = tap.view as! UIImageView!
        imgView.tag = (tap.view?.tag)!
        present(self.uploadAlertController, animated:true, completion: nil)
    }
    private func uploadImage(data: Data, tag: Int) {
        
        let put = OSSPutObjectRequest()
        put.bucketName = "lianjianmianba-v2"
        let uid = UserAccountViewModel.standard.account!.uId!
        let utag = String(tag)
        put.objectKey = "\(uid)_ios_\(utag)_\(Int(Date().timeIntervalSince1970)).jpeg"
        put.uploadingData = data
        let putTask = client.putObject(put)
        putTask.continue({ (task) -> Any? in
            
            let ttt = self.client.presignPublicURL(withBucketName: "lianjianmianba-v2", withObjectKey: "userid_ios_1")
            if ttt.error == nil {
                //let result = task.result as? OSSPutObjectResult
                ///拼接请求
                let url = "http://\(put.bucketName!).oss-cn-beijing.aliyuncs.com/\(put.objectKey!)"
                if tag == 100 {
                    //最大的图
                    self.headImages[0] = url
                }
                if tag == 101 {
                    self.headImages[1] = url
                }
                if tag == 102 {
                    self.headImages[2] = url
                }
                if tag == 103 {
                    self.headImages[3] = url
                }
                if tag == 104 {
                    self.headImages[4] = url
                }
                if tag == 105 {
                    self.headImages[5] = url
                }
                FDLog("upload object success")
            } else {
                FDLog("upload object failed, error = \(task.error)")
            }
            return nil
        })
    }
    
}

// MARK: - UITextFieldDelegate
extension EditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.isEditText = true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.isEditText = false
        if textField.tag == 1000 {
            self.name = textField.text!
        }
        if textField.tag == 1004 {
            self.weChatAccount = textField.text!
        }
        if textField.tag == 1005 {
            self.industry = textField.text!
        }
        if textField.tag == 1006 {
            self.occupation = textField.text!
        }
        if textField.tag == 1007 {
            self.company = textField.text!
        }
        if textField.tag == 1008  {
            self.hometown = textField.text!
        }
        if textField.tag == 1009  {
            self.signature = textField.text!
        }
        tableView.reloadData()
    }
}

// MARK: - JMAPIDelegate
extension EditViewController {
    @objc func rightBtnDone() {
        if self.isEditText == true {
            self.view.endEditing(true)
            self.rightBtnDone()
            return
        }
        /// 修改用户信息
        let request = RequestUserChangeModel()
        request.userid = UserAccountViewModel.standard.account?.uId
        request.name = self.name
        var headArr = [String]()
        for item in  self.headImages {
            if item != "" {
                headArr.append(item)
            }
        }
        let arr = NSMutableArray(array: headArr)
        let heads = arr.componentsJoined(by: ",")
        request.heads = heads
        var str: String = String()
        for inter in foodHobbys {
            str.append("\(inter.id!)|0|\(inter.iclass!),")
        }
        for inter in sportsHobbys {
            str.append("\(inter.id!)|1|\(inter.iclass!),")
        }
        for inter in musicHobbys {
            str.append("\(inter.id!)|2|\(inter.iclass!),")
        }
        for inter in moveHobbys {
            str.append("\(inter.id!)|3|\(inter.iclass!),")
        }
        for inter in bookHobbys {
            str.append("\(inter.id!)|4|\(inter.iclass!),")
        }
        if str.characters.count > 0 {
            request.interest = str
        }else{
            request.interest = ""
        }
        if self.weChatAccount.characters.count > 0 {
            request.weixin = self.weChatAccount
        }
        if self.occupation.characters.count > 0 {
            request.job = self.occupation
        }
        if (self.timeInterval != nil) && (self.timeInterval > 0) {
            request.birthday = self.timeInterval
        }
        if self.height > 0 {
            request.height = self.height
        }
        if self.income.characters.count > 0 {
            request.income = self.income
        }
        if self.signature.characters.count > 0 {
            request.signature = self.signature
        }
        if self.company.characters.count > 0 {
            request.company = self.company
        }
        if self.hometown.characters.count > 0 {
            request.hometown = self.hometown
        }
        if self.industry.characters.count > 0 {
            request.area = self.industry
        }
        api.jmUserChange(request)
        self.activityView.startAnimating()
    }
    func jmUserChangeDone(request: RequestUserChangeModel, response: ResponseUserChangeModel) {
        // 获取用户详情
        if response.status == "ok" {
            getUserDetail()
        }else{
            self.activityView.stopAnimating()
            makeToast(response.message)
        }
    }
    func getUserDetail() {
        let request = RequestUserDetailModel()
        request.id = UserAccountViewModel.standard.account?.uId
        api.jmGetUserDetail(request)
    }
    func jmGetUserDetailDone(request: RequestUserDetailModel, response: ResponseUserDetailModel) {
        self.activityView.stopAnimating()
        if response.status == "ok" {
            UserAccountViewModel.standard.saveAccount(account: response.user)
            if isSelectCategory == true {
                isSelectCategory = false
                return
            }
            //用户信息修改成功！
            delegate.editSuccessBack()
            self.dismiss(animated: true, completion: {
                
            })
        }
    }
    
}
