//
//  main.m
//  SanGuo
//
//  Created by luowle on 2020/10/4.
//  Copyright © 2020 luowle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "pk.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    pk(6);
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
