//
//  UserWaitingBtnView.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/8.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit

protocol UserWaitingBtnViewDelegate {
    
    /// 输入见面暗号
    func secretBtnDone()
    
    /// 见
    func seeBtnDone()
    
    /// 不见
    func notSeeBtnDone()
}

class UserWaitingBtnView: UIView {
    private var meetBtn:UIButton!
    public var delegate: UserWaitingBtnViewDelegate!
    public convenience init(_ btnText:String) {
        self.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
        meetBtn = UIButton(x: 50, y: 30, w: screenW-100, h: 50)
        meetBtn.setTitle(btnText, for: .normal)
        meetBtn.setTitleColor(UIColor.white, for: .normal)
        meetBtn.setBackgroundColor(color: RGBA(r: 0, g: 198, b: 196, a: 1), forState: .normal)
        meetBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        meetBtn.clipsToBounds = true
        meetBtn.layer.cornerRadius = 25
        meetBtn.addTarget(self, action: #selector(secretBtnDone), for: .touchUpInside)
        addSubview(meetBtn)
        
    }
    public convenience init(_ see:String , notSee: String) {
        self.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
        meetBtn = UIButton(x: screenW/2-120, y: 30, w: 110, h: 50)
        meetBtn.setTitle(see, for: .normal)
        meetBtn.setTitleColor(UIColor.white, for: .normal)
        meetBtn.setBackgroundColor(color: RGBA(r: 0, g: 198, b: 196, a: 1), forState: .normal)
        meetBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        meetBtn.clipsToBounds = true
        meetBtn.layer.cornerRadius = 25
        meetBtn.addTarget(self, action: #selector(seeBtnDone), for: .touchUpInside)
        addSubview(meetBtn)
        
        let notSeeBtn = UIButton(x: screenW/2+10, y: 30, w: 110, h: 50)
        notSeeBtn.setTitle(notSee, for: .normal)
        notSeeBtn.setTitleColor(UIColor.white, for: .normal)
        notSeeBtn.setBackgroundColor(color: RGBA(r: 233, g: 233, b: 233, a: 1), forState: .normal)
        notSeeBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        notSeeBtn.clipsToBounds = true
        notSeeBtn.layer.cornerRadius = 25
        notSeeBtn.addTarget(self, action: #selector(notSeeBtnDone), for: .touchUpInside)
        addSubview(notSeeBtn)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    @objc func secretBtnDone() {
        delegate.secretBtnDone()
    }
    @objc func seeBtnDone() {
        delegate.seeBtnDone()
    }
    @objc func notSeeBtnDone() {
        delegate.notSeeBtnDone()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
