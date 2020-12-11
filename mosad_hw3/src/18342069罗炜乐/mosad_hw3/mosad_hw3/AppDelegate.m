//
//  AppDelegate.m
//  mosad_hw3
//
//  Created by luowle on 2020/12/9.
//  Copyright © 2020 luowle. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

UserModel* userModel;

@interface AppDelegate()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    ViewController *viewController = [[ViewController alloc] init];
    [self.window setRootViewController:viewController];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    return YES;
}

+(void)setUserModel:(UserModel*)value {
    userModel = value;
}

+(UserModel*)getUserModel {
    return userModel;
}


+(void)login:(NSString*)name withPassword:(NSString*) password withCallback:(void (^)(void))callback {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = [NSString stringWithFormat:@"http://luowle.imdo.co:25101/hw3/signup"];
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    [data setObject:name forKey:@"name"];
    [data setObject:password forKey:@"pwd"];
    NSData* json = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingSortedKeys error:nil];
    [request setHTTPBody:json];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString* state = [dic objectForKey:@"msg"];
        if (![state isEqualToString:@"success"]) {
            [AppDelegate setUserModel:nil];
            NSLog(@"login fail");
            dispatch_async(dispatch_get_main_queue(), callback);
            return;
        }
        NSLog(@"login success");
        [AppDelegate getUserData:callback withName:name];
    }];
    [task resume];
}

+(void)getUserData:(void (^)(void))callback withName:(NSString*)name {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = [NSString stringWithFormat:@"http://luowle.imdo.co:25101/hw3/getinfo?name=%@", name];
    NSLog(@"%@", urlString);
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
        UserModel *model = [[UserModel alloc] init];
        
        model.email = [dic objectForKey:@"email"];
        model.name = [dic objectForKey:@"name"];
        model.level = [dic objectForKey:@"level"];
        model.phone = [dic objectForKey:@"phone"];
        
        [AppDelegate setUserModel:model];
        dispatch_async(dispatch_get_main_queue(), callback);
        
    }];
    [task resume];
}


@end
