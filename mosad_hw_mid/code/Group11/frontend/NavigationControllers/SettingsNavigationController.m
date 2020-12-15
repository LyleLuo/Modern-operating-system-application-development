//
//  SettingsNavigationController.m
//  frontend
//
//  Created by student13 on 2020/11/16.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsNavigationController.h"
#import "../ContentControllers/SettingsController.h"

@interface SettingsNavigationController()

@end

@implementation SettingsNavigationController

- (instancetype)init {
    self = [super init];
    [self.tabBarItem setTitle:@"设置"];
    [self.tabBarItem setImage:[UIImage imageNamed:@"setting.png"]];
    SettingsController* settings = [[SettingsController alloc] init];
    [self addChildViewController:settings];
    return self;
}

@end
