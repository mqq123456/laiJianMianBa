//
//  ZWTagModel.m
//  liushimark
//
//  Created by HeQin on 17/1/6.
//  Copyright © 2017年 yuxin. All rights reserved.
//

#import "ZWTagModel.h"

@implementation ZWTagModel
/**
*  根据生日计算星座
*
*  @param brith 月份
*
*  @return 星座名称
*/
+(NSString *)calculateConstellationWithMonth:(NSString *)brith
{
    NSArray *array = [brith componentsSeparatedByString:@"-"];
    if (array.count >= 3) {
        int month = [array[1] intValue];
        int day = [array[2] intValue];
        NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
        NSString *astroFormat = @"102123444543";
        NSString *result;
            
        if (month<1 || month>12 || day<1 || day>31){
            return @"错误日期格式!";
        }
            
        if(month==2 && day>29)
        {
            return @"错误日期格式!!";
        }else if(month==4 || month==6 || month==9 || month==11) {
            if (day>30) {
                return @"错误日期格式!!!";
            }
        }
            
        result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
            
        return [NSString stringWithFormat:@"%@座",result];
    }
    return @"";
}
@end
