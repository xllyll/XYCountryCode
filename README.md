![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) ![](https://img.shields.io/cocoapods/v/XYCountryCode.svg?style=flat)
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)

# XYCountryCode

国家代码选择器，支持中英文、国旗


1.导入XWCountryCode类

pod

pod 'XYCountryCode'

三行代码集成国家区号选择功能

```objective-c
XYCountryCodeViewController *vc = [[XYCountryCodeViewController alloc] init];
[vc showViewController:self showType:XYCountryCodeShowTypeNone];
[vc setChooseCodeRespose:^(NSString *code) {
self->zone = code;
}];
```

##-----------------------------------------

![image](https://github.com/xllyll/XYCountryCode/blob/master/gif01.gif?raw=true)
![image](https://github.com/xllyll/XYCountryCode/blob/master/image2.png?raw=true)
![image](https://github.com/xllyll/XYCountryCode/blob/master/image3.png?raw=true)
