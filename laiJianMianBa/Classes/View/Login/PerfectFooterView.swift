//
//  PerfectFooterView.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/20.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit

class PerfectFooterView: UIView {
    
    var meetBtn: UIButton!
    override init(frame: CGRect) {
        super.init(frame : frame)
        let label: UILabel = UILabel(x: 10, y: 0, w: screenW-20, h: 30)
        label.text = "＊以上为必填项，详细资料让对方更了解你～"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 12)
        addSubview(label)
        meetBtn = UIButton(x: 80, y: 60, w: screenW-160, h: 44)
        meetBtn.setTitle("下一步", for: .normal)
        meetBtn.setTitleColor(UIColor.white, for: .normal)
        meetBtn.setBackgroundColor(color: globalColor(), forState: .normal)
        meetBtn.clipsToBounds = true
        meetBtn.layer.cornerRadius = 22
        addSubview(meetBtn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
