//
//  CommentCellView.m
//  frontend
//
//  Created by student13 on 2020/12/4.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentCellView.h"
#import "ReplyCellView.h"

@interface CommentCellView()

@property(nonatomic, strong) UIImageView* avatar;
@property(nonatomic, strong) UILabel* username;
@property(nonatomic, strong) UITextView* content;
@property(nonatomic, strong) UILabel* like;
@property(nonatomic, strong) CommentForContentModel* model;
@property(nonatomic, strong) UICollectionView* replies;

@end

@implementation CommentCellView

- (UICollectionView *)replies {
    if (_replies == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.bounds.size.width - 20, 100);
        _replies = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.bounds.size.width, 100) collectionViewLayout:flowLayout];
        [_replies setDataSource:self];
        [_replies setDelegate:self];
        [_replies setBackgroundColor:UIColor.clearColor];
        [_replies registerClass:[ReplyCellView class] forCellWithReuseIdentifier:@"reply"];
        [self addSubview:_replies];
    }
    return _replies;
}

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

-(instancetype)initWithData:(CommentForContentModel*) data {
    if (self == nil) {
        self = [super init];
    }
    UIImageView* avatar = [self avatar];
    UILabel* username = [self username];
    UITextView* content = [self content];
    UILabel* like = [self like];
    UICollectionView* replies = [self replies];
    
    [username setText:data.User.Name];
    [content setText:data.Comment.Content];
    [like setText:[NSString stringWithFormat:@"%ld 👍", data.Comment.LikeNum]];
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

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ReplyCellView *cell = [self.replies dequeueReusableCellWithReuseIdentifier:@"reply" forIndexPath:indexPath];
    cell = [cell initWithData:self.model.Replies[indexPath.row]];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.Replies.count;
}


@end
