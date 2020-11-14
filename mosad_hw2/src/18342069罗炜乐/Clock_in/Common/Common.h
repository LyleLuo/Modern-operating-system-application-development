//
//  Common.h
//  Clock_in
//
//  Created by luowle on 2020/10/23.
//  Copyright © 2020 luowle. All rights reserved.
//

#ifndef Common_h
#define Common_h
#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define RECT_NAV_HEIGHT (self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height)
#define TABBAR_HEIGHT self.tabBarController.tabBar.bounds.size.height

#endif /* Common_h */
