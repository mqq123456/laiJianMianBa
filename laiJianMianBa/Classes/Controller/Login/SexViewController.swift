//
//  SexViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/20.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit

class SexViewController: RootViewController {
    
    @IBOutlet weak var btnH: NSLayoutConstraint!
    @IBOutlet weak var btnW: NSLayoutConstraint!
    @IBOutlet weak var topHeight: NSLayoutConstraint!
    @IBOutlet weak var nvLabel: UILabel!
    @IBOutlet weak var nanLabel: UILabel!
    @IBOutlet weak var manTex: UILabel!
    @IBOutlet weak var nvTex: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择性别"
        if IPHONE4 == true || IPHONE5 == true {
            btnH.constant = 80
            btnW.constant = 80
            topHeight.constant = 80
            manTex.font = UIFont.systemFont(ofSize: 15)
            nvTex.font = UIFont.systemFont(ofSize: 15)
        }
        nanLabel.text = "任何一段社交都是有\n价值的，我期待直接见面，\n用真心实意的红包认真地认识你。"
        nvLabel.text = "每一次相遇都绝非偶然。\n我满怀诚意地与你见面，无论\n你多不同，这里总会有人愿意陪你分享。"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func boyBtnClick(_ sender: Any) {
        push(sex: 1)
    }
    @IBAction func GirlBtnClick(_ sender: Any) {
        push(sex: 2)
    }
    private func push(sex:Int)  {
        let phone = PhoneViewController()
        phone.sex = sex
        navigationController?.pushViewController(phone, animated: true)
    }
}

