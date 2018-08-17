//
//  XYCountryCodeViewController.h
//  XYCountryCode
//
//  Created by 杨卢银 on 2018/8/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum XYCountryCodeShowType {
    XYCountryCodeShowTypeNone  = 0,
    XYCountryCodeShowTypePicker
} XYCountryCodeShowType;

@interface XYCountryCodeViewController : UIViewController

-(void)showViewController:(UIViewController *)vc showType:(XYCountryCodeShowType)aType;

@end
