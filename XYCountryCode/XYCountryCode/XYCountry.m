//
//  XYCountry.m
//  XYCountryCode
//
//  Created by 杨卢银 on 2018/8/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYCountry.h"
@interface XYCountry ()
@property (strong , nonatomic)NSDictionary *info;
@end
@implementation XYCountry

-(instancetype)initWithDictionary:(NSDictionary *)aInfo{
    self = [super init];
    if (self) {
        _info = aInfo;
        _imageName = _info[@"locale"];
        _code = [_info[@"code"] stringValue];
        _en = _info[@"en"];
        _zh = _info[@"zh"];
        _tw = _info[@"tw"];
        
    }
    return self;
}
-(NSString *)name{
    if (!_name) {
        NSLocale *locale = [NSLocale currentLocale];
        //en_US zh_CN zh_CN
        if([locale.localeIdentifier isEqualToString:@"zh-TW"] || [locale.localeIdentifier isEqualToString:@"zh-HK"]){
            _name = _info[@"tw"];
        }else if([locale.localeIdentifier isEqualToString:@"zh-CH"] || [locale.localeIdentifier isEqualToString:@"en_CN"]){
            _name = _info[@"zh"];
        }else{
            _name = _info[@"en"];
        }
    }
    return _name;
}
-(UIImage *)image{
    if (!_image) {
        NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"XYCountryCode"ofType:@"bundle"];
        
        NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
        NSString *filename = [NSString stringWithFormat:@"Images/%@",_imageName];
        NSString *path = [resourceBundle pathForResource:filename ofType:@"png"];
        _image = [UIImage imageWithContentsOfFile:path];
    }
    return _image;
}
@end
