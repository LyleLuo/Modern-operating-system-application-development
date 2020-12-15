//
//  HomeNavigationController.m
//  frontend
//
//  Created by student13 on 2020/11/16.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeNavigationController.h"
#import "../ContentControllers/HomeController.h"

@interface HomeNavigationController()

@end

@implementation HomeNavigationController

- (instancetype)init {
    self = [super init];
    [self.tabBarItem setTitle:@"主页"];
    [self.tabBarItem setImage:[UIImage imageNamed: @"navigation-3.png"]]; //TODO: 添加标签的图片
    HomeController* home = [[HomeController alloc] init];
    [self addChildViewController:home];
    return self;
}

@end
