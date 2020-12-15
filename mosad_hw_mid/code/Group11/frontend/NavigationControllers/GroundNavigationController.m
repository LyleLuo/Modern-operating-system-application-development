//
//  GroundNavigationController.m
//  frontend
//
//  Created by student13 on 2020/11/16.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroundNavigationController.h"
#import "../ContentControllers/GroundListController.h"

@interface GroundNavigationController()

@end

@implementation GroundNavigationController

- (instancetype)init {
    self = [super init];
    [self.tabBarItem setTitle:@"广场"];
    [self.tabBarItem setImage:[UIImage imageNamed:@"browse-3.png"]]; //TODO: 添加标签的图片
    GroundListController* ground = [[GroundListController alloc] init];
    [self addChildViewController:ground];
    return self;
}

@end
