//
//  XYCountryCodeViewController.h
//  XYCountryCode
//
//  Created by 杨卢银 on 2018/8/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYCountryCodeViewController;

@protocol XYCountryCodeViewControllerDelegate <UIBarPositioningDelegate>

@optional
-(void)countryCodeViewController:(XYCountryCodeViewController*)vc chooseCode:(NSString*)code;

@end

typedef enum XYCountryCodeShowType {
    XYCountryCodeShowTypeNone  = 0, /*! 列表模式 */
    XYCountryCodeShowTypePicker = 1 /*! picker模式 */
} XYCountryCodeShowType;

@interface XYCountryCodeViewController : UIViewController

-(instancetype)initWithShowType:(XYCountryCodeShowType)aType;
/**
 显示类型
 */
@property (assign ,nonatomic)XYCountryCodeShowType type;
/**
 搜索匹配文字高亮颜色
 */
@property (strong ,nonatomic)UIColor *textHighlightColor;

-(void)showViewController:(UIViewController *)vc;

@property (weak , nonatomic) id<XYCountryCodeViewControllerDelegate>delegate;

@property (strong , nonatomic) void (^chooseCodeRespose)(NSString*code);

@end
