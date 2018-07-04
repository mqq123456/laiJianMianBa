//
//  WaitingListCell.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/21.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class WaitingListCell: UICollectionViewCell {
    
    /** 姓名 */
    private var name : UILabel!
    private var sex : UILabel!
    private var detail : UILabel!
    private var head : UIImageView!
    /** 线 */
    private var line : UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.borderColor = RGBA(r: 236, g: 236, b: 236, a: 1).cgColor
        self.layer.borderWidth = 0.5
        setupOriginal()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Cell 初始化失败");
    }
    func setupOriginal() {
        
        let line = UIView()
        line.backgroundColor = UIColor.white
        line.clipsToBounds = true
        line.layer.cornerRadius = 1
        line.layer.borderWidth = 0.5
        line.layer.borderColor = UIColor.gray.cgColor
        contentView.addSubview(line)
        self.line = line
        
        let head = UIImageView ()
        head.backgroundColor = UIColor("F5F5F5")
        contentView.addSubview(head)
        self.head = head
        
        let name = UILabel()
        name.textColor = RGBA(r: 51, g: 51, b: 51, a: 1)
        name.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(name)
        self.name = name
        
        let sex = UILabel ()
        sex.font = UIFont.systemFont(ofSize: 17)
        contentView.addSubview(sex)
        self.sex = sex
        
        let detail = UILabel()
        detail.textColor = RGBA(r: 102, g: 102, b: 102, a: 1)
        detail.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(detail)
        self.detail = detail
        
    }
    
    var statusFrame : WaitingListFrame = WaitingListFrame(){
        didSet {
            self.setupFrame()
            let statusM = statusFrame.status
            /// 给控件赋值
            head.kf.setImage(with: URL(string: statusM.to_heads), placeholder: UIImage(named: "loading"), options: nil, progressBlock: { (_, _) in
                
            }) { (image, error, _, _) in
                
            }
            detail.text = statusM.to_job + " | " + "\(statusM.to_age!)岁"
            if statusM.to_sex == 1 {
                sex.text = "♂"
                sex.textColor = RGBA(r: 4, g: 190, b: 194, a: 1)
            }else {
                sex.text = "♀"
                sex.textColor = RGBA(r: 255, g: 110, b: 141, a: 1)
            }
            name.text = statusM.to_name
        }
    }
    
    func setupFrame() {
      //  self.line.frame = self.statusFrame.lineF;
        self.head.frame = self.statusFrame.headF;
        self.name.frame = self.statusFrame.nameF;
        self.sex.frame = self.statusFrame.sexF;
        self.detail.frame = self.statusFrame.detailF;
    }
}

// MARK: - SendReleaseFrame
class WaitingListFrame: NSObject {
    /** 姓名 */
    var nameF : CGRect!
    var sexF : CGRect!
    var detailF : CGRect!
    var headF : CGRect!
    /** 线 */
    var lineF : CGRect!
    /** cell的高度 */
    var cellHeight : CGFloat!
    
    var status : AcceptOrderUsersModel = AcceptOrderUsersModel() {
        didSet {
            /// 设置frame
            let cellW: CGFloat = (screenW-30)/2
            headF = CGRect(x: 0, y: 0, w: cellW, h: cellW)
            let nameRect = getLabelRect(text: status.to_name as NSString, fontSize: 16)
            nameF = CGRect(x: 10, y: headF.maxY, w: nameRect.size.width, h: 34)
            sexF = CGRect(x: nameF.maxX, y: headF.maxY, w: 26, h: 26)
            detailF = CGRect(x: 10, y: nameF.maxY, w: cellW, h: 20)
            cellHeight = detailF.maxY + 10
        }
    }
    
    
}

