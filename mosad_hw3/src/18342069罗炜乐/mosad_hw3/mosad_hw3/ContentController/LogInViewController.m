//
//  LogInViewController.m
//  frontend
//
//  Created by luowle on 2020/11/17.
//  Copyright © 2020 sysu. All rights reserved.
//

#import "LogInViewController.h"
#import "AppDelegate.h"

@interface LogInViewController ()
@property (nonatomic,strong) IBOutlet UILabel *logInHeader;
@property (nonatomic,strong) IBOutlet UITextField *emailField;
@property (nonatomic,strong) IBOutlet UITextField *passwordField;
@property (nonatomic,strong) IBOutlet UIButton *logInOrSignUpButton;
@property (nonatomic, strong) UITableViewController *info;
@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_passwordField setSecureTextEntry:YES];
    
    [_logInHeader setHidden:NO];
    [_logInOrSignUpButton setTitle:@"登录" forState:UIControlStateNormal];
    
    [_logInOrSignUpButton.layer setCornerRadius:7];
}



# pragma mark 登录/注册
- (IBAction)logInOrSignUp:(id)sender {
    [AppDelegate login:[_emailField text] withPassword:[_passwordField text] withCallback:^{
        if ([AppDelegate getUserModel] == nil) {
            [self Alert:@"用户名或密码错误"];
        }
        else {
            UITableViewController *parent = (UITableViewController*)[self parentViewController];
            [self.view removeFromSuperview];
            [self didMoveToParentViewController:self];
            [self removeFromParentViewController];
            [parent.tableView reloadData];
            [parent.tableView refreshControl];
        }

    }];
}

- (void)Alert:(NSString *)msg {
     UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"登录失败" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:NO completion:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction*action) {NSLog(@"点击了确认按钮");}]];
}
@end
