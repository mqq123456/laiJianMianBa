//
//  HomeChooseView.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/22.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit
protocol HomeChooseViewDelegate {
    
    /// 主页时间选择事件
    func timeViewDone()
    /// 主页红包选择事件
    func redViewDone()
    /// 主页见面做什么选择的事件
    func doVIewDone()
    /// 主页地点选择事件
    func addressViewDone()
    /// 主页发起见面邀请事件
    func sendDone()
}

class HomeChooseView: UIView {

    var delegate:HomeChooseViewDelegate?
    
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var redVIew: UIView!
    @IBOutlet weak var doVIew: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var doLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    override func awakeFromNib() {
        timeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(timeViewClick)))
        redVIew.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(redVIewClick)))
        doVIew.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(doVIewClick)))
        addressView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addressViewClick)))
        sendBtn.layer.cornerRadius = sendBtn.frame.size.height/2
        sendBtn.clipsToBounds = true
        sendBtn.backgroundColor = globalColor()
        sendBtn.addTarget(self, action: #selector(sendClick), for: .touchUpInside)
    }
    @objc private func sendClick() {
        delegate?.sendDone()
    }
    @objc private func timeViewClick() {
        delegate?.doVIewDone()
    }
    @objc private func redVIewClick() {
        delegate?.redViewDone()
    }
    @objc private func doVIewClick() {
        delegate?.timeViewDone()
    }
    @objc private func addressViewClick() {
        delegate?.addressViewDone()
    }

}
