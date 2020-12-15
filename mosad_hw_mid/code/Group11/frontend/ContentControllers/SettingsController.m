//
//  SettingsController.m
//  frontend
//
//  Created by student13 on 2020/11/16.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsController.h"
#import "SubViewController/ProfileViewController.h"
#import "SubViewController/NotificationViewController.h"
#import "SubViewController/StorageController.h"
#import "SubViewController/PersonaliseController.h"
#import "SubViewController/NotificationViewController.h"
#import "../AppDelegate.h"
#import "LogInViewController.h"

@interface SettingsController ()
@property(nonatomic, strong) ProfileViewController *profile;
@property(nonatomic, strong) NotificationViewController * notification;
@property(nonatomic, strong) StorageController *storage;
@property(nonatomic, strong) PersonaliseController *personalise;

@end

@implementation SettingsController

- (instancetype)init
{
    // UITableViewController 的默认初始化方法是 initWithStyle:
    if(self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.scrollEnabled = NO;
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:@"设置中心"];
    
}

- (void)setAvatar:(UIImageView*)view withData:(NSData*) data {
    view.image = [[UIImage alloc] initWithData:data];
}

- (void)getAvatarData:(NSString*)url withImage:(UIImageView*) view {
    if ([url length] == 0) {
        view.image = [UIImage imageNamed:@"头像.png"];
        return;
    }
    NSURLSession * session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(),^{[self setAvatar:view withData:data];});
    }];
    [task resume];
}


#pragma mark - UITableViewDataSource
// 返回 section 的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else {
        if ([AppDelegate getUserModel] != nil) {
            return 5;
        }
        else {
            return 1;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }
    else {
        return 50;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    static NSString *identifer=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    if (indexPath.section == 0) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userinfo"];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
        [self getAvatarData:[AppDelegate getUserModel].Info.Avatar withImage:imageView];
        [cell.contentView addSubview:imageView];
         
        UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 0, 60, 80)];
        nameLabel.text = [AppDelegate getUserModel].Name;
        [cell.contentView addSubview:nameLabel];

    }
    else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if ([AppDelegate getUserModel] != nil) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"个人信息与成就";
                    cell.imageView.image = [UIImage imageNamed:@"user.png"];
                    break;
                case 1:
                    cell.textLabel.text = @"查看通知";
                    cell.imageView.image = [UIImage imageNamed:@"notification.png"];
                    break;
                case 2:
                    cell.textLabel.text = @"存储额度";
                    cell.imageView.image = [UIImage imageNamed:@"chart-bar.png"];
                    break;
                case 3:
                    cell.textLabel.text = @"个性化";
                    cell.imageView.image = [UIImage imageNamed:@"smile-filling.png"];
                    break;
                case 4:
                    cell.textLabel.text = @"退出登录";
                    cell.imageView.image = [UIImage imageNamed:@"minus.png"];
                    break;
                default:
                    break;
            }
        } else {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"登录/注册";
                    cell.imageView.image = [UIImage imageNamed:@"user.png"];
                    break;
                default:
                    break;
            }
        }
    }

    return cell;
}

- (void)login {
    [AppDelegate login:@"test@test.com" withPassword:@"test" withCallback:^{
        [self.tableView reloadData];
        [self.tableView refreshControl];
    }];
}

- (void)logout {
    [AppDelegate logout:^{
        [self.tableView reloadData];
        [self.tableView refreshControl];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([AppDelegate getUserModel] != nil){
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:[self profile] animated:YES];
                [_profile.info.tableView reloadData];
                [_profile.info.tableView refreshControl];
                break;
            case 1:
                [self.navigationController pushViewController:[self notification] animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController:[self storage] animated:YES];
                break;
            case 3:
                [self.navigationController pushViewController:[self personalise] animated:YES];
                break;
            case 4:
                [self logout];
                break;
            default:
                break;
        }
    }
    else {
            LogInViewController *loginvc = [LogInViewController new];
            self.tabBarController.tabBar.hidden = YES;
            self.navigationController.navigationBar.hidden = YES;
            [self addChildViewController:loginvc];
            [self.view addSubview:loginvc.view];
    }
}

- (ProfileViewController *)profile {
    if (_profile == nil) {
        _profile = [ProfileViewController new];
        _profile.father = self;
    }
    return _profile;
}

- (NotificationViewController *)notification {
    if (_notification == nil) {
        _notification = [NotificationViewController new];
    }
    return _notification;
}

- (StorageController *)storage {
    if (_storage == nil) {
        _storage = [StorageController new];
        _storage.usedStorage = 304.8;
    }
    return _storage;
}

- (PersonaliseController *)personalise {
    if (_personalise == nil) {
        _personalise = [PersonaliseController new];
    }
    return _personalise;
}

+ (NSString*) getName {
    return [AppDelegate getUserModel].Name;
}

@end


