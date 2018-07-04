//
//  NotMeetView.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/8.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit

class NotMeetView: UIView {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var detail: UILabel!
    
    @IBOutlet weak var seeBtn: UIButton!
    
    @IBOutlet weak var centCont: NSLayoutConstraint!
    override func awakeFromNib() {
        seeBtn.layer.cornerRadius = 20
        seeBtn.clipsToBounds = true
        seeBtn.backgroundColor = globalColor()
    }

}
