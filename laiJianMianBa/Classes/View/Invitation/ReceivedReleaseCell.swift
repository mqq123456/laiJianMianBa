//
//  ReceivedReleaseCell.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/21.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
extension CAGradientLayer {
    
    func GradientLayer() -> CAGradientLayer {
        
        let topColor = UIColor(red: (91/255.0), green: (91/255.0), blue: (91/255.0), alpha: 0.0)
        let buttomColor = UIColor(red: (24/255.0), green: (24/255.0), blue: (24/255.0), alpha: 0.8)
        
        let gradientColors: [CGColor] = [topColor.cgColor, buttomColor.cgColor]
        let gradientLocations: [CGFloat] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        return gradientLayer
        

    }
}
class ReceivedReleaseCell: UITableViewCell {

    /** 大图 */
    private var bigImg : UIImageView!
    /** 蒙板 */
    private var coverView : UIView!
    private var gradientLayer: CAGradientLayer!
    /** 姓名 */
    private var name : UILabel!
    /** 年龄 */
    private var sex: UILabel!
    /** 职业 */
    private var occupation: UILabel!
    /** 地址 */
    private var address : UILabel!
    private var addressImg : UIImageView!
    /** 时间 */
    private var time : UILabel!
    private var timeImg : UIImageView!
    /** 发布中 */
    private var sendBtn : UIButton!
    /** 红包 */
    private var redBtn : UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupOriginal()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupOriginal() {
        
        let bigImg = UIImageView()
        bigImg.backgroundColor = UIColor("F5F5F5")
        contentView.addSubview(bigImg)
        self.bigImg = bigImg
        
        let coverView = UIView()
        let gradientLayer = CAGradientLayer().GradientLayer()
        coverView.layer.insertSublayer(gradientLayer, at: 0)
        contentView.addSubview(coverView)
        self.coverView = coverView
        self.gradientLayer = gradientLayer
        
        let occupation = UILabel()
        occupation.textColor = UIColor("cdcdcd")
        occupation.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(occupation)
        self.occupation = occupation
       
        let name = UILabel()
        name.textColor = UIColor.white
        name.font = UIFont.boldSystemFont(ofSize: 17)
        contentView.addSubview(name)
        self.name = name
        
        let sex = UILabel()
        sex.textColor = UIColor.white
        sex.font = UIFont.systemFont(ofSize: 18)
        contentView.addSubview(sex)
        self.sex = sex
        
        let address = UILabel()
        address.textColor = UIColor("cdcdcd")
        address.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(address)
        self.address = address
        let addressImg = UIImageView ()
        addressImg.image = UIImage(named: "jianmianyaoqing_fachu_didian_nv")
        contentView.addSubview(addressImg)
        self.addressImg = addressImg
        
        let timeImg = UIImageView ()
        timeImg.image = UIImage(named: "jianmianyaoqing_fachu_shijian")
        contentView.addSubview(timeImg)
        self.timeImg = timeImg
        
        let time = UILabel()
        time.textColor = UIColor("cdcdcd")
        time.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(time)
        self.time = time
        
        let sendBtn = UIButton()
        sendBtn.layer.borderWidth = 0.5
        sendBtn.layer.cornerRadius = 1
        sendBtn.isUserInteractionEnabled = false
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        sendBtn.layer.borderColor = globalColor().cgColor
        sendBtn.setTitleColor(globalColor(), for: .normal)
        sendBtn.clipsToBounds = true
        contentView.addSubview(sendBtn)
        self.sendBtn = sendBtn
        
        let redBtn = UIButton()
        redBtn.isUserInteractionEnabled = false
        redBtn.setBackgroundImage(UIImage(named:"daitiaoxuan_hongbaohengtiao"), for: .normal)
        redBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        redBtn.setTitleColor(UIColor.white, for: .normal)
        contentView.addSubview(redBtn)
        self.redBtn = redBtn
        
    }
    
