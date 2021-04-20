//
//  PKHViewController.m
//  PKHMediator
//
//  Created by 943147350@qq.com on 04/20/2021.
//  Copyright (c) 2021 943147350@qq.com. All rights reserved.
//

#import "PKHViewController.h"
#import "PKHMediator+ModuleA.h"

@interface PKHViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PKHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width - 20)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.tableFooterView = [UIView new];
    self.tableView.scrollEnabled = YES;
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", (long)indexPath.row];
        cell.contentView.backgroundColor = UIColor.whiteColor;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            UIViewController *controller =  [[PKHMediator shareMediator] createController:@"Hello 你好!" backColor:UIColor.systemRedColor];
            [self presentViewController:controller animated:YES completion:nil];
            
        }
            break;
        case 1:
        {
            [[PKHMediator shareMediator] showAlert:@"开个玩笑!" content:@"点我啊!" sureCallback:^{
                NSLog(@"不服就点我啊!!!");
            }];
        }
            break;
        default:
            break;
    }
}

@end
