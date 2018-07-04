//
//  UnlimitedSlideVC.swift
//  CarouselPicture_NoLimited
//
//  Created by langyue on 15/11/19.
//  Copyright © 2015年 langyue. All rights reserved.
//

import UIKit
import Kingfisher

@objc protocol UnlimitedSlideVCDelegate{
    
    func backDataSourceArray()->NSMutableArray
    @objc optional func backScrollerViewForWidthAndHeight()->CGSize
    
}

let kScreenWidth = UIScreen.main.bounds.size.width


@objc class UnlimitedSlideVC: UIViewController,UIScrollViewDelegate{

    var delegate : UnlimitedSlideVCDelegate!
    
    var leftImageView , middleImageView , rightImageView : UIImageView?
    
    var scrollerView : UIScrollView?
    
    //当前展示的图片
    var currentIndex : Int?
    //数据源
    var dataSource : NSMutableArray?
    //scrollView的宽和高
    var scrollerViewWidth : CGFloat?
    var scrollerViewHeight : CGFloat?
    
    var pageControl : UIPageControl?
    
    var isPageControl : NSNumber!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.currentIndex = 0
        
        self.scrollerViewWidth = kScreenWidth-20
        self.scrollerViewHeight = 300
        
        let size : CGSize = self.delegate.backScrollerViewForWidthAndHeight!()
        
        self.scrollerViewWidth = size.width
        self.scrollerViewHeight = size.height
        
        self.dataSource =  NSMutableArray(array: self.delegate.backDataSourceArray())
        self.configureScrollerView()
        self.configureImageView()
        
