//
//  ItemCellView.m
//  frontend
//
//  Created by student13 on 2020/12/2.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemCellView.h"
#import "../AppDelegate.h"

@interface ItemCellView()

@property(nonatomic, strong) UIImageView* avatar;
@property(nonatomic, strong) UILabel* username;
@property(nonatomic, strong) UILabel* title;
@property(nonatomic, strong) UITextView* content;
@property(nonatomic, strong) UIButton* like;
@property(nonatomic, strong) UILabel* comment;
@property(nonatomic, strong) PublicItemModel* model;
@property(nonatomic, strong) UICollectionView* thumbs;
@property(nonatomic) NSInteger likeNum;

@end

@implementation ItemCellView

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

-(instancetype)initWithData:(PublicItemModel*) data {
    if (self == nil) {
        self = [super init];
    }
    UIImageView* avatar = [self avatar];
    UILabel* username = [self username];
    UILabel* title = [self title];
    UITextView* content = [self content];
    UIButton* like = [self like];
    UILabel* comment = [self comment];
    [self thumbs];
    
    [username setText:data.User.Name];
    [title setText:data.Data.Name];
    [content setText:data.Data.Detail];
    _likeNum = data.Data.LikeNum;
    [like setTitle:[NSString stringWithFormat:@"%ld 👍", data.Data.LikeNum] forState:UIControlStateNormal];
    [[self like] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [comment setText:[NSString stringWithFormat:@"%ld ✏️", data.Data.CommentNum]];
    avatar.image = nil;
    [self loadAvatar:avatar withUrl:data.User.Avatar];
    self.model = data;
    [self.thumbs refreshControl];
    [self.thumbs reloadData];
    return self;
}

- (UIImageView *)avatar {
    if (_avatar == nil) {
        _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self addSubview:_avatar];
    }
    return _avatar;
}

- (UILabel *)username {
    if (_username == nil) {
        _username = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, self.bounds.size.width - 100, 40)];
        [self addSubview:_username];
    }
    return _username;
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, self.bounds.size.width - 20, 40)];
        [self addSubview:_title];
    }
    return _title;
}

- (UITextView *)content {
    if (_content == nil) {
        _content = [[UITextView alloc] initWithFrame:CGRectMake(10, 90, self.bounds.size.width - 20, 100)];
        [_content setEditable:false];
        [self addSubview:_content];
    }
    return _content;
}

- (UIButton *)like {
    if (_like == nil) {
        _like = [[UIButton alloc] initWithFrame:CGRectMake([self bounds].size.width - 100, 200, 40, 40)];
        [_like addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_like];
    }
    return _like;
}

-(void)likeClick:(UIButton*)sender{
    _likeNum++;
    [self.like setTitle:[NSString stringWithFormat:@"%ld 👍", _likeNum] forState:UIControlStateNormal];
    [[self like] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [AppDelegate likeWithContent:_model.Data.Id isContent:@YES isComment:@NO isReply:@NO];
}

- (UILabel *)comment {
    if (_comment == nil) {
        _comment = [[UILabel alloc] initWithFrame:CGRectMake([self bounds].size.width - 50, 200, 40, 40)];
        [self addSubview:_comment];
    }
    return _comment;
}

- (UICollectionView *)thumbs {
    if (_thumbs == nil) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake((self.bounds.size.width - 180) / 3, 40)];
        [layout setMinimumLineSpacing:10];
        [layout setMinimumInteritemSpacing:10];
        _thumbs = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 200, self.bounds.size.width - 150, 40) collectionViewLayout:layout];
        [_thumbs setDelegate:self];
        [_thumbs setDataSource:self];
        [_thumbs setBackgroundColor:UIColor.clearColor];
        [self.thumbs registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"thumb"];
        [self addSubview:_thumbs];
    }
    return _thumbs;
}

-(void)loadThumb:(NSString*)url withView:(UIImageView*) view {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = url;
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            view.image = [[UIImage alloc] initWithData:data];
        });
    }];
    [task resume];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.thumbs dequeueReusableCellWithReuseIdentifier:@"thumb" forIndexPath:indexPath];
    for (int i = 0; i < cell.subviews.count; i++) {
        [cell.subviews[i] removeFromSuperview];
    }
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (self.bounds.size.width - 180) / 3, 40)];
    [cell addSubview:image];
    PublicContentImageModel *model = self.model.Data.Album.Images[indexPath.row];
    [self loadThumb:[[NSString alloc] initWithFormat:@"http://172.18.178.56/api/thumb/%@", model.Thumb] withView:image];
    
    // 高清大图：/api/file/self.model.Data.Album.Images[i].File.File
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.Data.Album.Images.count > 3 ? 3 : self.model.Data.Album.Images.count;
}

@end
