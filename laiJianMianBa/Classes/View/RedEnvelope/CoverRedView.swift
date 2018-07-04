//
//  CoverRedView.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/29.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit

class CoverRedView: UIView {
    public var isRedBag: Bool = Bool() {
        didSet {
            tipBtn.setImage(UIImage(named: "tanchuang_weixuanze"), for: .normal)
            tipBtn.setImage(UIImage(named: "tanchuang_hongbao_yixuanze"), for: .selected)
            if isRedBag {
//                tipBtn.setImage(UIImage(named: "tanchuang_weixuanze"), for: .normal)
//                tipBtn.setImage(UIImage(named: "tanchuang_hongbao_yixuanze"), for: .selected)
                self.backImg.image = UIImage(named: "hongbao_fadan")
            }else{
//                self.tipBtn.setImage(UIImage(named: "jianmianhongbao_tanchuang_wei"), for: .normal)
//                self.tipBtn.setImage(UIImage(named: "jianmianhongbao_tanchuang_yi"), for: .selected)
                self.backImg.image = UIImage(named: "tanchuang")
                //self.tipBtn.setTitleColor(UIColor("ff6e8d"), for: .normal)
            }
            
        }
    }
    public var isTip: Bool = Bool() {
        didSet {
            self.backImg.image = UIImage(named: "tanchuang_1")
            self.tipBtn.isHidden = true
        }
    }
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var tipBtn: UIButton!
    override func awakeFromNib() {
        self.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0.33)
        tipBtn.imageView?.contentMode = .scaleAspectFit
        tipBtn.contentMode = .center
        backImg.contentMode = .scaleAspectFit
    }
    @IBAction func cancleDone(_ sender: Any) {
        if self.tipBtn.isSelected == true && isRedBag == false {
            UserDefaults.standard.set("2", forKey: "CoverRedView")
            UserDefaults.standard.synchronize()
        }
        if self.tipBtn.isSelected == true && isRedBag == true {
            UserDefaults.standard.set("3", forKey: "CoverRedView")
            UserDefaults.standard.synchronize()
        }
        removeFromSuperview()
    }
    @IBAction func tipBtnDone(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        }else {
            sender.isSelected = true
        }
    }
}
