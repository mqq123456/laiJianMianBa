//
//  MapHeadCoverView.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/22.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit

class MapHeadCoverView: UIView {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var head: UIImageView!
    @IBAction func btnDone(_ sender: Any) {
        self.removeFromSuperview()
    }
    override func awakeFromNib() {
        self.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0.66)
        head.roundView()
        self.backView.layer.cornerRadius = 5
        self.backView.clipsToBounds = true
    }

}
