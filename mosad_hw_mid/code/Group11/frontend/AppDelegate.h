//
//  AppDelegate.h
//  frontend
//
//  Created by student13 on 2020/11/16.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Models/UserModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(UserModel*)getUserModel;
+(void)setUserModel:(UserModel*)value;
+(void)login:(NSString*)name withPassword:(NSString*) password withCallback:(void (^)(void))callback;
+(void)logout:(void (^)(void))callback;
+(void)signup:(NSString*)name withEmail:(NSString*)email withPassword:(NSString*) password withCallback:(void (^)(void))callback;
+(void)updateName:(NSString*)name withCallback:(void (^)(void))callback;
+(void)likeWithContent:(NSString*)contentID isContent:(NSObject*)isContent isComment:(NSObject*)isComment isReply:(NSObject*)isReply;
@end

