//
//  MainViewController.m
//  iOS_ALL_Demo
//
//  Created by Ken_lu on 02/09/2017.
//  Copyright © 2017 Ken lu. All rights reserved.
//

#import "MainViewController.h"
#import "TableViewCell.h"
#import "UILabelViewController.h"
#import "TableViewController.h"
#import "AutoLayoutViewController.h"
#import "RecorderViewController.h"
#import "PhotoViewController.h"
#import "tableViewInCell.h"
#import "tableViewInCell2.h"
#import "GCDViewController.h"
#import "iOS_ALL_Demo-Swift.h"


@interface MainViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) NSArray<NSString *>  *titles;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
    [self initRequest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            UILabelViewController *vc = [[UILabelViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:{
            TableViewController *vc = [[TableViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{
            AutoLayoutViewController *vc = [AutoLayoutViewController __viewControllerWithStoryboardName:@"AutoLayoutViewController" identifier:@"AutoLayoutViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:{
            [self.navigationController pushViewController:[[NSClassFromString(@"UITextFieldViewController") alloc] init] animated:YES];
            break;
        }
        case 4:{
            [self.navigationController pushViewController:[[NSClassFromString(@"UIBezierPathViewController") alloc] init] animated:YES];
            break;
        }
        case 5:{
            [self.navigationController pushViewController:[[NSClassFromString(@"RuntimeViewController") alloc] init] animated:YES];
            break;
        }
        case 6:{
            [self.navigationController pushViewController:[[NSClassFromString(@"GCDViewController") alloc] init] animated:YES];
            break;
        }
        case 7:{
            [self.navigationController pushViewController:[[NSClassFromString(@"GradientViewController") alloc] init] animated:YES];
            break;
        }
        case 8:{
            [self.navigationController pushViewController:[[NSClassFromString(@"SQLiteManagerViewController") alloc] init] animated:YES];
            break;
        }
        case 9:{
            [self.navigationController pushViewController:[[NSClassFromString(@"FMDBViewController") alloc] init] animated:YES];
            break;
        }
        case 10:{
            [self.navigationController pushViewController:[[NSClassFromString(@"PerformanceViewController") alloc] init] animated:YES];
            break;
        }
        case 11:{
            SwiftViewController *vc = [[SwiftViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 12:{
            [self.navigationController pushViewController:[[NSClassFromString(@"PickerViewController") alloc] init] animated:YES];
            break;
        }
        case 13:{
            PhotoViewController *vc = [PhotoViewController __viewControllerWithStoryboardName:@"PhotoViewController" identifier:@"PhotoViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 14:{
            [self.navigationController pushViewController:[[NSClassFromString(@"TimerViewController") alloc] init] animated:YES];
            break;
        }
        case 15:{
            RecorderViewController *vc = [RecorderViewController __viewControllerWithStoryboardName:@"RecorderViewController" identifier:@"RecorderViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 16:{
            [self.navigationController pushViewController:[[NSClassFromString(@"BannerViewController") alloc] init] animated:YES];
            
            break;
        }
        case 17:{
            [self.navigationController pushViewController:[[NSClassFromString(@"TabViewController") alloc] init] animated:YES];
            
            break;
        }
        case 18:{
            [self.navigationController pushViewController:[[NSClassFromString(@"ImgeViewController") alloc] init] animated:YES];
            
            break;
        }
        case 19:{
            [self.navigationController pushViewController:[[NSClassFromString(@"Button2ViewController") alloc] init] animated:YES];
            
            break;
        }
        case 20:{
            [self.navigationController pushViewController:[[NSClassFromString(@"NSTimerViewController") alloc] init] animated:YES];
            
            break;
        }
        case 21:{
            [self.navigationController pushViewController:[[NSClassFromString(@"NavigationController") alloc] init] animated:YES];
            
            break;
        }
        case 22:{
            [self.navigationController pushViewController:[[NSClassFromString(@"FactoryPatternController") alloc] init] animated:YES];
            
            break;
        }
            
        default:
            break;
    }
}

- (void)initData{
    self.titles = @[
                    @"UILabelViewController",
                    @"UITableViewController",
                    @"AutoLayoutViewController",
                    @"UITextFieldViewController",
                    @"UIBezierPathViewController",
                    @"RuntimeViewController",
                    @"GCDViewController",
                    @"GradientViewController 渐变",
                    @"SQLiteManagerViewController",
                    @"FMDBViewController",
                    @"PerformanceViewController 性能优化",
                    @"SwiftViewController",
                    @"PickerViewController 省份城市pickerView",
                    @"PhotoViewController 相册",
                    @"TimerViewController",
                    @"RecorderViewController 录音功能",
                    @"BannerViewController 轮播图",
                    @"TabViewController",
                    @"ImgeViewController",
                    @"Button2ViewController 长按录音",
                    @"NSTimerViewController 倒计时",
                    @"NavigationController - 完美隐藏",
                    @"工厂模式"
                    ];
}

- (void)initRequest{
    
}

- (void)initUI{
    self.title = @"首页";
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(0, 0, __ScreenWidth, __ScreenHeight);
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"tableViewInCell" bundle:nil] forCellReuseIdentifier:@"tableViewInCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"tableViewInCell2" bundle:nil] forCellReuseIdentifier:@"tableViewInCell2"];
    
    
    [self.view addSubview:self.tableView];
}

@end







