//
//  XYCountryCodeViewController.m
//  XYCountryCode
//
//  Created by 杨卢银 on 2018/8/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYCountryCodeViewController.h"
#import "XYCountryCodeUtils.h"

@interface XYCountryCodeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic)UITableView *tableView;
@property (strong , nonatomic)NSArray *dataArray;

@end

@implementation XYCountryCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)setup{
    self.dataArray = [[XYCountryCodeUtils shareUtils] managers];
    
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark set
-(UITableView *)tableView{
    if (!_tableView) {
        CGRect mainscreen = [UIScreen mainScreen].bounds;
        _tableView = [[UITableView alloc] initWithFrame:mainscreen style:UITableViewStylePlain];
    }
    return _tableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    XYCountryManager *m = self.dataArray[section];
    return m.countrys.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    XYCountryManager *m = self.dataArray[indexPath.section];
    XYCountry *c = m.countrys[indexPath.row];
    cell.textLabel.text = c.zh;
    cell.detailTextLabel.text = [@"+ " stringByAppendingString:c.code];
    cell.imageView.image = c.image;
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    XYCountryManager *m = self.dataArray[section];
    return m.title;
}
@end
