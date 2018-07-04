//
//  MissCell.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/26.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class MissCell: UITableViewCell {

    fileprivate var backView: UIView!
    fileprivate var head: UIImageView!
    fileprivate var name: UILabel!
    fileprivate var ageBtn: UIButton!
    fileprivate var timeImg: UIImageView!
    fileprivate var time: UILabel!
    fileprivate var desc: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupOriginal()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupOriginal() {
        
        let backView = UIView()
        backView.backgroundColor = UIColor("ececec")
        contentView.addSubview(backView)
        self.backView = backView
        
        let head = UIImageView()
        head.contentMode = .scaleAspectFit
        head.backgroundColor = UIColor("F5F5F5")
        head.clipsToBounds = true
        contentView.addSubview(head)
        self.head = head
        
        let name = UILabel()
        name.textColor = RGBA(r: 51, g: 51, b: 51, a: 1)
        name.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(name)
        self.name = name
        
        
        let ageBtn = UIButton()
        ageBtn.backgroundColor = RGBA(r: 0, g: 184, b: 250, a: 1)
        ageBtn.setTitleColor(UIColor.white, for: .normal)
        ageBtn.layer.cornerRadius = 3
        ageBtn.clipsToBounds = true
        ageBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        ageBtn.contentMode = .center
        contentView.addSubview(ageBtn)
        ageBtn.isUserInteractionEnabled = false
        self.ageBtn = ageBtn
        
        let timeImg = UIImageView()
        contentView.addSubview(timeImg)
        self.timeImg = timeImg
        
        let time = UILabel()
        time.font = UIFont.systemFont(ofSize: 14)
        time.textColor = RGBA(r: 102, g: 102, b: 102, a: 1)
        contentView.addSubview(time)
        self.time = time
        
        let desc = UILabel()
        desc.font = UIFont.systemFont(ofSize: 14)
        desc.textColor = RGBA(r: 102, g: 102, b: 102, a: 1)
        contentView.addSubview(desc)
        self.desc = desc
        
    }
    
    var statusFrame : MissFrame = MissFrame(){
        didSet {
            self.setupFrame()
            let statusM = statusFrame.status
            /// 给控件赋值
            name.text = statusM.name
            let url = URL(string: statusM.head)
            head.kf.setImage(with: url, placeholder: UIImage(named: "loading"), options: nil, progressBlock: { (_, _) in
                
            }) { (image, error, _, _) in
                
            }
             ageBtn.setTitle(statusM.age, for: .normal)
            if statusM.sex == "1" {
                ageBtn.setTitle( "♂" + statusM.age, for: .normal)
            }else {
                ageBtn.setTitle( "♀" + statusM.age, for: .normal)
            }
            time.text = statusM.order_time
            timeImg.image = UIImage(named: "jianmianyaoqing_fachu_shijian")
            desc.text = statusM.desc
        }
    }
    
    func setupFrame() {
        self.backView.frame = self.statusFrame.backViewF;
        self.head.frame = self.statusFrame.headF;
        self.name.frame = self.statusFrame.nameF;
        self.ageBtn.frame = self.statusFrame.ageBtnF;
        self.timeImg.frame = self.statusFrame.timeImgF;
        self.time.frame = self.statusFrame.timeF;
        self.desc.frame = self.statusFrame.descF;
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
// MARK: - SendReleaseFrame
class MissFrame: NSObject {
    
    var backViewF: CGRect!
    var headF: CGRect!
    var nameF: CGRect!
    var ageBtnF: CGRect!
    var timeImgF: CGRect!
    var timeF: CGRect!
    var descF: CGRect!
    
    /** cell的高度 */
    var cellHeight : CGFloat!
    
    var status : MissModel = MissModel() {
        didSet {
            /// 设置frame
            backViewF = CGRect(x: 0, y: 0, w: screenW, h: 100)
            headF = CGRect(x: 13, y: 13, w: 74, h: 74)
            let nameRect = getLabelRect(text: NSString(string:status.name), fontSize: 16)
            nameF = CGRect(x: headF.maxX+13, y: 20, w: nameRect.size.width, h: 20)
            ageBtnF = CGRect(x: nameF.maxX+10, y: 20, w: 40, h: 20)
            timeImgF = CGRect(x: headF.maxX+13, y: nameF.maxY+10, w: 15, h: 15)
            timeF = CGRect(x: timeImgF.maxX+5, y: nameF.maxY+10, w: screenW-120, h: 18)
            descF = CGRect(x: headF.maxX+13, y: headF.maxY - 20, w: screenW-120, h: 20)
            cellHeight = backViewF.maxY+10
        }
    }
}

