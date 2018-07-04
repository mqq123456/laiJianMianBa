//
//  UserHeadView.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/21.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class UserHeadView: UIView {
    @IBOutlet weak var nameWidth: NSLayoutConstraint!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var coverVIew: UIView!
    @IBOutlet weak var detailView: UIView!
    override func awakeFromNib() {
        let gradientLayer = CAGradientLayer().GradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, w: screenH, h: coverVIew.frame.size.height)
        coverVIew.layer.addSublayer(gradientLayer)
        detailView.isUserInteractionEnabled = true
    }
    
    public var user: UserAccount = UserAccount() {
        didSet {
            headImg.kf.setImage(with: URL(string: user.avatar), placeholder: UIImage(named: "loading"), options: nil, progressBlock: { (_, _) in
                
            }) { (image, error, _, _) in
                
            }
            if user.sex == 1 {
                sex.text = "♂"
            }else{
                sex.text = "♀"
            }
            name.text = user.name
            let attributes = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 18)]
            let rect : CGRect = user.name!.boundingRect(with: CGSize(width: screenW/3-10, height: 20), options: NSStringDrawingOptions.usesLineFragmentOrigin , attributes:attributes , context: nil);
            
            if rect.size.width == screenW/3-10 {
                nameWidth.constant = rect.size.width-10
            }else{
                nameWidth.constant = rect.size.width + 2
            }
            detail.text = "\(user.occupation!) | \(user.age!)岁"
            desc.text  = user.signature!
            
        }
    }
}
