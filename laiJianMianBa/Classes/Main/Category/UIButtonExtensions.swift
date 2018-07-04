//
//  UIButtonExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 15/07/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

import UIKit

extension UIButton {
    
	/// EZSwiftExtensions
    convenience init (imageName : String, bgImageName : String) {
        self.init()
        //暂时不知道normal 的api
        setImage(UIImage(named: imageName), for: UIControlState(rawValue: UInt(0.0)))
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named: bgImageName), for: UIControlState(rawValue: UInt(0.0)))
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        sizeToFit()
    }
    
    convenience init(bgColor : UIColor, fontSize : CGFloat, title : String) {
        self.init()
        
        setTitle(title, for: UIControlState(rawValue: UInt(0.0)))
        backgroundColor = bgColor
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
    }
    
	// swiftlint:disable function_parameter_count
	public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, target: AnyObject, action: Selector) {
		self.init(frame: CGRect(x: x, y: y, width: w, height: h))
		addTarget(target, action: action, for: UIControlEvents.touchUpInside)
	}
	// swiftlint:enable function_parameter_count

	/// EZSwiftExtensions
	public func setBackgroundColor(color: UIColor, forState: UIControlState) {
		UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
		UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
		UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
		let colorImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		self.setBackgroundImage(colorImage, for: forState)
	}
}
