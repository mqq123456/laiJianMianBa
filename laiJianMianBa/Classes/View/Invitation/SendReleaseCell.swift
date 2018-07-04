//
//  BoySendReleaseCell.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/21.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
// MARK: - SendReleaseCell
class SendReleaseCell: UITableViewCell {
    /** 地址 */
    private var address : UILabel!
    private var addressImg : UIImageView!
    /** 时间 */
    private var time : UILabel!
    private var timeImg : UIImageView!
    /** 红包 */
    private var redBag : UILabel!
    private var redBagImg : UIImageView!
    /** 发布中 */
    private var sendBtn : UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupOriginal()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupOriginal() {

        let addressImg = UIImageView ()
        addressImg.image = UIImage(named: "jianmianyaoqing_fachu_didian_nv")
        contentView.addSubview(addressImg)
        self.addressImg = addressImg
        
        let address = UILabel()
        address.textColor = RGBA(r: 51, g: 51, b: 51, a: 1)
        address.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(address)
        self.address = address
        
        let timeImg = UIImageView ()
        timeImg.image = UIImage(named: "jianmianyaoqing_fachu_shijian")
        contentView.addSubview(timeImg)
        self.timeImg = timeImg
        
        let time = UILabel()
        time.textColor = RGBA(r: 102, g: 102, b: 102, a: 1)
        time.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(time)
        self.time = time
        
        let redBagImg = UIImageView ()
        redBagImg.image = UIImage(named: "jianmianyaoqing_fachu_hongbao")
        contentView.addSubview(redBagImg)
        self.redBagImg = redBagImg
        
        let redBag = UILabel()
        redBag.textColor = RGBA(r: 237, g: 119, b: 142, a: 1)
        redBag.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(redBag)
        self.redBag = redBag
        
        let sendBtn = UIButton()
        sendBtn.layer.borderWidth = 0.5
        sendBtn.layer.cornerRadius = 2
        sendBtn.isUserInteractionEnabled = false
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sendBtn.layer.borderColor = globalColor().cgColor
        sendBtn.setTitleColor(globalColor(), for: .normal)
        sendBtn.clipsToBounds = true
        contentView.addSubview(sendBtn)
        self.sendBtn = sendBtn
        
    }
    
    public var statusFrame : SendReleaseFrame = SendReleaseFrame(){
        didSet {
            self.setupFrame()
            let statusM = statusFrame.status
            /// 给控件赋值
            address.text = statusM.address
            time.text = "\(statusM.order_time_string!)"
            sendBtn.setTitle(getOrderStatus(statusM.state), for: .normal)
            redBag.text = "\(statusM.money!)元红包"
            if isBoy {
                redBag.isHidden = false
                redBagImg.isHidden = false
            }else{
                redBag.isHidden = true
                redBagImg.isHidden = true
            }
        }
    }
    
    func setupFrame() {
        self.address.frame = self.statusFrame.addressF;
        self.addressImg.frame = self.statusFrame.addressImgF;
        self.time.frame = self.statusFrame.timeF;
        self.timeImg.frame = self.statusFrame.timeImgF;
        self.redBag.frame = self.statusFrame.redBagF;
        self.redBagImg.frame = self.statusFrame.redBagImgF;
        self.sendBtn.frame = self.statusFrame.sendBtnF;
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

// MARK: - SendReleaseFrame
class SendReleaseFrame: NSObject {
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
    /** cell的高度 */
    var cellHeight : CGFloat!
    
    var status : DateList = DateList() {
        didSet {
            /// 设置frame
            addressImgF = CGRect(x: 10, y: 20, w: 12, h: 14)
            addressF = CGRect(x: addressImgF.maxX + 5, y: 20, w: screenW-140, h: 15)
            timeImgF = CGRect(x: addressImgF.minX, y: addressImgF.maxY+20, w: 12, h: 12)
            let timeRect = getLabelRect(text: "\(status.order_time_string!)" as NSString, fontSize: 14)
            timeF = CGRect(x: timeImgF.maxX + 5, y: timeImgF.minY-1, w: timeRect.size.width, h: 15)
            redBagImgF = CGRect(x: timeF.maxX + 5, y: timeImgF.minY + 2, w: 13, h: 10)
            redBagF = CGRect(x: redBagImgF.maxX+2, y: timeImgF.minY , w: 150, h: 15)
            sendBtnF = CGRect(x: screenW-100, y: 30, w: 80, h: 30)
            cellHeight = timeImgF.maxY + 20
            
        }
    }
   
    
}

