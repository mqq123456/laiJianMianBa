//
//  GrilCoverView.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/22.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit

class GrilCoverView: UIView {

    override func awakeFromNib() {
        self.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0.66)
    }
    @IBAction func btnDone(_ sender: Any) {
        self.removeFromSuperview()
    }

}
