//
//  XYCountryCodeUtils.m
//  XYCountryCode
//
//  Created by 杨卢银 on 2018/8/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYCountryCodeUtils.h"

@interface XYCountryCodeUtils ()


@end

@implementation XYCountryCodeUtils

static XYCountryCodeUtils* _instance = nil;

+(XYCountryCodeUtils *)shareUtils
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[XYCountryCodeUtils alloc] init] ;
    }) ;
    
    return _instance ;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self buildData];
    }
    return self;
}
-(void)buildData{
    // 设置文件路径
    
    NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"XYCountryCode"ofType:@"bundle"];
    
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString *jsonPath = [resourceBundle pathForResource:@"Data/XYCountryCode" ofType:@"json"];
    
    _countryArray = [NSMutableArray array];
    
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    
    NSError *error;
    
    NSArray *list = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    for (NSDictionary *info in list) {
        XYCountry *c = [[XYCountry alloc] initWithDictionary:info];
        [_countryArray addObject:c];
    }
    
}
-(NSArray<XYCountryManager *> *)managers{
    return [self managersByShowType:XYCountryShowTypeZH];
}
-(NSArray<XYCountryManager *> *)managersByShowType:(XYCountryShowType)aType{
    NSMutableDictionary *listdic = [NSMutableDictionary dictionary];
    if (_countryArray && _countryArray.count>0) {
        for (XYCountry *country in self.countryArray) {
            NSString *firstZ = [self firstCharactorWithString:country.en];
            if (aType == XYCountryShowTypeZH) {
                firstZ = [self firstCharactorWithString:country.zh];
            }
            if (aType == XYCountryShowTypeTW) {
                firstZ = [self firstCharactorWithString:country.tw];
            }
            NSMutableArray *list = listdic[firstZ];
            if (!list) {
                list = [NSMutableArray array];
                [listdic setObject:list forKey:firstZ];
            }
            [list addObject:country];
        }
    }
    NSMutableArray *list = [NSMutableArray array];
    for (NSString *key in listdic.allKeys) {
        NSArray *l = listdic[key];
        XYCountryManager *m = [[XYCountryManager alloc] init];
        m.title = key;
        m.countrys = l;
        [list addObject:m];
    }
    
    NSArray *resultArray = [list sortedArrayUsingComparator:^NSComparisonResult(XYCountryManager *obj1, XYCountryManager *obj2) {
        return [obj1.title compare:obj2.title];
        
    }];

    return resultArray;
}

//获取某个字符串或者汉字的首字母.
- (NSString *)firstCharactorWithString:(NSString *)string

{
    
    NSMutableString *str = [NSMutableString stringWithString:string];
    
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSString *pinYin = [str capitalizedString];
    
    return [pinYin substringToIndex:1];
    
}
-(NSArray<XYCountryManager *> *)buildManagers:(NSArray<XYCountry *> *)countrys showType:(XYCountryShowType)aType{
    NSMutableDictionary *listdic = [NSMutableDictionary dictionary];
    if (countrys && countrys.count>0) {
        for (XYCountry *country in countrys) {
            NSString *firstZ = [self firstCharactorWithString:country.en];
            if (aType == XYCountryShowTypeZH) {
                firstZ = [self firstCharactorWithString:country.zh];
            }
            if (aType == XYCountryShowTypeTW) {
                firstZ = [self firstCharactorWithString:country.tw];
            }
            NSMutableArray *list = listdic[firstZ];
            if (!list) {
                list = [NSMutableArray array];
                [listdic setObject:list forKey:firstZ];
            }
            [list addObject:country];
        }
    }
    NSMutableArray *list = [NSMutableArray array];
    for (NSString *key in listdic.allKeys) {
        NSArray *l = listdic[key];
        XYCountryManager *m = [[XYCountryManager alloc] init];
        m.title = key;
        m.countrys = l;
        [list addObject:m];
    }
    
    NSArray *resultArray = [list sortedArrayUsingComparator:^NSComparisonResult(XYCountryManager *obj1, XYCountryManager *obj2) {
        return [obj1.title compare:obj2.title];
    }];
    
    return resultArray;
}
@end
