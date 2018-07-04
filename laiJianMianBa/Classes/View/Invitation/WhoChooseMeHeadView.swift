//
//  WhoChooseMeHeadView.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/22.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit

class WhoChooseMeHeadView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let headView = Bundle.main.loadNibNamed("NotMeetView", owner: nil, options: nil)?.first as? NotMeetView
        headView?.frame = CGRect(x: 0, y: 0, w: screenW, h: 220)
        headView?.title.text = "以下女生接受了你的见面，\n但是由于一个小时内未选择心动女\n®生，该见面已失效，请再次发起见面邀请"
        headView?.centCont.constant = -30
        headView?.title.numberOfLines = 0
        headView?.title.textAlignment = .center
        headView?.title.font = UIFont.systemFont(ofSize: 16)
        headView?.detail.text = ""
        self.addSubview(headView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
