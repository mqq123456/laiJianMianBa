//
//  PerfectInformationViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/20.
//  Copyright © 2016年 fundot. All rights reserved.
//  完善用户资料

import UIKit
//import JMServicesKit
import AliyunOSSiOS
class PerfectInformationViewController: RootTableViewController {
    /// 默认值
    fileprivate var place: [String] = ["请输入你的昵称", "请输入你的生日", "请输入你的身高", "请输入你的行业", "请输入你的微信号（不公开）", "请输入你的个性签名"]
    public var sex: Int!
    fileprivate var uploadAlertController:UIAlertController!
    fileprivate var imagePickerController:UIImagePickerController!
    public var uId: Int!
    fileprivate var headImg: UIImageView = {
        let headImg = UIImageView(frame: CGRect(x: 0, y: 0, w: 150, h: 150))
        headImg.isUserInteractionEnabled = true
        headImg.backgroundColor = UIColor.red
        headImg.roundView()
        headImg.image = UIImage(named: "zhuce_tianjiatouxiang")
        return headImg
    }()
    fileprivate var name: String = {
       return ""
    }()
    fileprivate var birthday: String = {
        return ""
    }()
    var timeInterval : TimeInterval!
    fileprivate var occupation: String = {
        return ""
    }()
    fileprivate var weChatAccount: String = {
        return ""
    }()
    fileprivate var signature: String = {
        return ""
    }()
    fileprivate var avatar: String = {
        return ""
    }()
    fileprivate var height: Int = {
       return 0
    }()
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
    fileprivate var imgTag: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "完善资料"
        dataArray.addObjects(from:  ["昵称", "生日", "身高", "行业", "微信号", "个性签名"])
        initTableView()
        view.addSubview(tableView)
        initAlertController()
        initImagePickerController()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - UI
extension PerfectInformationViewController {
    func initTableView() {
        tableView.register(UINib(nibName: "PerfectCell", bundle: nil), forCellReuseIdentifier: "PerfectCell")
        let headView = UIView(frame: CGRect(x: 0, y: 0, w: screenW, h: 260))
        headImg.center = headView.center
        headImg.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(actionShow)))
        headView.addSubview(headImg)
        tableView.tableHeaderView = headView
        let footerView = PerfectFooterView(frame: CGRect(x: 0, y: 0, w: screenW, h: 160))
        footerView.meetBtn.addTarget(self, action: #selector(meetBtnClick), for: .touchUpInside)
        tableView.tableFooterView = footerView
    }
}
// MARK: - UITableViewDelegate,UITableViewDataSource
extension PerfectInformationViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PerfectCell", for: indexPath) as! PerfectCell
        cell.selectionStyle = .none
        cell.title.text = self.dataArray[indexPath.row] as? String
        cell.input.delegate = self
        cell.input.tag = indexPath.row + 100
        cell.input.placeholder = place[indexPath.row]
        if indexPath.row == 0  {
            cell.input.isUserInteractionEnabled = true
        }else if indexPath.row == 4 {
            cell.input.isUserInteractionEnabled = true
        }else if indexPath.row == 5 {
            cell.input.isUserInteractionEnabled = true
        }else{
            cell.input.isUserInteractionEnabled = false
        }
        if (self.name != "") && indexPath.row == 0 {
            cell.input.text = self.name
        }
        if (self.birthday != "") && indexPath.row == 1 {
            cell.input.text = self.birthday
        }
        if self.height != 0 && indexPath.row == 2 {
            cell.input.text = "\(self.height)cm"
        }
        if (self.occupation != "") && indexPath.row == 3 {
            cell.input.text = self.occupation
        }
        if (self.weChatAccount != "") && indexPath.row == 4 {
            cell.input.text = self.weChatAccount
        }
        if (self.signature != "") && indexPath.row == 5 {
            cell.input.text = self.signature
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 退下键盘
        self.view.endEditing(true)
        if indexPath.row == 1 {
            let picker = PickerView.initWith(row: 8, arr1: [], arr2: [], arr3: [])
            picker.delegate = self
            picker.show(navigationController!)
        }
        if indexPath.row == 2 {
            ///身高
            // 身高
            let arr = NSMutableArray()
            for i in 140 ..< 201 {
                arr.add("\(i)cm")
            }
            let picker = PickerView.initWith(row: 1, arr1: arr, arr2: [], arr3: [])
            picker.delegate = self
            picker.show(navigationController!)
        }
        if indexPath.row == 3 {
            // 行业
            let category = CategoryViewController("6")
            category.delegate = self
            self.navigationController?.pushViewController(category, animated: true)
        }
    }


}
// MARK: - UITextFieldDelegate
extension PerfectInformationViewController: UITextFieldDelegate ,PickerViewDelegate,CategoryViewControllerDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 100 {
            self.name = textField.text!
        }
        if textField.tag == 104 {
            self.weChatAccount = textField.text!
        }
        if textField.tag == 105 {
            self.signature = textField.text!
        }
    }
    func selectDone(_ model: PickerModel) {
        if (model.time != nil) && (model.time == "date") {
            self.birthday = model.frist!
            self.timeInterval = model.timeInterval
        }else{
            self.height = Int(NSString(string: model.frist!).intValue)
        }
        self.tableView.reloadData()
    }
    func dismiss(_ message: [InterestModel], type: String) {
        let model = message.first
        self.occupation = model!.iclass
        tableView.reloadData()
    }

}
// MARK: - 调用相册
extension PerfectInformationViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
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
            headImg.image = img
            let imgData = UIImageJPEGRepresentation(img!,0.5)
            uploadImage(data: imgData!)
            picker.dismiss(animated:true, completion:nil)
            weak var blockSelf = self
            let alert = UIAlertController(title:"请上传真实照片", message: "使用假头像会被\n系统屏蔽，无法正常使用哦～", preferredStyle:.alert)
            let takePhoto = UIAlertAction(title:"换一张", style:UIAlertActionStyle.default) { (action:UIAlertAction)in
                blockSelf?.actionShow()
            }
            let photoLib = UIAlertAction(title:"继续", style:UIAlertActionStyle.default) { (action:UIAlertAction)in
            }
            alert.addAction(takePhoto)
            alert.addAction(photoLib)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController){
        picker.dismiss(animated:true, completion:nil)
    }
    func actionShow()  {
        present(self.uploadAlertController, animated:true, completion: nil)
    }
    private func uploadImage(data: Data) {

        let put = OSSPutObjectRequest()
        put.bucketName = "lianjianmianba-v2"
        let uid = self.uId
        put.objectKey = "\(uid!)_ios_\(Int(Date().timeIntervalSince1970)).jpeg"
        
        put.uploadingData = data
        let putTask = client.putObject(put)
        putTask.continue({ (task) -> Any? in
            self.activityView.stopAnimating()
            let ttt = self.client.presignPublicURL(withBucketName: "lianjianmianba-v2", withObjectKey: "userid_ios_1")
            if ttt.error == nil {
                //let result = task.result as? OSSPutObjectResult
                ///拼接请求
                self.avatar = "http://\(put.bucketName!).oss-cn-beijing.aliyuncs.com/\(put.objectKey!)"
                FDLog("upload object success")
            } else {
                FDLog("upload object failed, error = \(task.error)")
            }
            return nil
        })
    }
    

}
// MARK: - JMServicesDelegate
extension PerfectInformationViewController {
    @objc func meetBtnClick() {
        if name == "" {
            makeToast("请填写昵称")
            return
        }
        if name.characters.count > 20 {
            makeToast("昵称最多20个字符")
            return
        }
        if birthday == "" {
            makeToast("请填写生日")
            return
        }
        if height == 0 {
            makeToast("请填写身高")
            return
        }
        if occupation == "" {
            makeToast("请填写行业")
            return
        }
        if signature == "" {
            makeToast("请填写个性签名")
            return
        }
        if weChatAccount == "" {
            makeToast("请填写微信号")
            return
        }
        if avatar == "" {
            makeToast("请上传头像")
            return
        }
        /// 修改用户信息
        let request = RequestUserChangeModel()
        request.userid = self.uId
        request.name = self.name
        request.heads = avatar
        request.job = self.occupation
        request.birthday = timeInterval
        request.weixin = self.weChatAccount
        request.signature = self.signature
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
        request.id = self.uId
        api.jmGetUserDetail(request)
    }
    func jmGetUserDetailDone(request: RequestUserDetailModel, response: ResponseUserDetailModel) {
        self.activityView.stopAnimating()
        if response.status == "ok" {
            UserAccountViewModel.standard.saveAccount(account: response.user)
            UIApplication.shared.keyWindow?.rootViewController = RootNavigationController(rootViewController: HomeViewController())
        }else{
            makeToast(response.message)
        }
        
    }
    
    
}

