//
//  WaitingHeadView.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/22.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit

class WaitingHeadView: UIView {
    public var tips: UILabel!
    override init(frame: CGRect) {
        super.init(frame : frame)
        backgroundColor = UIColor.white
        let imageView = UIImageView(frame: CGRect(x: 10, y: 22.5, w: 18, h: 17))
        if isBoy {
            imageView.image = UIImage(named: "daitiaoxuan_nan")
        }else{
            imageView.image = UIImage(named: "daitiaoxuan_nv")
        }
        self.addSubview(imageView)
        tips = UILabel(x: imageView.frame.maxX + 5, y: 0, w: screenW-40, h: 60)
        tips.textColor = globalColor()
        tips.numberOfLines = 0
        tips.font = UIFont.systemFont(ofSize: 14)
        addSubview(tips)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
