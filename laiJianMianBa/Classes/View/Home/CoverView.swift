//
//  CoverView.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/20.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class CoverView: UIView {
    /** 闭包的尝试 */
    var seeBtnBlock:(()->())?
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var head: UIImageView!
    @IBOutlet weak var redBag: UILabel!
    @IBOutlet weak var people: UILabel!
    
    @IBOutlet weak var seeBtn: UIButton!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
        head.roundView()
        seeBtn.layer.cornerRadius = 25
        seeBtn.clipsToBounds = true
        self.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0.33)
        
    }
    
    /// 设置控件参数
    public var status = GetByToUserIdWithPageOrderModel() {
        didSet {
            head.kf.setImage(with: URL(string: status.heads), placeholder: UIImage(named: "loading"), options: nil, progressBlock: { (_, _) in
                
            }) { (image, error, _, _) in
                
            }
            seeBtn.backgroundColor = globalColor()
            if isBoy {
                redBag.text = ""
                people.font = UIFont.boldSystemFont(ofSize: 18)
                time.font = UIFont.systemFont(ofSize: 16)
            }else{
                redBag.text = "\(status.money!)元红包"
            }
            people.text = "\(status.name!)的见面邀请"
            time.text = "\(status.order_time_string!) \(status.address!)"
            
        }
    }
    @IBAction func seeDone(_ sender: Any) {
        self.seeBtnBlock!()
    }
    @IBAction func cancleDone(_ sender: Any) {
        self.removeFromSuperview()
    }
}
