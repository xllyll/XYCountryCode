//
//  XYCountryCodeUtils.h
//  XYCountryCode
//
//  Created by 杨卢银 on 2018/8/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYCountryManager.h"




@interface XYCountryCodeUtils : NSObject

+(XYCountryCodeUtils*)shareUtils;

-(NSArray<XYCountryManager*>*)managers;
@end
