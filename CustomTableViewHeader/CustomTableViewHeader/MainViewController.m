//
//  MainViewController.m
//  CustomTableViewHeader
//
//  Created by 谢鑫 on 2019/5/31.
//  Copyright © 2019 Shae. All rights reserved.
//

#import "MainViewController.h"
#import "HeaderView.h"
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)HeaderView *headerView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"自定义表头"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setTableView:[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain]];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self setHeaderView:[HeaderView headerView]];//类属性必须q申请内存和初始化
    [self.tableView setTableHeaderView:_headerView];
    [self.view addSubview:self.tableView];
}

#pragma mark - table view data source -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.textLabel.text=@"Text";
    return cell;
}

@end
