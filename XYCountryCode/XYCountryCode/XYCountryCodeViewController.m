//
//  XYCountryCodeViewController.m
//  XYCountryCode
//
//  Created by 杨卢银 on 2018/8/16.
//  Copyright © 2018年 杨卢银. All rights reserved.
//

#import "XYCountryCodeViewController.h"
#import "XYCountryCodeUtils.h"
#import "XYColor+UIColor.h"

@interface XYCountryCodeViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSInteger pickerSelectIndex;
}
@property (strong , nonatomic)UITableView *tableView;

@property (strong , nonatomic)NSArray *dataArray;

@property (strong , nonatomic)UISearchBar *searchBar;

@property (strong , nonatomic)NSArray *data;
@property (strong , nonatomic)NSArray *searchArray;


@property (strong , nonatomic)UIPickerView *pickerView;
@property (strong , nonatomic)UIView *pickerBGView;
@property (strong , nonatomic)UIImageView *pickerBGImageView;
@property (strong , nonatomic)UIButton *pickerBGCloseBT;
@property (strong , nonatomic)UILabel *pickerTitleLabel;
@property (strong , nonatomic)UIButton *pickerBGDemoBT;

@end

@implementation XYCountryCodeViewController

-(instancetype)initWithShowType:(XYCountryCodeShowType)aType{
    self = [super init];
    if (self) {
        self.type = aType;
        self.tintColor = UIColor.blackColor;
        self.cornerRadius = 5;
        if(self.textHighlightColor==nil){
            //默认颜色
            self.textHighlightColor = [UIColor colorWithRed:64.0/255.0 green:181.0/255.0 blue:132.0/255.0 alpha:1.0];
        }
    }
    return self;
}
-(void)showViewController:(UIViewController *)vc{
    
    if (_type==XYCountryCodeShowTypePicker) {
        //_showViewController= viewcontroller;
        
        self.view.backgroundColor = [UIColor clearColor];
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [vc presentViewController:self animated:NO completion:^{
            
        }];
    }else{
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
        nav.modalPresentationStyle = 0;
        [vc presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
    if (_type==XYCountryCodeShowTypePicker) {
        CGRect rect = self.pickerBGView.frame;
        rect.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.pickerBGView.frame = rect;
        
        self.pickerBGImageView.alpha = 0.0;
        pickerSelectIndex= 0;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_type == XYCountryCodeShowTypePicker) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.pickerBGView.frame;
            rect.origin.y = [UIScreen mainScreen].bounds.size.height - rect.size.height;
            self.pickerBGView.frame = rect;
            self.pickerBGImageView.alpha = 0.35;
        } completion:^(BOOL finished) {
            [self.pickerView reloadAllComponents];
        }];
    }
}
- (void)dismiss{
    if(_type == XYCountryCodeShowTypeNone){
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        self.pickerBGImageView.alpha = 0.0;
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
- (void)buildData{
    self.data = [[XYCountryCodeUtils shareUtils] countryArray];
    self.dataArray = [[XYCountryCodeUtils shareUtils] managers];
}
- (void)setup{
    [self buildData];
    
    if(_type == XYCountryCodeShowTypeNone){
        [self.view addSubview:self.tableView];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.tableFooterView = [[UIView alloc] init];
        CGRect rect = [UIScreen mainScreen].bounds;
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 56)];
        searchBar.placeholder = @"输入关键字";
        searchBar.delegate = self;
        self.tableView.tableHeaderView = searchBar;
        _searchBar = searchBar;
        
        
    }else if (_type == XYCountryCodeShowTypePicker){
        [self.view addSubview:self.pickerBGView];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
    
    }
    
    //xy_close
    NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"XYCountryCode"ofType:@"bundle"];
    
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString *path = [resourceBundle pathForResource:@"xy_close" ofType:@"png"];
    if (_type==XYCountryCodeShowTypeNone) {
        path = [resourceBundle pathForResource:@"xy_close" ofType:@"png"];
    }

    UIImage *leftImag = [UIImage imageWithContentsOfFile:path];
    
    UIBarButtonItem *leftBarButtonItem  =  [[UIBarButtonItem alloc] initWithImage:leftImag style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemSelect:)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem  =  [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemSelect:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.navigationController.navigationBar.tintColor = self.tintColor;
}
- (void)leftBarButtonItemSelect:(UIBarButtonItem*)sender{
    [self dismiss];
}
- (void)rightBarButtonItemSelect:(UIBarButtonItem*)sender{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)demoCheck:(UIButton*)sender{
    XYCountry *c = _data[pickerSelectIndex];
    if (self.delegate && [self.delegate respondsToSelector:@selector(countryCodeViewController:chooseCode:)]) {
        [self.delegate countryCodeViewController:self chooseCode:c.code];
    }
    if (_chooseCodeRespose) {
        _chooseCodeRespose(c.code);
    }
    
    [self dismiss];
}
#pragma mark set
-(UIImage*)closeBTImage{
    NSString *bundlePath = [[NSBundle mainBundle]pathForResource:@"XYCountryCode"ofType:@"bundle"];
    
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString *path = [resourceBundle pathForResource:@"xy_close" ofType:@"png"];
    
    UIImage *leftImag = [UIImage imageWithContentsOfFile:path];
    return leftImag;
}
-(UIView *)pickerBGView{
    if (!_pickerBGView) {
        
       
        
        CGRect rect = [UIScreen mainScreen].bounds;
        
        _pickerBGImageView = [[UIImageView alloc] initWithFrame:rect];
        _pickerBGImageView.backgroundColor = [UIColor blackColor];
        _pickerBGImageView.alpha  =0.35;
        [self.view addSubview:_pickerBGImageView];
        
        _pickerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 260)];
        UIView *topmenuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 44)];
        if (@available(iOS 13.0, *)) {
            topmenuView.backgroundColor = [UIColor systemBackgroundColor];
        } else {
            // Fallback on earlier versions
            topmenuView.backgroundColor = [UIColor whiteColor];
        }
        [_pickerBGView addSubview:topmenuView];
        
        
        _pickerBGCloseBT = [UIButton buttonWithType:UIButtonTypeCustom];
        _pickerBGCloseBT.frame = CGRectMake(10, 2, 40, 40);
        [_pickerBGCloseBT setImage:[self closeBTImage] forState:UIControlStateNormal];
        [_pickerBGCloseBT addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [topmenuView addSubview:_pickerBGCloseBT];
        
        _pickerTitleLabel = [[UILabel alloc] init];
        _pickerTitleLabel.text = self.title;
        [topmenuView addSubview:_pickerTitleLabel];
        [_pickerTitleLabel sizeToFit];
        _pickerTitleLabel.center = topmenuView.center;
        
        _pickerBGDemoBT = [UIButton buttonWithType:UIButtonTypeCustom];
        _pickerBGDemoBT.frame = CGRectMake(rect.size.width - 10 - 40, 2, 40, 40);
        [_pickerBGDemoBT setTitle:@"确定" forState:UIControlStateNormal];
        if (@available(iOS 13.0, *)) {
            [_pickerBGDemoBT setTitleColor:[UIColor systemGrayColor] forState:UIControlStateNormal];
        } else {
            // Fallback on earlier versions
            [_pickerBGDemoBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        [_pickerBGDemoBT addTarget:self action:@selector(demoCheck:) forControlEvents:UIControlEventTouchUpInside];
        [topmenuView addSubview:_pickerBGDemoBT];
        
        self.pickerView.frame  = CGRectMake(0, 44, rect.size.width, _pickerBGView.bounds.size.height - topmenuView.frame.size.height);
        self.pickerView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 13.0, *)) {
            self.pickerView.backgroundColor = [UIColor systemBackgroundColor];
        } else {
            // Fallback on earlier versions
            self.pickerView.backgroundColor = [UIColor whiteColor];
        }
        [_pickerBGView addSubview:self.pickerView];
    }
    return _pickerBGView;
}
-(UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
        _pickerView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
    }
    return _pickerView;
}
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
        
        cell.imageView.layer.cornerRadius = self.cornerRadius;
        cell.imageView.layer.masksToBounds = YES;
    }
    XYCountryManager *m;
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
        [attribute1 addAttribute:NSForegroundColorAttributeName value:self.textHighlightColor range:range1];
        [attribute2 addAttribute:NSForegroundColorAttributeName value:self.textHighlightColor range:range2];
        
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    XYCountryManager *m ;
    
    if (self.searchBar.text.length==0) {
        m = self.dataArray[indexPath.section];
    }else{
        m = self.searchArray[indexPath.section];
    }
    XYCountry *c = m.countrys[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(countryCodeViewController:chooseCode:)]) {
        [self.delegate countryCodeViewController:self chooseCode:c.code];
    }
    if (_chooseCodeRespose) {
        _chooseCodeRespose(c.code);
    }
    
    [self dismiss];
}
#pragma mark UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _data.count;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if(!view){
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    }
    
    XYCountry *c  = _data[row];
    UIImageView *imageView = [view viewWithTag:111];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 50, 30)];
        imageView.tag = 111;
        imageView.layer.cornerRadius = self.cornerRadius;
        imageView.layer.masksToBounds = YES;
        [view addSubview:imageView];
    }
    UILabel *label = [view viewWithTag:112];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(90, 7, 150, 30)];
        label.tag = 112;
        label.textColor = [UIColor xy_textColor];
        label.font = [UIFont systemFontOfSize:15.0];
        [view addSubview:label];
    }
    
    UILabel *sublabel = [view viewWithTag:113];
    if (!sublabel) {
        sublabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-10-100, 7, 100, 30)];
        sublabel.tag = 113;
        sublabel.textColor = [UIColor xy_textSubColor];
        sublabel.font = [UIFont systemFontOfSize:15.0];
        sublabel.textAlignment = NSTextAlignmentRight;
        [view addSubview:sublabel];
    }
    
    imageView.image = c.image;
    label.text = c.name;
    sublabel.text = [NSString stringWithFormat:@"+ %@",c.code];
    return view;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    pickerSelectIndex = row;
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
