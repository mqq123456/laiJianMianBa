//
//  ZWTagModel.h
//  liushimark
//
//  Created by HeQin on 17/1/6.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZWTagModel : NSObject
/// 标签颜色
@property (nonatomic , strong) UIColor *textColor;
/// 标签背景颜色
@property (nonatomic , strong) UIColor *backgroundColor;
/// 标签边框颜色
@property (nonatomic , strong) UIColor *borderColor;
///
@property (nonatomic , copy) NSString *title;
+(NSString *)calculateConstellationWithMonth:(NSString *)brith;
@end
