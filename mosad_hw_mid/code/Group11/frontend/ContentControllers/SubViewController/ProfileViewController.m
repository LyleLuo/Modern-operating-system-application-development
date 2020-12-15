//
//  ProfileViewController.m
//  frontend
//
//  Created by luowle on 2020/11/17.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileViewController.h"
#import "../../AppDelegate.h"

@interface ProfileViewController()

@end

@implementation ProfileViewController

-(void)downloadResource:(NSString*)url withCallback:(void (^)(NSData* data))callback {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = url;
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [callback data];
        });
    }];
    [task resume];
}

- (void)getAvatarData:(NSString*)url withImage:(UIImageView*) view {
    if ([url length] == 0) {
        view.image = [UIImage imageNamed:@"头像.png"];
        return;
    }
    [self downloadResource:url withCallback:^(NSData * data) {
        view.image = [[UIImage alloc] initWithData:data];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:@"个人信息与成就"];
    
    int w = self.view.bounds.size.width;
    int h = self.view.bounds.size.height;
    UIImageView *avaturView = [[UIImageView alloc]initWithFrame:CGRectMake(w/2 - 80, h/2 - 335, 160, 160)];
    avaturView.image = [[[UIImage alloc] init] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    avaturView.layer.cornerRadius = 80;
    avaturView.layer.masksToBounds = YES;
    avaturView.layer.borderWidth = 2;
    avaturView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:avaturView];
    
    if (_info == nil) _info = [[UITableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    _info.tableView.dataSource = self;
    _info.tableView.delegate = self;
    _info.view.frame = CGRectMake(0, h/2-150, w, h/2 + 100);
    [self.view addSubview:_info.view];
    [self getAvatarData:[AppDelegate getUserModel].Info.Avatar withImage:avaturView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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
    switch(indexPath.section)
    {
        case 0:
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"姓名";
                    cell.detailTextLabel.text = [AppDelegate getUserModel].Name;
                    break;
                case 1:
                    cell.textLabel.text = @"邮箱";
                    cell.detailTextLabel.text = [AppDelegate getUserModel].Email;
                    break;
                case 2:
                    cell.textLabel.text = @"简介";
                    cell.detailTextLabel.text = [AppDelegate getUserModel].Info.Bio;
                    break;
                case 3:
                    cell.textLabel.text = @"性别";
                    cell.detailTextLabel.text = [AppDelegate getUserModel].Info.Gender == 0 ? @"男" : @"女";
                    break;
                
            }
            break;
        case 1:
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"版本";
                    cell.detailTextLabel.text = @"V0.1";
                    break;
                case 1:
                    cell.textLabel.text = @"隐私和cookie";
                    break;
                case 2:
                    cell.textLabel.text = @"清除缓存";
                    break;
                case 3:
                    cell.textLabel.text = @"同步";
                    break;
            }
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0)return @"个人信息";
    else return @"关于";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 1)return 20;
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger i = 4 * indexPath.section + indexPath.row;
    switch (i) {
        case 0:
            [self Click:@"更改姓名"];
            break;
        case 1:
            [self Alert:@"不可更改"];
            break;
        case 2:
            [self Alert:@"不可更改"];
            break;
        case 3:
            [self Alert:@"不可更改"];
            break;
        case 7:
            [self Alert:@"本应用不使用cookie"];
            break;
        case 6:
            [self Alert:@"已清除缓存"];
        case 5:
            [self Alert:@"已同步"];
        case 4:
            [self Alert:@"该版本为最新版本"];
        default:
            break;
    }
}

- (void)Alert:(NSString *)msg {
     UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"搜索结果" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:NO completion:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {NSLog(@"点击了确认按钮");}]];
}



- (void)Click:(NSString *)msg {
  
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
  //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *userNameTextField = alertController.textFields.firstObject;
        NSLog(@"%@",userNameTextField.text);
        [AppDelegate updateName:userNameTextField.text withCallback:^{
            [self.info.tableView reloadData];
            [self.info.tableView refreshControl];
            [self.father.tableView reloadData];
            [self.father.tableView refreshControl];
        }];
    }]];

    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];

    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入新姓名";
    }];
  
  [self presentViewController:alertController animated:true completion:nil];
  
}

@end




