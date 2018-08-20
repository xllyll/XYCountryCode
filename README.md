![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) ![](https://img.shields.io/cocoapods/v/XYCountryCode.svg?style=flat)
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)

# XYCountryCode

国家代码选择器，支持中英文、国旗


1.导入XYCountryCode类

##pod

```objective-c

pod 'XYCountryCode'

```

三行代码集成国家区号选择功能
类型
```objective-c

XYCountryCodeShowTypeNone //默认为列表
XYCountryCodeShowTypePicker //picker模式

```

代码如下：
```objective-c
XYCountryCodeViewController *vc = [[XYCountryCodeViewController alloc] initWithShowType:XYCountryCodeShowTypePicker];
[vc showViewController:self];
[vc setChooseCodeRespose:^(NSString *code) {
    self.label.text = code;
}];
```

##-----------------------------------------

![image](https://github.com/xllyll/XYCountryCode/blob/master/gif01.gif?raw=true)
![image](https://github.com/xllyll/XYCountryCode/blob/master/image2.png?raw=true)
![image](https://github.com/xllyll/XYCountryCode/blob/master/image3.png?raw=true)
![image](https://github.com/xllyll/XYCountryCode/blob/master/image4.png?raw=true)

------------------by xllyll----------------
