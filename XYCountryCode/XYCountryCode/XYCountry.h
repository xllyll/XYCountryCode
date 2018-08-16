//
//  XYCountry.h
//  XYCountryCode
//
//  Created by 杨卢银 on 2018/8/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum XYCountryShowType {
    XYCountryShowTypeEN  = 0,
    XYCountryShowTypeZH,
    XYCountryShowTypeTW
} XYCountryShowType;

@interface XYCountry : NSObject

-(instancetype)initWithDictionary:(NSDictionary*)aInfo;



@property (strong , nonatomic) NSString *zh;
@property (strong , nonatomic) NSString *en;
@property (strong , nonatomic) NSString *tw;

@property (strong , nonatomic) NSString *code;

@property (strong , nonatomic) NSString *imageName;

@property (strong , nonatomic) NSString *name;

@property (strong , nonatomic) UIImage  *image;

@end
