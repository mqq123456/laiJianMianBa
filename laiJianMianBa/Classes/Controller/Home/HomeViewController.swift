//
//  HomeViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/19.
//  Copyright © 2016年 fundot. All rights reserved.
//  主页，包含地图

import UIKit
import MapKit
import CoreLocation
import Kingfisher
//import JMServicesKit
/// 主页按钮跳转回调协议
protocol HomeControllerBackDelegate {
    /// 红包选择跳转回调
    ///
    /// - Parameter money: 红包金额
    func redEnvelopeBack(_ money: String)
    
    /// 地点选择跳转回调
    ///
    /// - Parameter address: 地点名称
    func addressBack(_ address: String, location: AMapGeoPoint)
}
class HomeViewController: RootViewController {
    
    /// 定位管理器
    fileprivate lazy var locationManager: CLLocationManager = {
        let tempLocationManager = CLLocationManager()
        tempLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            tempLocationManager.requestAlwaysAuthorization()
            tempLocationManager.requestWhenInUseAuthorization()
        }
        tempLocationManager.delegate = self
        return tempLocationManager
    }()
    /// mapView
    fileprivate lazy var mapView: MKMapView! = {
        let tempMapView = MKMapView(frame: self.view.bounds)
        tempMapView.mapType = MKMapType.standard
        tempMapView.delegate = self
        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
        // 默认显示经纬度 116.478513,39.998629
        let center:CLLocation = CLLocation(latitude: 39.998629, longitude: 116.478513)
        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
        //设置显示区域
        tempMapView.setRegion(currentRegion, animated: false)
        return tempMapView
        }()
    fileprivate lazy var marqueeString: NSMutableString = {
        let marString = NSMutableString()
        return marString
    }()
    /// 跑马灯
    fileprivate lazy var marquee: CHWMarqueeView = {
        let string = self.marqueeString
        let marquee = CHWMarqueeView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: 34), title: string as String)
        return marquee
    }()
    /// chooseView
    fileprivate lazy var homeChooseView: HomeChooseView = {
        let boyView = Bundle.main.loadNibNamed("HomeChooseView", owner: self, options: nil)?.last as! HomeChooseView
        boyView.frame = CGRect(x: 0, y: screenH - 180, w: screenW, h: 180)
        boyView.delegate = self
        return boyView
    }()
    lazy var geoCoder: CLGeocoder = {
        return CLGeocoder()
    }()
    
    /// 定位点的animation
    fileprivate var locationAnimation: FDAnnotation!
    /// 时间
    fileprivate var timeString: String!
    /// 见面做什么
    fileprivate var doString: String!
    /// 见面红包
    fileprivate var redBagString: String!
    /// 见面地点
    fileprivate var addressString: String!
    fileprivate var location: AMapGeoPoint!
    /// 下单成功后的接单码
    fileprivate var serialno: String!
    /// 个人中心按钮
    fileprivate lazy var rightNavBtn: UIButton = {
        let rightBtn = UIButton(x: 0, y: 0, w: 40, h: 40, target: self, action: #selector(rightBtnClick))
        rightBtn.roundView()
        rightBtn.setImage(UIImage(named: "shouye_gerenzhongxin"), for: .normal)
        return rightBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", style: .done, target: self, action: #selector(myexit))
        
        setUpUI()
        getReceivedForCoverView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(payNotification(no:)), name: WXPayNotification, object: nil)
        /// 新的一天有弹窗
        showCoverByNewDay()
        
    }
    private func showCoverByNewDay() {
        let newDate = Date()
        // 出生日期转换 年月日
        let unitFlags = Set<Calendar.Component>([.day, .month, .year])
        let calendar = Calendar.current
        let components1 = calendar.dateComponents(unitFlags, from: newDate as Date)
        let brithDateDay   = components1.day
        let time = UserDefaults.standard.object(forKey: "nowDate") as? Int ?? 0
        if time != brithDateDay {
            // 弹出提醒
            let coverView = Bundle.main.loadNibNamed("CoverRedView", owner: self, options: nil)?.last as! CoverRedView
            coverView.frame = CGRect(x: 0, y: 0, w: screenW, h: screenH)
            coverView.isTip = true
            self.navigationController?.view.addSubview(coverView)
        }
        UserDefaults.standard.set(brithDateDay, forKey: "nowDate")
        UserDefaults.standard.synchronize()
    }
    @objc func myexit() {
        //
        removeUserDefautKeys()
        UserAccountViewModel.standard.deleteAccount()
         exit(0)
    }
    /// 支付完成的通知
    ///
    /// - Parameter no: 通知传递参数
    @objc func payNotification(no:Notification) {
        if self.navigationController?.topViewController == self {
            if let errorCode = no.userInfo?[AnyHashable("errCode")] as? Int32 {
                if errorCode == 0 {
                    //说明支付成功了
                    navigationController?.pushViewController(SendingViewController(serialno!), animated: false)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /// 防止更新头像时候，这里头像不更新的问题
        rightNavBtn.kf.setBackgroundImage(with: URL(string: UserAccountViewModel.standard.account!.avatar), for: .normal, placeholder: UIImage(), options: nil, progressBlock: { (_, _) in
            
        }) { (image, error, _, _) in
            self.rightNavBtn.setImage(UIImage(), for: .normal)
        }
    }
    /// 解决跑马灯停住的问题
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if marqueeString.length>0 {
            self.marquee.runing(title: self.marqueeString as String)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
// MARK: - UI
extension HomeViewController {
    fileprivate func setUpUI() {
        /// 导航
        self.title = "见面广场"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightNavBtn)
        /// 地图
        self.view.addSubview(mapView)
        /// 定位
        locationManager.startUpdatingLocation()
        /// 添加底部选择view
        view.addSubview(homeChooseView)
       
        //按钮添加阴影
        let shadView = UIView(x: screenW-80, y: screenH-280, w: 60, h: 60)
        shadView.layer.shadowOpacity = 0.5
        shadView.layer.shadowColor = UIColor.black.cgColor
        shadView.layer.shadowRadius = 3
        shadView.layer.shadowOffset = CGSize(width: 1, height: 3)
        shadView.clipsToBounds = false
        self.view.addSubview(shadView)
        let myInvitation = UIButton(x: -2, y: -2, w: 60, h: 60, target: self, action: #selector(myInvitationDone))
        myInvitation.roundView()
        myInvitation.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        myInvitation.titleLabel?.numberOfLines = 2
        myInvitation.setTitle("我的\n邀请", for: .normal)
        myInvitation.backgroundColor = globalColor()
        shadView.addSubview(myInvitation)
    }
    @objc private func myInvitationDone() {
        navigationController?.pushViewController(InvitationViewController(), animated: true)
    }
    @objc fileprivate func rightBtnClick() {
        navigationController?.pushViewController(InformationViewController(), animated: true)
    }
}

// MARK: - MKMapViewDelegate
extension HomeViewController: MKMapViewDelegate {
    //自定义大头针样式
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuserId = "location_animation"
        if annotation.title! == "我的位置" { // 定位点的animation
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuserId) as! MKPinAnnotationView!
            if pinView == nil {
                //创建一个大头针视图
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuserId)
            }else{
                pinView?.annotation = annotation
            }
            pinView?.pinColor = .green
            return pinView
        }else{ /// 用户头像的animation
            let identifier = "head_animation"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuserId) as MKAnnotationView!
            if pinView == nil {
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            pinView?.annotation = annotation
            pinView?.frame = CGRect(x: 0, y: 0, w: 50, h: 50)
            let imageView = UIImageView()
            imageView.kf.setImage(with: URL(string: annotation.title!!), placeholder: UIImage(named: "loading"), options: nil, progressBlock: { (_, _) in
                
            }) { (image, error, _, _) in
                pinView?.image = image
                pinView?.contentMode = .scaleToFill
                pinView?.frame = CGRect(x: 0, y: 0, w: 50, h: 50)
            }
            pinView?.roundView()
            pinView?.isUserInteractionEnabled = true
            pinView?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(animationViewDone(_:))))
            return pinView
        }
        
    }
    @objc func animationViewDone(_ tap:UITapGestureRecognizer) {
        /// 弹出浮层
        let animation = (tap.view as? MKAnnotationView)?.annotation as? FDAnnotation
        if animation != nil {
            // 弹出浮层
            let coverView = Bundle.main.loadNibNamed("MapHeadCoverView", owner: self, options: nil)?.last as! MapHeadCoverView
            coverView.frame = CGRect(x: 0, y: 0, w: screenW, h: screenH)
            coverView.head.kf.setImage(with: URL(string: (animation?.title)!), placeholder: UIImage(named: "loading"), options: nil, progressBlock: { (_, _) in
                
            }, completionHandler: { (image, error, _, _) in
                
            })
            self.navigationController?.view.addSubview(coverView)
        }
        
    }
    
}

