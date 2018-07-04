//
//  EvaluateHeadView.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/22.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class EvaluateHeadView: UIView {
    /// 设置控件参数
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var head: UIImageView!
    public var status = UserAccount() {
        didSet {
            head.kf.setImage(with: URL(string: status.avatar), placeholder: UIImage(named: "loading"), options: nil, progressBlock: { (_, _) in
                
            }) { (image, error, _, _) in
                
            }
            detail.text = status.occupation + " | " + status.age + "岁"
            name.text = status.name
        }
    }

}
