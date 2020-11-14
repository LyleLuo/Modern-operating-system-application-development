//
//  RootTabBarController.m
//  Clock_in
//
//  Created by luowle on 2020/10/23.
//  Copyright © 2020 luowle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootController.h"

@implementation RootTabBarController

-(id) init {
    self = [super init];
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    Find *find = [Find new];
    ClockIn *clockIn = [ClockIn new];
    Home *home = [Home new];
    
    find.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"发现"
                                         image:[[UIImage imageNamed:@"编辑灰色.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]
                                         selectedImage:[[UIImage imageNamed:@"编辑.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
    clockIn.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"打卡"
                                         image:[[UIImage imageNamed:@"增加灰色.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]
                                         selectedImage:[[UIImage imageNamed:@"增加.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
    home.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的"
                                         image:[[UIImage imageNamed:@"我的灰色.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]
                                         selectedImage:[[UIImage imageNamed:@"我的.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ]];
    [self addChildViewController:find];
    [self addChildViewController:clockIn];
    [self addChildViewController:home];
    clockIn.delegae = find;
}
@end