// MARK: - CLLocationManagerDelegate
extension HomeViewController: CLLocationManagerDelegate {
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //let newLocation = locations.last
        //取得locations数组的最后一个
        let location:CLLocation = locations[locations.count-1]
        //判断是否为空
        if(location.horizontalAccuracy > 0){
            let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
            let center:CLLocation = location
            let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
            //停止定位
            locationManager.stopUpdatingLocation()
            //设置显示区域
            mapView.setRegion(currentRegion, animated: false)
            /// 添加我的位置点
            addAnnotation(center.coordinate, title: "我的位置")
           
            /// 只执行一次
            DispatchQueue.once(token: "com.fundot.jaiJianMianBa") {
                getFinishDate(coordinate: location.coordinate)
            }
            
            
            /// 位置变化
            let lat = UserDefaults.standard.object(forKey: "latitude") as? Double ?? 0
            let lon = UserDefaults.standard.object(forKey: "longitude") as? Double ?? 0
            let latSum = fabs(lat - location.coordinate.latitude) / 0.000001
            let lonSum = fabs(lon - location.coordinate.longitude) / 0.000001
            if latSum > 5000 || lonSum > 5000 {
                /// 上传位置信息
                let request = RequestUserChangeModel()
                request.userid = UserAccountViewModel.standard.account?.uId
                request.lat = Int(location.coordinate.latitude * 1e6)
                request.lon = Int(location.coordinate.longitude * 1e6)
                api.jmUserChange(request)
            }
            /// 保存经纬度
            UserDefaults.standard.set(location.coordinate.latitude, forKey: "latitude")
            UserDefaults.standard.set(location.coordinate.longitude, forKey: "longitude")
            
        }
    }
    
    /// 添加animation
    ///
    /// - Parameters:
    ///   - coordinate: 经纬度
    ///   - title: 标题
    private func addAnnotation(_ coordinate: CLLocationCoordinate2D, title: String) {
        if (locationAnimation != nil) {
            mapView.removeAnnotation(locationAnimation)
        }
        let annotation: FDAnnotation = FDAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
        self.locationAnimation = annotation
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        FDLog("定位失败")
    }
}

