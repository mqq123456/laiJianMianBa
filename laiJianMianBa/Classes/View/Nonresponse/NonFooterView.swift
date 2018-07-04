//
//  NonFooterView.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/20.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit

protocol NonFooterViewDelegate {
    func infoBtnDone()
    func redBtnDone()
}

class NonFooterView: UIView {
    public var delegate: NonFooterViewDelegate!
    override init(frame: CGRect) {
        super.init(frame : frame)
        backgroundColor = UIColor.white
        let title: UILabel = UILabel(x: 10, y: 40, w: screenW-20, h: 30)
        title.text = "试试"
        title.textColor = RGBA(r: 51, g: 51, b: 51, a: 1)
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 17)
        addSubview(title)
        
        let label: UILabel = UILabel(x: 10, y: 60, w: screenW-20, h: 50)
        if isBoy {
            label.text = "改个时间、丰富照片、完善资料，\n提升见面几率，红包已全额退回！"
        } else {
            label.text = "改个时间、丰富照片、完善资料，\n提升见面几率，真诚的人才想直接见面！"
        }
        label.textColor = RGBA(r: 102, g: 102, b: 102, a: 1)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        addSubview(label)
        
        let infoBtn = UIButton(x: 50, y: label.frame.origin.y+75, w: 240, h: 50)
        infoBtn.center.x = center.x
        infoBtn.layer.cornerRadius = 25
        infoBtn.clipsToBounds = true
        infoBtn.setTitleColor(UIColor.white, for: .normal)
        infoBtn.setBackgroundColor(color: globalColor(), forState: .normal)
        infoBtn.addTarget(self, action: #selector(infoBtnDone), for: .touchUpInside)
        addSubview(infoBtn)
        
        if isBoy {
            
            infoBtn.setTitle("完善资料", for: .normal)
            let redBtn = UIButton(x: 50, y: infoBtn.frame.origin.y+65, w: 240, h: 50)
            redBtn.center.x = center.x
            redBtn.layer.cornerRadius = 25
            redBtn.clipsToBounds = true
            redBtn.setTitle("再次发起邀请", for: .normal)
            redBtn.setTitleColor(UIColor.white, for: .normal)
            redBtn.setBackgroundColor(color: globalColor(), forState: .normal)
            redBtn.addTarget(self, action: #selector(redBtnDone), for: .touchUpInside)
            addSubview(redBtn)

        } else {
            infoBtn.setTitle("更新头像", for: .normal)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func infoBtnDone() {
        delegate.infoBtnDone()
    }
    @objc private func redBtnDone() {
        delegate.redBtnDone()
    }

}
