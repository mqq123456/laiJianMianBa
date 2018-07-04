//
//  PerfectHeadImageView.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/20.
//  Copyright © 2016年 fundot. All rights reserved.
//

import UIKit
//import JMServicesKit
class PerfectHeadImageView: UIView {
    
    /// 大图
    @IBOutlet weak var bigImg: UIImageView!
   
    /// 第一个图，右上角开始，顺时针方向排序
    @IBOutlet weak var img1: UIImageView!

    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var img3: UIImageView!
    
    @IBOutlet weak var img4: UIImageView!
    
    @IBOutlet weak var img5: UIImageView!
    
    override func layoutSubviews() {
        frame = CGRect(x: 0, y: 0, w: screenW, h: screenW)
    }
    override func awakeFromNib() {
        if (UserAccountViewModel.standard.account?.headImgs.count)! > 0 {
            bigImg.kf.setImage(with: URL(string: (UserAccountViewModel.standard.account?.headImgs[0])!), placeholder: UIImage(named: "zhuce_tianjiatouxiang"), options: nil, progressBlock: { (_, _) in
                
            }) { (image, error, _, _) in
                
            }
        }
        if (UserAccountViewModel.standard.account?.headImgs.count)! > 1  {
            img1.kf.setImage(with: URL(string: (UserAccountViewModel.standard.account?.headImgs[1])!), placeholder: UIImage(named: "zhuce_tianjiatouxiang"), options: nil, progressBlock: { (_, _) in
                
            }) { (image, error, _, _) in
                
            }
        }
        if (UserAccountViewModel.standard.account?.headImgs.count)! > 2  {
            img2.kf.setImage(with: URL(string: (UserAccountViewModel.standard.account?.headImgs[2])!), placeholder: UIImage(named: "zhuce_tianjiatouxiang"), options: nil, progressBlock: { (_, _) in
                
            }) { (image, error, _, _) in
                
            }
        }
        if (UserAccountViewModel.standard.account?.headImgs.count)! > 3  {
            img3.kf.setImage(with: URL(string: (UserAccountViewModel.standard.account?.headImgs[3])!), placeholder: UIImage(named: "zhuce_tianjiatouxiang"), options: nil, progressBlock: { (_, _) in
                
            }) { (image, error, _, _) in
                
            }
        }
        if (UserAccountViewModel.standard.account?.headImgs.count)! > 4  {
            img4.kf.setImage(with: URL(string: (UserAccountViewModel.standard.account?.headImgs[4])!), placeholder: UIImage(named: "zhuce_tianjiatouxiang"), options: nil, progressBlock: { (_, _) in
                
            }) { (image, error, _, _) in
                
            }
        }
        if (UserAccountViewModel.standard.account?.headImgs.count)! > 5  {
            img5.kf.setImage(with: URL(string: (UserAccountViewModel.standard.account?.headImgs[5])!), placeholder: UIImage(named: "zhuce_tianjiatouxiang"), options: nil, progressBlock: { (_, _) in
                
            }) { (image, error, _, _) in
                
            }
        }

    }
    
}