// MARK: - HomeChooseViewDelegate , PickerViewDelegate , RedEnvelopeViewControllerDelegate
extension HomeViewController: HomeChooseViewDelegate,PickerViewDelegate ,HomeControllerBackDelegate{
    func timeViewDone() {
        let picker = PickerView.initWith(row: 3, arr1: ["今天","明天"], arr2: ["10","11","12","13","14","15","16","17","18"], arr3: ["00","01","02"])
        picker.delegate = self
        picker.show(navigationController!)
    }
    func redViewDone() {
        if isBoy {
            let red = RedEnvelopeViewController()
            red.delegate = self
            navigationController?.pushViewController(red, animated: true)
        }else{
            // 弹出浮层
            let coverView = Bundle.main.loadNibNamed("GrilCoverView", owner: self, options: nil)?.last as! GrilCoverView
            coverView.frame = CGRect(x: 0, y: 0, w: screenW, h: screenH)
            self.navigationController?.view.addSubview(coverView)
        }
        
    }
    func redEnvelopeBack(_ money: String) {
        self.redBagString = money
        homeChooseView.redLabel.text = "\(Int(Int(money)!/100))元"
    }
    func doVIewDone() {
        let picker = PickerView.initWith(row: 1, arr1: ["吃个饭","喝咖啡","台球","电影院"], arr2: [], arr3: [])
        picker.delegate = self
        picker.show(navigationController!)
    }
    func addressViewDone() {
        let address = AddressViewController()
        address.delegate = self
        navigationController?.pushViewController(address, animated: true)
    }
    internal func addressBack(_ address: String,location: AMapGeoPoint) {
        self.addressString = address
        self.location = location
        homeChooseView.addressLabel.text = address
       
    }
    func selectDone(_ model: PickerModel) {
        if (model.time != nil) && (model.second != nil) && (model.third != nil){
            timeString = "\(model.time!) \(model.second!):\(model.third!):00"
            homeChooseView.doLabel.text = "\(model.frist!)\(model.second!):\(model.third!)"
        } else {
            doString = model.frist!
            homeChooseView.timeLabel.text = model.frist!
        }
    }
}