    var statusFrame : ReceivedReleaseFrame = ReceivedReleaseFrame(){
        didSet {
            self.setupFrame()
            let statusM = statusFrame.status
            /// 给控件赋值
            name.text = statusM.from_name
            occupation.text = statusM.from_job + " | " + "\(statusM.from_age!)岁"
            address.text = statusM.address
            time.text = "\(statusM.order_time_string!)"
            sendBtn.setTitle(getOrderStatus(statusM.state), for: .normal)
            let url = URL(string: statusM.from_avatar)
            if statusM.from_sex == 1 {
                sex.text = "♂"
            }else {
                sex.text = "♀"
            }
            if isBoy == true {
                redBtn.isHidden = true
            }else{
                redBtn.isHidden = false
                redBtn.setTitle("\(statusM.money!)元", for: .normal)
            }
            bigImg.kf.setImage(with: url, placeholder: UIImage(named: "loading"), options: nil, progressBlock: { (_, _) in
                
            }) { (image, error, _, _) in
                
            }
        }
    }
    
    func setupFrame() {
        self.bigImg.frame = self.statusFrame.bigImgF;
        self.coverView.frame = self.statusFrame.coverViewF;
        self.name.frame = self.statusFrame.nameF;
        self.occupation.frame = self.statusFrame.occupationF;
        self.sex.frame = self.statusFrame.sexF;
        self.address.frame = self.statusFrame.addressF;
        self.addressImg.frame = self.statusFrame.addressImgF;
        self.time.frame = self.statusFrame.timeF;
        self.timeImg.frame = self.statusFrame.timeImgF;
        self.sendBtn.frame = self.statusFrame.sendBtnF;
        self.gradientLayer.frame = self.statusFrame.gradientLayerF
        self.redBtn.frame = self.statusFrame.redBtnF
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

// MARK: - ReceivedReleaseFrame
class ReceivedReleaseFrame: NSObject {
    /** 地址 */
    var bigImgF : CGRect!
    var coverViewF : CGRect!
    var gradientLayerF: CGRect!
    /** 时间 */
    var nameF : CGRect!
    var sexF : CGRect!
    /** 职业 */
    var occupationF : CGRect!
    /** 地址 */
    var addressF : CGRect!
    var addressImgF : CGRect!
    /** 时间 */
    var timeF : CGRect!
    var timeImgF : CGRect!
    /** 红包 */
    var redBagF : CGRect!
    var redBagImgF : CGRect!
    /** 发布中 */
    var sendBtnF : CGRect!
    /** 线 */
    var lineF : CGRect!
    /** 线 */
    var redBtnF : CGRect!
    /** cell的高度 */
    var cellHeight : CGFloat!
    
    var status : ReceivedUserModel = ReceivedUserModel() {
        didSet {
            /// 设置frame
            bigImgF = CGRect(x: 18, y: 5, w: screenW-36, h: screenW-36)
            redBtnF = CGRect(x: bigImgF.minX, y: bigImgF.minY, w: 81, h: 20)
            coverViewF = bigImgF
            gradientLayerF = CGRect(x: 0, y: coverViewF.height/2, w: coverViewF.width, h: coverViewF.height/2)
            timeImgF = CGRect(x: 26, y: bigImgF.maxY-20, w: 12, h: 12)
            timeF = CGRect(x: timeImgF.maxX+5, y: timeImgF.minY-1, w: screenW-100, h: 15)
            addressImgF = CGRect(x: timeImgF.minX, y: timeImgF.minY-20, w: 12, h: 14)
            addressF = CGRect(x: addressImgF.maxX+5, y: addressImgF.minY, w: screenW-140, h: 15)
            occupationF = CGRect(x: timeImgF.minX, y: addressImgF.minY-24, w: screenW-150, h: 20)
            let nameRect = getLabelRect(text: status.from_name as NSString, fontSize: 17)
            nameF = CGRect(x: timeImgF.minX, y: occupationF.minY - nameRect.size.height-5, w: nameRect.size.width, h: nameRect.size.height)
            sexF = CGRect(x: nameF.maxX, y: nameF.minY-8, w: 24, h: 24)
            sendBtnF = CGRect(x: screenW-97, y: bigImgF.maxY-40, w: 70, h: 30)
            cellHeight = bigImgF.maxY
        }
    }
    
    
}
