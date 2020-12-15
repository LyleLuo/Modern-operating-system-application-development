//
//  ReplyCellView.m
//  frontend
//
//  Created by student13 on 2020/12/4.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReplyCellView.h"

@interface ReplyCellView()
@property(nonatomic, strong) ReplyModel* model;
@property(nonatomic, strong) UIImageView* avatar;
@property(nonatomic, strong) UILabel* username;
@property(nonatomic, strong) UITextView* content;
@property(nonatomic, strong) UILabel* like;
@end

@implementation ReplyCellView

-(void)downloadResource:(NSString*)url withCallback:(void (^)(NSData* data))callback {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = url;
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [callback data];
        });
    }];
    [task resume];
}

-(void)loadAvatar:(UIImageView*)view withUrl:(NSString*)url {
    if ([url length] == 0) {
        view.image = [UIImage imageNamed:@"头像.png"];
        return;
    }
    [self downloadResource:url withCallback:^(NSData * data) {
        view.image = [[UIImage alloc] initWithData:data];
    }];
}

-(instancetype)initWithData:(ReplyModel*) data {
    if (self == nil) {
        self = [[ReplyCellView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 100)];
    }
    UIImageView* avatar = [self avatar];
    UILabel* username = [self username];
    UITextView* content = [self content];
    UILabel* like = [self like];
    
    [username setText:data.User.Name];
    [content setText:data.Reply.Content];
    [like setText:[NSString stringWithFormat:@"%ld 👍", data.Reply.LikeNum]];
    avatar.image = nil;
    [self loadAvatar:avatar withUrl:data.User.Avatar];
    self.model = data;
    return self;
}

- (UIImageView *)avatar {
    if (_avatar == nil) {
        _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [self addSubview:_avatar];
    }
    return _avatar;
}

- (UILabel *)username {
    if (_username == nil) {
        _username = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.bounds.size.width - 100, 40)];
        [self addSubview:_username];
    }
    return _username;
}

- (UITextView *)content {
    if (_content == nil) {
        _content = [[UITextView alloc] initWithFrame:CGRectMake(10, 40, self.bounds.size.width - 20, 50)];
        [_content setEditable:false];
        [self addSubview:_content];
    }
    return _content;
}

- (UILabel *)like {
    if (_like == nil) {
        _like = [[UILabel alloc] initWithFrame:CGRectMake([self bounds].size.width - 100, 0, 40, 40)];
        [self addSubview:_like];
    }
    return _like;
}

@end
