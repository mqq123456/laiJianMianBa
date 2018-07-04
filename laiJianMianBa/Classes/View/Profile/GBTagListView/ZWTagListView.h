//
//  ZWTagListView.h
//  自定义流式标签
//
//  Created by zhangwei on 15/10/22.
//  Copyright (c) 2015年 zhangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWTagListView : UIView{
    CGRect previousFrame ;
    int totalHeight ;
}
/**
 *  标签文本赋值
 */
-(void)setTagWithTagArray:(NSArray*)arr;
+ (CGFloat)getHeightWithArray:(NSArray*)arr;
@end
