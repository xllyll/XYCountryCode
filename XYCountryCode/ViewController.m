//
//  ViewController.m
//  XYCountryCode
//
//  Created by 杨卢银 on 2018/8/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "ViewController.h"
#import "XYCountryCodeViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)show:(id)sender {
    XYCountryCodeViewController *vc = [[XYCountryCodeViewController alloc] initWithShowType:XYCountryCodeShowTypePicker];
    vc.title = @"国家选择";
    [vc showViewController:self];
    [vc setChooseCodeRespose:^(NSString *code) {
        self.label.text = code;
    }];
}
- (IBAction)show2:(id)sender {
    
    XYCountryCodeViewController *vc = [[XYCountryCodeViewController alloc] initWithShowType:XYCountryCodeShowTypeNone];
    vc.textHighlightColor = [UIColor colorWithRed:25.0/255.0 green:159.0/255.0 blue:245.0/255.0 alpha:1.0];
    vc.title = @"国家选择";
    [vc showViewController:self];
    [vc setChooseCodeRespose:^(NSString *code) {
        self.label.text = code;
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