// MARK: - JMAPIDelegate
extension HomeViewController {
    /// 定位成功，获取地图数据，和跑马灯数据
    ///
    /// - Parameter coordinate: 定位成功的经纬度
    func getFinishDate(coordinate: CLLocationCoordinate2D) {
        let request =  RequestGetBoardDataModel()
        request.lat = Int(coordinate.latitude * 1e6)
        request.lon = Int(coordinate.longitude * 1e6)
        request.sex = UserAccountViewModel.standard.account?.sex
        api.jmGetBoardData(request)
    }
    /// 发起见面邀请
    func sendDone() {
        if timeString == nil {
            makeToast("请选择见面时间")
            return
        }
        if addressString == nil {
            makeToast("请选择见面地点")
            return
        }
        if location == nil {
            makeToast("没有定位到你的位置，请打开定位后重试")
            return
        }
        if doString == nil {
            makeToast("请选择见面做什么")
            return
        }
        if isBoy {
            if redBagString == nil {
                makeToast("请选择红包金额")
                return
            }
        }else{
            redBagString = "0"
        }
        /// 发起见面邀请
        let request = RequestSendDateModel()
        request.user_id = UserAccountViewModel.standard.account?.uId
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = timeformatter.date(from: timeString)
        request.time = date?.timeIntervalSince1970
        request.addr = addressString
        request.lon = Int(location.longitude * 1e6)
        request.lat = Int(location.latitude * 1e6)
        request.money = 1
        request.desc = doString!
        request.from_phone = UserAccountViewModel.standard.account?.phone
        request.from_weixin = UserAccountViewModel.standard.account?.weChatAccount
        request.from_sex = UserAccountViewModel.standard.account?.sex
        api.jmbSendDate(request)
        self.activityView.startAnimating()
        
    }
    func getReceivedForCoverView() {
        let request = RequestGetByToUserIdWithPageModel()
        request.to_user_id = UserAccountViewModel.standard.account?.uId
        api.jmGetByToUserIdWithPage(request)
    }
    func jmGetByToUserIdWithPageDone(request: RequestGetByToUserIdWithPageModel, response: ResponseGetByToUserIdWithPageModel) {
        if response.status == "ok" && response.order != nil {
            // 弹出浮层
            let coverView = Bundle.main.loadNibNamed("CoverView", owner: self, options: nil)?.last as! CoverView
            coverView.frame = CGRect(x: 0, y: 0, w: screenW, h: screenH)
            coverView.status = response.order
            coverView.seeBtnBlock = {
                [weak self] _ in
                coverView.removeFromSuperview()
                let user = UserViewController(response.order)
                self?.navigationController?.pushViewController(user, animated: true)
            }
            self.navigationController?.view.addSubview(coverView)
        }
    }
    func jmSendDateDone(request: RequestSendDateModel, response: ResponseSendDateModel) {
        if response.status == "ok" {
            /// 用于后面的展示
            serialno = response.serialno
            if isBoy {
                let req = RequestReadyPayModel()
                req.id = response.orderid
                api.jmReadyPay(req)
            }else{
                self.activityView.stopAnimating()
                navigationController?.pushViewController(SendingViewController(serialno!), animated: false)
            }
        }else{
            makeToast(response.message!)
        }
    }
    func jmReadyPayDone(request: RequestReadyPayModel, response: ResponseReadyPayModel) {
        self.activityView.stopAnimating()
        if response.status == "ok" {
            if isBoy {
                wechatPay(response)
            }
        }
    }
    // MARK: - 微信支付
    private func wechatPay(_ request: ResponseReadyPayModel)
    {
        if !WXApi.isWXAppInstalled()  {//检查一下是否可以使用微信
            // 未安装微信
            makeToast("未安装微信")
            return
        } else if !WXApi.isWXAppSupport() {
            // 当前版本微信不支持微信支付
            makeToast("未安装微信")
            return
        }
        let req = PayReq()
        req.partnerId = request.partnerid
        req.prepayId = request.prepayid
        req.nonceStr = request.noncestr
        req.timeStamp = request.timestamp
        req.package = request.package
        req.sign = request.sign
        WXApi.send(req)
    }

    func jmUserChangeDone(request: RequestUserChangeModel, response: ResponseUserChangeModel) {
        
    }
    func jmGetBoardDataDone(request: RequestGetBoardDataModel, response: ResponseGetBoardDataModel) {
        if response.status == "ok" {
            for model in response.users{
                marqueeString.append("\(model.male_name!)和\(model.female_name!)见面成功啦，红包\(model.money!)元   ")
            }
            self.marquee.removeFromSuperview()
            self.view.addSubview(self.marquee)
            for model in response.heads{
                let annotation: FDAnnotation = FDAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(model.lat, model.lon)
                annotation.title = model.head
                mapView.addAnnotation(annotation)
            }
        }else{
            makeToast(response.message!)
        }

    }
}
// MARK: - FDAnnotation
class FDAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var title: String?
    var subtitle: String?
    var name: String?
    var age: String?
}
