//
//  XYCountryCodeViewController.m
//  XYCountryCode
//
//  Created by 杨卢银 on 2018/8/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYCountryCodeViewController.h"
#import "XYCountryCodeUtils.h"

@interface XYCountryCodeViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (strong , nonatomic)UITableView *tableView;
@property (strong , nonatomic)NSArray *dataArray;

@property (strong , nonatomic)UISearchBar *searchBar;

@property (strong , nonatomic)NSArray *data;
@property (strong , nonatomic)NSArray *searchArray;
@end

@implementation XYCountryCodeViewController


-(void)showViewController:(UIViewController *)vc showType:(XYCountryCodeShowType)aType{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    [vc presentViewController:nav animated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)setup{
    self.data = [[XYCountryCodeUtils shareUtils] countryArray];
    
    self.dataArray = [[XYCountryCodeUtils shareUtils] managers];
    
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    CGRect rect = [UIScreen mainScreen].bounds;
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 56)];
    searchBar.placeholder = @"输入关键字";
    searchBar.delegate = self;
    self.tableView.tableHeaderView = searchBar;
    _searchBar = searchBar;
    
    //xy_close
    NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"XYCountryCode"ofType:@"bundle"];
    
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString *path = [resourceBundle pathForResource:@"xy_close" ofType:@"png"];

    UIImage *leftImag = [UIImage imageWithContentsOfFile:path];
    
    UIBarButtonItem *leftBarButtonItem  =  [[UIBarButtonItem alloc] initWithImage:leftImag style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemSelect:)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem  =  [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemSelect:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
- (void)leftBarButtonItemSelect:(UIBarButtonItem*)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)rightBarButtonItemSelect:(UIBarButtonItem*)sender{
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
    if (_searchBar.text.length>0) {
        return self.searchArray.count;
    }
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    XYCountryManager *m;
    if (_searchBar.text.length>0) {
        m = self.searchArray[section];
    }else{
        m = self.dataArray[section];
    }
    
    return m.countrys.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    XYCountryManager *m ;
    
    if (self.searchBar.text.length==0) {
        m = self.dataArray[indexPath.section];
    }else{
        m = self.searchArray[indexPath.section];
    }
    XYCountry *c = m.countrys[indexPath.row];
    
    if (_searchBar.text.length>0) {
        // 原始搜索结果字符串.
        NSString *originResult1 = c.name;
        NSString *originResult2 = [@"+ " stringByAppendingString:c.code];
        // 获取关键字的位置
        NSRange range1 = [originResult1 rangeOfString:self.searchBar.text];
        NSRange range2 = [originResult2 rangeOfString:self.searchBar.text];
        // 转换成可以操作的字符串类型.
        NSMutableAttributedString *attribute1 = [[NSMutableAttributedString alloc] initWithString:originResult1];
        NSMutableAttributedString *attribute2 = [[NSMutableAttributedString alloc] initWithString:originResult2];
        // 添加属性(粗体)
        [attribute1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range1];
        [attribute2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range2];
        // 关键字高亮
        [attribute1 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range1];
        [attribute2 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range2];
        
        // 将带属性的字符串添加到cell.textLabel上.
        [cell.textLabel setAttributedText:attribute1];
        [cell.detailTextLabel setAttributedText:attribute2];
    }
    cell.textLabel.text = c.name;
    cell.detailTextLabel.text = [@"+ " stringByAppendingString:c.code];
    
    cell.imageView.image = c.image;
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    XYCountryManager *m;
    if (self.searchBar.text.length==0) {
        m = self.dataArray[section];
    }else{
        m = self.searchArray[section];
    }
    return m.title;
}
#pragma mark serachBarDeleagte
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSString *searchTextString = searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"zh contains[cd] %@ OR tw contains[cd] %@ OR en contains[cd] %@ OR code contains[cd] %@",searchTextString,searchTextString,searchTextString,searchTextString];
    NSMutableArray *list =  [[NSMutableArray alloc] initWithArray:[_data filteredArrayUsingPredicate:predicate]];
  
    self.searchArray = [[XYCountryCodeUtils shareUtils] buildManagers:list showType:XYCountryShowTypeZH];
    
    [_tableView reloadData];
}
@end
