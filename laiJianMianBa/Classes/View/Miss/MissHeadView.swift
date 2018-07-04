//
//  MissHeadView.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/26.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit

class MissHeadView: UIView {

    @IBOutlet weak var tips: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    override func awakeFromNib() {
        tips.text = "由于见面邀请函有效期为15\n分钟，以下用户错过了您的 邀请\n并希望与您见面，邀您再发一单！"
        sendBtn.layer.cornerRadius = 25
        sendBtn.clipsToBounds = true
    }

}
