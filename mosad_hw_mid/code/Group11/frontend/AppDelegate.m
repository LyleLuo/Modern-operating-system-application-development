//
//  AppDelegate.m
//  frontend
//
//  Created by student13 on 2020/11/16.
//  Copyright © 2020 sysu. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

UserModel* userModel;

@interface AppDelegate ()

@end

@implementation AppDelegate

+(void)getUserData:(void (^)(void))callback {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = [NSString stringWithFormat:@"http://172.18.178.56/api/user/info/self"];
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString* state = [dic objectForKey:@"State"];
        if (![state isEqualToString:@"success"]) {
            [AppDelegate setUserModel:nil];
            return;
        }
        UserModel *model = [[UserModel alloc] init];
        model.Id = [dic objectForKey:@"ID"];
        model.State = state;
        model.Email = [dic objectForKey:@"Email"];
        model.Name = [dic objectForKey:@"Name"];
        model.Class = [[dic objectForKey:@"Class"] integerValue];
        model.MaxSize = [[dic objectForKey:@"MaxSize"] integerValue];
        model.UsedSize = [[dic objectForKey:@"UsedSize"] integerValue];
        model.SingleSize = [[dic objectForKey:@"SingleSize"] integerValue];
        model.Info = [[UserInfo alloc] init];
        NSDictionary *infodic = [dic objectForKey:@"Info"];
        model.Info.Name = [infodic objectForKey:@"Name"];
        model.Info.Avatar = [infodic objectForKey:@"Avatar"];
        model.Info.Bio = [infodic objectForKey:@"Bio"];
        model.Info.Gender = [[infodic objectForKey:@"Gender"] integerValue];
        
        [AppDelegate setUserModel:model];
        dispatch_async(dispatch_get_main_queue(), callback);
        
    }];
    [task resume];
}


+(void)logout:(void (^)(void))callback {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = [NSString stringWithFormat:@"http://172.18.178.56/api/user/logout"];
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [AppDelegate setUserModel:nil];
        dispatch_async(dispatch_get_main_queue(), callback);
    }];
    [task resume];
}

+(void)login:(NSString*)name withPassword:(NSString*) password withCallback:(void (^)(void))callback {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = [NSString stringWithFormat:@"http://172.18.178.56/api/user/login/pass"];
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    [data setObject:name forKey:@"name"];
    [data setObject:password forKey:@"password"];
    NSData* json = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingSortedKeys error:nil];
    [request setHTTPBody:json];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [AppDelegate getUserData:callback];
    }];
    [task resume];
}

+(void)signup:(NSString*)name withEmail:(NSString*)email withPassword:(NSString*) password withCallback:(void (^)(void))callback {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = [NSString stringWithFormat:@"http://172.18.178.56/api/user/register"];
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    [data setObject:name forKey:@"name"];
    [data setObject:email forKey:@"email"];
    [data setObject:password forKey:@"password"];
    NSData* json = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingSortedKeys error:nil];
    [request setHTTPBody:json];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self login:email withPassword:password withCallback:callback];
    }];
    [task resume];
}

+(void)updateName:(NSString*)name withCallback:(void (^)(void))callback {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = [NSString stringWithFormat:@"http://172.18.178.56/api/user/name"];
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    [data setObject:name forKey:@"name"];
    NSData* json = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingSortedKeys error:nil];
    [request setHTTPBody:json];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
        [self getUserData:callback];
    }];
    [task resume];
}

+(void)likeWithContent:(NSString*)contentID isContent:(NSObject*)isContent isComment:(NSObject*)isComment isReply:(NSObject*)isReply {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = [NSString stringWithFormat:@"http://172.18.178.56/api/like/%@", contentID];
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    [data setObject:isContent forKey:@"isContent"];
    [data setObject:isComment forKey:@"isComment"];
    [data setObject:isReply forKey:@"isReply"];
    NSData* json = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingSortedKeys error:nil];
    [request setHTTPBody:json];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
        // [self getUserData:callback];
    }];
    [task resume];
}

+(UserModel*)getUserModel {
    return userModel;
}

+(void)setUserModel:(UserModel*)value {
    userModel = value;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    ViewController *viewController = [[ViewController alloc] init];
    [self.window setRootViewController:viewController];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    [AppDelegate getUserData:^{
        
    }];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
