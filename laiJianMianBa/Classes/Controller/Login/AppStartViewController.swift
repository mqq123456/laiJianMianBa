//
//  AppStartViewController.swift
//  laiJianMianBa
//
//  Created by heqinuc on 17/1/23.
//  Copyright © 2017年 fundot. All rights reserved.
//

import UIKit
/// 主页按钮跳转回调协议
protocol AppStartViewControllerDelegate {
    /// 点击跳过或者进入来见面吧
    func didStartApp()
}
class AppStartViewController: UIViewController {
    
    var delegate: AppStartViewControllerDelegate!
    
    /// 滑动scrollView
    fileprivate var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        scrollView = UIScrollView(x: 0, y: 0, w: screenW, h: screenH)
        scrollView.contentSize = CGSize(width: screenW*4, height: screenH)
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.backgroundColor = UIColor.gray
        scrollView.autoresizesSubviews = false
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        for i in 1 ..< 5 {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: CGFloat(Int(i-1)*Int(screenW)), y: 0, w: screenW, h: screenH)
            imageView.isUserInteractionEnabled = true
            if IPHONE4 {
                imageView.image = UIImage(named: "guide_page_4_\(i).jpg")
            }else{
                imageView.image = UIImage(named: "guide_page\(i).jpg")
            }
            if i == 4 {
                let pBtn = UIButton(frame: CGRect(x: 0, y: screenH - 100, w: screenW, h: 60))
                pBtn.addTarget(self, action: #selector(didJoininDone), for: .touchUpInside)
                imageView.addSubview(pBtn)
            }
            let skipBtn = UIButton(x: screenW - 60, y: 20, w: 40, h: 40, target: self, action: #selector(didJoininDone))
            imageView.addSubview(skipBtn)
            scrollView?.addSubview(imageView)
        }
        
    }
    @objc func didJoininDone() {
        UserDefaults.standard.set(ez.appVersion, forKey: "appVersion")
        UserDefaults.standard.synchronize()
        if (delegate != nil) {
            delegate.didStartApp()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension AppStartViewController: UIScrollViewDelegate {
    
}
