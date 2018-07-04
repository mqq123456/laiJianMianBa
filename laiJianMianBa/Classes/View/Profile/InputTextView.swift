//
//  InputTextView.swift
//  laiJianMianBa
//
//  Created by HeQin on 17/1/7.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit

class InputTextView: UITextView {
    // MARK:- 懒加载属性
    lazy var placeHolderLabel : UILabel = UILabel()
    
    // MARK:- 构造函数
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
}
extension InputTextView {
    fileprivate func setupUI() {
        // 1.添加子控件
        addSubview(placeHolderLabel)
        
        // 2.设置frame
        placeHolderLabel.frame = CGRect(x: 12, y: 3.5, w: 200, h: 21)
        
        // 3.设置placeholderLabel属性
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.font = font
        
        // 4.设置placeholderLabel文字
        placeHolderLabel.text = "添加信息"
        
        // 5.设置内容的内边距
        textContainerInset = UIEdgeInsets(top: 6, left: 7, bottom: 0, right: 7)
    }
}
