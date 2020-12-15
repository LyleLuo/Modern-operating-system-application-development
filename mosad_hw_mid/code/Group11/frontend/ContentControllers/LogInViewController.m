//
//  LogInViewController.m
//  frontend
//
//  Created by luowle on 2020/11/17.
//  Copyright © 2020 sysu. All rights reserved.
//

#import "LogInViewController.h"
#import "../AppDelegate.h"

@interface LogInViewController ()
@property (nonatomic,strong) IBOutlet UILabel *logInHeader;
@property (nonatomic,strong) IBOutlet UITextField *emailField;
@property (nonatomic,strong) IBOutlet UITextField *passwordField;
@property (nonatomic,strong) IBOutlet UIButton *logInOrSignUpButton;
@property (nonatomic,strong) IBOutlet UILabel *switchLabel;

@property (nonatomic,strong) IBOutlet UILabel *signUpHeader;
@property (nonatomic,strong) IBOutlet UITextField *usernameField;
@property (nonatomic) bool isLogIn;
@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_passwordField setSecureTextEntry:YES];
    
    [_logInHeader setHidden:NO];
    [_signUpHeader setHidden:YES];
    [_usernameField setHidden:YES];
    [_logInOrSignUpButton setTitle:@"登录" forState:UIControlStateNormal];
    
    [_logInOrSignUpButton.layer setCornerRadius:7];
    
    [_switchLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(switchMode)];
    [_switchLabel addGestureRecognizer:gesture];
    _isLogIn = YES;
}



# pragma mark 登录/注册
- (IBAction)logInOrSignUp:(id)sender
{
    NSLog(@"%@", _isLogIn?@"YES":@"NO");
    if(_isLogIn)
    {
        [AppDelegate login:[_emailField text] withPassword:[_passwordField text] withCallback:^{
            [self.view removeFromSuperview];
            [self didMoveToParentViewController:self];
            ((UITableViewController*)[self parentViewController]).tabBarController.tabBar.hidden = NO;
            ((UITableViewController*)[self parentViewController]).navigationController.navigationBar.hidden = NO;
            [((UITableViewController*)[self parentViewController]).tableView reloadData];
            [((UITableViewController*)[self parentViewController]).tableView refreshControl];
            [self removeFromParentViewController];
        }];
    }
    else
    {
        [AppDelegate signup:[_usernameField text] withEmail:[_emailField text] withPassword:[_passwordField text] withCallback:^{
            [self.view removeFromSuperview];
            [self didMoveToParentViewController:self];
            ((UITableViewController*)[self parentViewController]).tabBarController.tabBar.hidden = NO;
            ((UITableViewController*)[self parentViewController]).navigationController.navigationBar.hidden = NO;
            [((UITableViewController*)[self parentViewController]).tableView reloadData];
            [((UITableViewController*)[self parentViewController]).tableView refreshControl];
            [self removeFromParentViewController];
        }];
    }
}

- (void)switchMode
{
    NSLog(@"%@", _isLogIn?@"YES":@"NO");
    if(_isLogIn)
    {
        [_logInHeader setHidden:YES];
        [_signUpHeader setHidden:NO];
        [_usernameField setHidden:NO];
        [_logInOrSignUpButton setTitle:@"注册" forState:UIControlStateNormal];
        [_switchLabel setText:@"已有账号"];
        [_emailField setText:@""];
        [_passwordField setText:@""];
        _isLogIn = NO;
    }
    else
    {
        [_logInHeader setHidden:NO];
        [_signUpHeader setHidden:YES];
        [_usernameField setHidden:YES];
        [_logInOrSignUpButton setTitle:@"登录" forState:UIControlStateNormal];
        [_switchLabel setText:@"注册账号"];
        [_emailField setText:@""];
        [_passwordField setText:@""];
        _isLogIn = YES;
    }
}
@end
