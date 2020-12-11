//
//  Profile.m
//  mosad_hw3
//
//  Created by luowle on 2020/12/9.
//  Copyright © 2020 luowle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Profile.h"
#import "LogInViewController.h"
#import "ProfileViewController.h"

@interface ProfileController()

@end

@implementation ProfileController

- (instancetype)init {
    self = [super init];
    [self.tabBarItem setTitle:@"个人"];
    [self.tabBarItem setImage:[UIImage imageNamed:@"navigation-3.png"]];
    self.navigationBarHidden = YES;
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    ProfileViewController *profile = [ProfileViewController new];
    [self addChildViewController:profile];
    [self.view addSubview:profile.view];
}

@end
