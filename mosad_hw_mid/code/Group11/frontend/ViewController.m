//
//  ViewController.m
//  frontend
//
//  Created by student13 on 2020/11/16.
//  Copyright © 2020 sysu. All rights reserved.
//

#import "ViewController.h"
#import "NavigationControllers/HomeNavigationController.h"
#import "NavigationControllers/GroundNavigationController.h"
#import "NavigationControllers/SettingsNavigationController.h"

@interface ViewController ()

@property (nonatomic, strong) HomeNavigationController* home;
@property (nonatomic, strong) GroundNavigationController* ground;
@property (nonatomic, strong) SettingsNavigationController* settings;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:[self ground]];
    [self addChildViewController:[self home]];
    [self addChildViewController:[self settings]];
}


- (HomeNavigationController *)home {
    if (_home == nil) {
        _home = [[HomeNavigationController alloc] init];
    }
    return _home;
}

- (GroundNavigationController *)ground {
    if (_ground == nil) {
        _ground = [[GroundNavigationController alloc] init];
    }
    return _ground;
}

- (SettingsNavigationController *)settings {
    if (_settings == nil) {
        _settings = [[SettingsNavigationController alloc] init];
    }
    return _settings;
}

@end
