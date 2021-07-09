//
//  XYColor+UIColor.m
//  XYCountryCode
//
//  Created by Longdoudou on 2021/7/9.
//  Copyright © 2021 杨卢银. All rights reserved.
//

#import "XYColor+UIColor.h"

@implementation UIColor(XYColor)

+(UIColor *)xy_textColor{
    if (@available(iOS 11.0, *)) {
        return [UIColor colorNamed:@"xy_text_color"];
    } else {
        // Fallback on earlier versions
        return [UIColor blackColor];
    }
}
+(UIColor *)xy_textSubColor{
    if (@available(iOS 11.0, *)) {
        return [UIColor colorNamed:@"xy_sub_text_color"];
    } else {
        // Fallback on earlier versions
        return [UIColor grayColor];
    }
}

@end
