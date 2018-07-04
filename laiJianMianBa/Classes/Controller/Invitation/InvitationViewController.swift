//
//  InvitationViewController.swift
//  laiJianMianBa
//
//  Created by HeQin on 16/12/19.
//  Copyright © 2016年 fundot. All rights reserved.
//  邀请界面，包含谁想见我，我想见谁

import UIKit
//import JMServicesKit
/// 上部分tab，可以滑动切换，用两个控制器切换
class InvitationViewController: RootViewController {

    fileprivate var line: UILabel!
    fileprivate var tabBtn1: UIButton!
    fileprivate var tabBtn2: UIButton!
    fileprivate var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的邀请"
        setUpUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension InvitationViewController {
    func setUpUI() {
        
        tabBtn1 = UIButton(x: 0, y: 64, w: screenW/2, h: 50, target: self, action: #selector(tabBtn1Click))
        tabBtn1.setTitle("我收到的", for: .normal)
        tabBtn1.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(tabBtn1)
        
        tabBtn1.layer.borderColor = RGBA(r: 191, g: 191, b: 191, a: 1).cgColor
        tabBtn1.layer.borderWidth = 0.4
        tabBtn2 = UIButton(x: screenW/2, y: 64, w: screenW/2, h: 50, target: self, action: #selector(tabBtn2Click))
        tabBtn2.setTitleColor(RGBA(r: 102, g: 102, b: 102, a: 1), for: .normal)
        tabBtn2.setTitle("我发出的", for: .normal)
        tabBtn2.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(tabBtn2)
        tabBtn2.layer.borderColor = RGBA(r: 191, g: 191, b: 191, a: 1).cgColor
        tabBtn2.layer.borderWidth = 0.4
        
        line = UILabel(x: 0, y: 47+64, w: screenW/2, h: 3)
        
        view.addSubview(line)
        line.backgroundColor = globalColor()
        tabBtn1.setTitleColor(globalColor(), for: .normal)
        
        scrollView = UIScrollView(x: 0, y: 64+50, w: screenW, h: screenH-50-64)
        scrollView.contentSize = CGSize(width: screenW*2, height: screenH-50-64)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.backgroundColor = UIColor.gray
        scrollView.autoresizesSubviews = false
        scrollView.delegate = self
        
        let view1 = InvitationCellViewController(type: 3)
        addChildViewController(view1)
        view1.view.backgroundColor = UIColor.purple
        view1.view.frame = CGRect(x: 0, y: 0, w: screenW, h: screenH-50-64)
        scrollView.addSubview(view1.view)
        let view2 = InvitationCellViewController(type: 1)
        addChildViewController(view2)
        view2.view.backgroundColor = UIColor.red
        view2.view.frame = CGRect(x: screenW, y: 0, w: screenW, h: screenH-50-64)
        scrollView.addSubview(view2.view)
        view.addSubview(scrollView)
    }
    @objc private func tabBtn1Click() {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    @objc private func tabBtn2Click() {
        scrollView.setContentOffset(CGPoint(x: screenW, y: 0), animated: true)
    }
}
extension InvitationViewController: UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        contentOffsetCalculate(scrollView: scrollView)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        contentOffsetCalculate(scrollView: scrollView)
    }
    private func contentOffsetCalculate(scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 10 {
            tabBtn2.setTitleColor(globalColor(), for: .normal)
            line.frame = CGRect(x: screenW/2, y: 47+64, w: screenW/2, h: 3)
            tabBtn1.setTitleColor(RGBA(r: 102, g: 102, b: 102, a: 1), for: .normal)
            line.backgroundColor = globalColor()
        }else {
            tabBtn1.setTitleColor(globalColor(), for: .normal)
            tabBtn2.setTitleColor(RGBA(r: 102, g: 102, b: 102, a: 1), for: .normal)
            line.frame = CGRect(x: 0, y: 47+64, w: screenW/2, h: 3)
            line.backgroundColor = globalColor()
        }
    }
}
