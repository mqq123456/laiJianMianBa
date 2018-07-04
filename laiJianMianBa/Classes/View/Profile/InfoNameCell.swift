//
//  InfoNameCell.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/10.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class InfoNameCell: UITableViewCell {

    @IBOutlet weak var desc: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    
    @IBOutlet weak var sexCon: NSLayoutConstraint!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var labelW: NSLayoutConstraint!
    @IBOutlet weak var labe2W: NSLayoutConstraint!
    @IBOutlet weak var labe3W: NSLayoutConstraint!
    @IBOutlet weak var labe4W: NSLayoutConstraint!
    @IBOutlet weak var labe5W: NSLayoutConstraint!
    public var tags: [String] = NSArray() as! [String] {
        didSet {
            if tags.count>0 {
                ageLabel.text = tags[0]
                if isBoy == true {
                    sexLabel.text = "♂"
                }
                if isBoy == false {
                    sexLabel.text = "♀"
                }
                labelW.constant = getLabelRect(text: tags[0] as NSString, fontSize: 14).size.width + 20
                label1.isHidden = false
            }
            if tags.count>1 {
                label2.text = tags[1]
                labe2W.constant = getLabelRect(text: tags[1] as NSString, fontSize: 14).size.width + 20
                label2.isHidden = false
            }
            if tags.count>2 {
                label3.text = tags[2]
                labe3W.constant = getLabelRect(text: tags[2] as NSString, fontSize: 14).size.width + 20
                label3.isHidden = false
            }
            if tags.count>3 {
                label4.text = tags[3]
                labe4W.constant = getLabelRect(text: tags[3] as NSString, fontSize: 14).size.width + 20
                label4.isHidden = false
            }
            if tags.count>4 {
                label5.text = tags[4]
                labe5W.constant = getLabelRect(text: tags[4] as NSString, fontSize: 14).size.width + 20
                label5.isHidden = false
            }
        }
    }
    public var labelbackgroundColor: String = String() {
        didSet {
            if isBoy == true {
                label1.backgroundColor = UIColor("0ab9f5")
            }else{
                label1.backgroundColor = UIColor("ff6e8d")
            }
            label2.backgroundColor = UIColor("fe9712")
            label3.backgroundColor = UIColor( "7f4de6")
            label4.backgroundColor = UIColor("f5423e")
            label5.backgroundColor = UIColor(labelbackgroundColor)
        }
    }
    public var labelColor: String = String() {
        didSet {
            label1.textColor = UIColor(labelColor)
            label2.textColor = UIColor(labelColor)
            label3.textColor = UIColor(labelColor)
            label4.textColor = UIColor(labelColor)
            label5.textColor = UIColor(labelColor)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        name.text = UserAccountViewModel.standard.account?.name
        if IS_IOS10 {
            if IPHONE4 || IPHONE5 {
                sexCon.constant = -6
            }else if IPhone6{
                sexCon.constant = -10
            }else{
                sexCon.constant = -15
            }
        }else{
            if IPHONE4 || IPHONE5 {
                sexCon.constant = -4
            }else if IPhone6{
                sexCon.constant = -8
            }else{
                sexCon.constant = -10
            }
        }
        label1.layer.cornerRadius = 3
        label2.layer.cornerRadius = 3
        label3.layer.cornerRadius = 3
        label4.layer.cornerRadius = 3
        label5.layer.cornerRadius = 3
        label1.clipsToBounds = true
        label2.clipsToBounds = true
        label3.clipsToBounds = true
        label4.clipsToBounds = true
        label5.clipsToBounds = true
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
