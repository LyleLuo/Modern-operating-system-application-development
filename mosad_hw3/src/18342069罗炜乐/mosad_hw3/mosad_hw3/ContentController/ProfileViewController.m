//
//  ProfileViewController.m
//  mosad_hw3
//
//  Created by luowle on 2020/12/10.
//  Copyright © 2020 luowle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileViewController.h"
#import "LogInViewController.h"

@implementation ProfileViewController

- (instancetype)init {
    // UITableViewController 的默认初始化方法是 initWithStyle:
    if(self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.tableView.scrollEnabled = NO;
        self.tableView.backgroundColor = [UIColor whiteColor];
        int w = self.view.bounds.size.width;
        int h = self.view.bounds.size.height;
        UIImageView *avaturView = [[UIImageView alloc]initWithFrame:CGRectMake(w/2 - 80, h/2 - 400, 160, 160)];
        avaturView.image = [[[UIImage alloc] init] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        avaturView.layer.cornerRadius = 80;
        avaturView.layer.masksToBounds = YES;
        avaturView.layer.borderWidth = 2;
        avaturView.layer.borderColor = [UIColor grayColor].CGColor;
        avaturView.image = [UIImage imageNamed:@"头像.png"];
        [self.view addSubview:avaturView];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    if ([AppDelegate getUserModel] == nil) {
        LogInViewController *loginvc = [LogInViewController new];
        [self addChildViewController:loginvc];
        [self.view addSubview:loginvc.view];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 返回每个 Section 中的 Cell 个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"姓名";
            cell.detailTextLabel.text = [AppDelegate getUserModel].name;
            break;
        case 1:
            cell.textLabel.text = @"邮箱";
            cell.detailTextLabel.text = [AppDelegate getUserModel].email;
            break;
        case 2:
            cell.textLabel.text = @"级别";
            cell.detailTextLabel.text = [AppDelegate getUserModel].level;
            break;
        case 3:
            cell.textLabel.text = @"电话";
            cell.detailTextLabel.text = [AppDelegate getUserModel].phone;
            break;
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"个人信息";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 250;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger i = 4 * indexPath.section + indexPath.row;
    switch (i) {
        default:
            break;
    }
}

@end
