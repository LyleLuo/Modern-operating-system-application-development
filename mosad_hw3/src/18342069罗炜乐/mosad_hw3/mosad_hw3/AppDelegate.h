//
//  AppDelegate.h
//  mosad_hw3
//
//  Created by luowle on 2020/12/9.
//  Copyright © 2020 luowle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model/UserModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

+(void)setUserModel:(UserModel*)value;
+(UserModel*)getUserModel;
+(void)login:(NSString*)name withPassword:(NSString*) password withCallback:(void (^)(void))callback;
@end