        if(( self.isPageControl.boolValue ) != false){
            self.configurePageController()
        }
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(UnlimitedSlideVC.letItScroll), userInfo: nil, repeats: true)
        self.view.backgroundColor = UIColor.red
    }
    public func reloadData() {
        self.view.removeSubviews()
        self.currentIndex = 0
        self.scrollerViewWidth = kScreenWidth-20
        self.scrollerViewHeight = 300
        let size : CGSize = self.delegate.backScrollerViewForWidthAndHeight!()
        self.scrollerViewWidth = size.width
        self.scrollerViewHeight = size.height
        self.dataSource =  NSMutableArray(array: self.delegate.backDataSourceArray())
        self.configureScrollerView()
        self.configureImageView()
        if(( self.isPageControl.boolValue ) != false){
            self.configurePageController()
        }
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(UnlimitedSlideVC.letItScroll), userInfo: nil, repeats: true)
        self.view.backgroundColor = UIColor.red
    }
    func letItScroll(){
        
        self.scrollerView?.setContentOffset( CGPoint(x: 2*scrollerViewWidth!, y: 0), animated: true)
    }
    
    func configureScrollerView(){
        
        self.scrollerView = UIScrollView(frame: CGRect(x: 0,y: 0,width: self.scrollerViewWidth!,height: self.scrollerViewHeight!))
        self.scrollerView?.backgroundColor = UIColor.white
        self.scrollerView?.delegate = self
        self.scrollerView?.contentSize = CGSize(width: self.scrollerViewWidth! * 3, height: self.scrollerViewHeight!)
        self.scrollerView?.contentOffset = CGPoint(x: self.scrollerViewWidth!, y: 0)
        self.scrollerView?.isPagingEnabled = true
        self.scrollerView?.bounces = false
        self.view.addSubview(self.scrollerView!)
        
    }
    
    
    func configureImageView(){
        
        self.leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.scrollerViewWidth!, height: self.scrollerViewHeight!))
        
        self.middleImageView = UIImageView(frame: CGRect(x: self.scrollerViewWidth!, y: 0, width: self.scrollerViewWidth!, height: self.scrollerViewHeight! ));
        
        self.rightImageView = UIImageView(frame: CGRect(x: 2*self.scrollerViewWidth!, y: 0, width: self.scrollerViewWidth!, height: self.scrollerViewHeight!));
        
        self.scrollerView?.showsHorizontalScrollIndicator = false
        if(self.dataSource?.count != 0){
            self.leftImageView?.kf.setImage(with: URL(string: self.dataSource?.lastObject as! String)!)
            self.middleImageView?.kf.setImage(with: URL(string: self.dataSource?.firstObject as! String)!)
            self.rightImageView?.kf.setImage(with: URL(string: self.dataSource![1] as! String)!)
            
        }
        
        self.scrollerView?.addSubview(self.leftImageView!)
        self.scrollerView?.addSubview(self.middleImageView!)
        self.scrollerView?.addSubview(self.rightImageView!)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x
        
        if(self.dataSource?.count != 0){
            
            if(offset >= self.scrollerViewWidth!*2){
                
                scrollView.contentOffset = CGPoint(x: self.scrollerViewWidth!, y: 0)
                self.currentIndex = self.currentIndex! + 1
                
                if(self.currentIndex == (self.dataSource?.count)! - 1){
                    
                    self.leftImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex! - 1] as! String)!)
                    self.middleImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex!] as! String)!)
                    self.rightImageView?.kf.setImage(with: URL(string: (self.dataSource?.firstObject)! as! String)!)
                    
                    self.pageControl?.currentPage = self.currentIndex!;
                    self.currentIndex = -1
                    
                }else if(self.currentIndex == self.dataSource?.count){
                    
                    self.leftImageView?.kf.setImage(with: URL(string: self.dataSource!.lastObject as! String)!)
                    self.middleImageView?.kf.setImage(with: URL(string: self.dataSource!.firstObject as! String)!)
                    self.rightImageView?.kf.setImage(with: URL(string: self.dataSource![1] as! String)!)
                    
                    self.pageControl?.currentPage = 0
                    self.currentIndex = 0
                    
                    
                }else if(self.currentIndex == 0){
                    
                    
                    self.leftImageView?.kf.setImage(with: URL(string: self.dataSource!.lastObject as! String)!)
                    self.middleImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex!] as! String)!)
                    self.rightImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex!+1] as! String)!)
                    
                    self.pageControl?.currentPage = self.currentIndex!
                    
                }else{
                    
                    
                    self.leftImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex!-1] as! String)!)
                    self.middleImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex!] as! String)!)
                    self.rightImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex!+1] as! String)!)
                    
                    self.pageControl?.currentPage = self.currentIndex!
                  
                }
                
            }
            
            if(offset <= 0){
                
                scrollView.contentOffset = CGPoint(x: self.scrollerViewWidth!, y: 0);
                
                self.currentIndex = self.currentIndex! - 1
                
                if(self.currentIndex == -2 ){
                    
                    self.currentIndex = (self.dataSource?.count)! - 2
                    
                    self.leftImageView?.kf.setImage(with: URL(string: self.dataSource![(self.dataSource?.count)! - 1] as! String)!)
                    self.middleImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex!] as! String)!)
                    self.rightImageView?.kf.setImage(with: URL(string: (self.dataSource?.lastObject)! as! String)!)
                    
                    self.pageControl?.currentPage = self.currentIndex!;
                    
                }else if(self.currentIndex == -1 ){
                    
                    self.currentIndex = (self.dataSource?.count)! - 1
                    
                    
                    self.leftImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex!-1] as! String)!)
                    self.middleImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex!] as! String)!)
                    self.rightImageView?.kf.setImage(with: URL(string: self.dataSource?.firstObject as! String)!)
                    
                    self.pageControl?.currentPage = self.currentIndex!
                    
                }else if(self.currentIndex == 0){
                    
                    self.leftImageView?.kf.setImage(with: URL(string: self.dataSource!.lastObject as! String)!)
                    self.middleImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex!] as! String)!)
                    self.rightImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex!+1] as! String)!)
                    
                    self.pageControl?.currentPage = self.currentIndex!
                    
                }else{
                    
                    self.leftImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex!-1] as! String)!)
                    self.middleImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex!] as! String)!)
                    self.rightImageView?.kf.setImage(with: URL(string: self.dataSource![self.currentIndex!+1] as! String)!)
                    
                    self.pageControl?.currentPage = self.currentIndex!
                    
                }
            }
        }
        
    }
    
    func configurePageController() {
        
        self.pageControl = UIPageControl(frame: CGRect(x: kScreenWidth/2-60,y: self.scrollerViewHeight! - 20,width: 120,height: 20)) //self.scrollerViewWidth!
        self.pageControl?.numberOfPages = (self.dataSource?.count)!
        self.pageControl?.isUserInteractionEnabled = false
        self.view.addSubview(self.pageControl!)
        
    }
    
    func backCurrentClickPicture()-> NSInteger{
        return (self.pageControl?.currentPage)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
