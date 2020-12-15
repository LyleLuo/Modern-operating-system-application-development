//
//  DetailViewController.m
//  frontend
//
//  Created by student13 on 2020/12/4.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailViewController.h"
#import "../Views/CommentCellView.h"
#import "../AppDelegate.h"
#import "../ContentControllers/SupportView/BigImage.h"

@interface CommentController()

@property(nonatomic, strong) PublicItemModel* model;
@property(nonatomic, strong) UICollectionView* comments;
@property(nonatomic, strong) NSMutableArray* commentItems;

@end

@implementation CommentController

- (NSMutableArray *)commentItems {
    if (_commentItems == nil) {
        _commentItems = [[NSMutableArray alloc] init];
    }
    return _commentItems;
}

-(void)reloadComments {
    [self.comments refreshControl];
    [self.comments reloadData];
}

-(void)fetchComments {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = [NSString stringWithFormat:@"http://172.18.178.56/api/comment/%@", self.model.Data.Id];
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString* state = [dic objectForKey:@"State"];
        [self.commentItems removeAllObjects];
        if (![state isEqualToString:@"success"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadComments];
            });
            return;
        }
        
        NSArray* commentData = [dic objectForKey:@"Data"];
        
        if (commentData != nil && ![[NSNull null] isEqual:commentData]) {
            for (int i = 0; i < commentData.count; i++) {
                NSDictionary *comment = [commentData[i] objectForKey:@"Comment"];
                NSDictionary *user = [commentData[i] objectForKey:@"User"];
                NSArray *replies = [commentData[i] objectForKey:@"Replies"];
                CommentForContentModel *model = [[CommentForContentModel alloc] init];
                model.Comment = [[CommentModel alloc] init];
                model.User = [[PublicItemUserModel alloc] init];
                model.Replies = [[NSMutableArray alloc] init];
                model.Comment.ContentId = [comment objectForKey:@"ContentID"];
                model.Comment.Content = [comment objectForKey:@"Content"];
                model.Comment.Date = [[NSDate alloc] initWithTimeIntervalSince1970:[[comment objectForKey:@"Date"] integerValue]];
                model.Comment.FatherId = [comment objectForKey:@"FatherID"];
                model.Comment.Id = [comment objectForKey:@"ID"];
                model.Comment.LikeNum = [[comment objectForKey:@"LikeNum"] integerValue];
                model.Comment.UserId = [comment objectForKey:@"UserID"];
                model.User.Avatar = [user objectForKey:@"Avatar"];
                model.User.Gender = [[user objectForKey:@"Gender"] integerValue];
                model.User.Name = [user objectForKey:@"Name"];
                if (replies != nil && ![[NSNull null] isEqual:replies]) {
                    for (int j = 0; j < replies.count; j++) {
                        NSDictionary *reply = replies[j];
                        ReplyModel *replyModel = [[ReplyModel alloc] init];
                        replyModel.User = [[PublicItemUserModel alloc] init];
                        replyModel.User.Avatar = [[reply objectForKey:@"User"] objectForKey:@"Avatar"];
                        replyModel.User.Name = [[reply objectForKey:@"User"] objectForKey:@"Name"];
                        replyModel.User.Gender = [[[reply objectForKey:@"User"] objectForKey:@"Gender"] integerValue];
                        replyModel.Father = [[PublicItemUserModel alloc] init];
                        replyModel.Father.Avatar = [[reply objectForKey:@"Father"] objectForKey:@"Avatar"];
                        replyModel.Father.Name = [[reply objectForKey:@"Father"] objectForKey:@"Name"];
                        replyModel.Father.Gender = [[[reply objectForKey:@"Father"] objectForKey:@"Gender"] integerValue];
                        replyModel.Reply = [[CommentModel alloc] init];
                        replyModel.Reply.ContentId = [[reply objectForKey:@"Reply"] objectForKey:@"ContentID"];
                        replyModel.Reply.Content = [[reply objectForKey:@"Reply"] objectForKey:@"Content"];
                        replyModel.Reply.Date = [[NSDate alloc] initWithTimeIntervalSince1970:[[[reply objectForKey:@"Reply"] objectForKey:@"Date"] integerValue]];
                        replyModel.Reply.FatherId = [[reply objectForKey:@"Reply"] objectForKey:@"FatherID"];
                        replyModel.Reply.Id = [[reply objectForKey:@"Reply"] objectForKey:@"ID"];
                        replyModel.Reply.LikeNum = [[[reply objectForKey:@"Reply"] objectForKey:@"LikeNum"] integerValue];
                        replyModel.Reply.UserId = [[reply objectForKey:@"Reply"] objectForKey:@"UserID"];
                        [model.Replies addObject:replyModel];
                    }
                }
                [self.commentItems addObject:model];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadComments];
        });
        
    }];
    [task resume];
}

-(instancetype)initWithData:(PublicItemModel*)model {
    if (self == nil) {
        self = [super init];
    }
    self.model = model;
    [self comments];
    [self fetchComments];
    return self;
}

- (UICollectionView *)comments {
    if (_comments == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.bounds.size.width - 20, 200);
        _comments = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:flowLayout];
        [_comments setDelegate:self];
        [_comments setDataSource:self];
        [_comments setBackgroundColor:UIColor.clearColor];
        [self.comments registerClass:[CommentCellView class] forCellWithReuseIdentifier:@"comment"];
        [self addSubview:_comments];
    }
    return _comments;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CommentCellView *cell = [self.comments dequeueReusableCellWithReuseIdentifier:@"comment" forIndexPath:indexPath];
    cell = [cell initWithData:self.commentItems[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.commentItems.count;
}

@end

@interface DetailViewController()

@property(nonatomic, strong) PublicItemModel* model;

@property(nonatomic, strong) UIImageView* avatar;
@property(nonatomic, strong) UILabel* username;
@property(nonatomic, strong) UILabel* contentTitle;
@property(nonatomic, strong) UITextView* content;
@property(nonatomic, strong) UIButton* like;
@property(nonatomic, strong) UICollectionView* images;
@property(nonatomic, strong) CommentController* comment;
@property(nonatomic, strong) UIButton *addNew;
@property(nonatomic, strong) BigImage *bigImage;
@property(nonatomic) NSInteger likeNum;
@property(nonatomic, strong) UIButton* delete;

@end

@implementation DetailViewController

- (void)deleteContent:(id)sender {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://172.18.178.56/api/content/%@", self.model.Data.Id];
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"DELETE"];
    NSURLSessionTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString* state = [dic objectForKey:@"State"];
        if (![state isEqualToString:@"success"]) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:true];
        });
    }];
    [task resume];
}

- (UIButton *)delete {
    if (_delete == nil) {
        _delete = [[UIButton alloc] initWithFrame:CGRectMake([self.view bounds].size.width - 200, 10, 70, 40)];
        [_delete setTitle:@"删除" forState:UIControlStateNormal];
        [_delete setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
        [_delete addTarget:self action:@selector(deleteContent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_delete];
    }
    return _delete;
}


- (UIButton *)addNew {
    if (_addNew == nil) {
        _addNew = [[UIButton alloc] initWithFrame:CGRectMake([self.view bounds].size.width - 150, 10, 70, 40)];
        //[_like.layer setBorderWidth:1];
        [_addNew setShowsTouchWhenHighlighted:YES];
        [_addNew addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_addNew];
    }
    return _addNew;
}

- (void)addItem:(UIButton*)btn  {
    NSLog(@"clicked!");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"评论" message:@"添加评论" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *commentTextField = alertController.textFields.firstObject;
        NSLog(@"%@",commentTextField.text);
        NSURLSession * session = [NSURLSession sharedSession];
        NSString *urlString = [NSString stringWithFormat:@"http://172.18.178.56/api/comment"];
        urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
        [data setObject:@NO forKey:@"isReply"];
        [data setObject:self.model.Data.Id forKey:@"contentId"];
        [data setObject:self.model.Data.OwnId forKey:@"fatherId"];
        [data setObject:commentTextField.text forKey:@"content"];
        NSData* json = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingSortedKeys error:nil];
        [request setHTTPBody:json];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", str);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:true];
            });
        }];
        [task resume];
    }]];

    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];

    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入评论";
    }];
  
  [self presentViewController:alertController animated:true completion:nil];
}


- (CommentController *)comment {
    if (_comment == nil) {
        _comment = [[CommentController alloc] init];
        [self.view addSubview:_comment];
    }
    [_comment setFrame:CGRectMake(40, (self.model.Data.Album.Images.count / 3 + (self.model.Data.Album.Images.count % 3 == 0 ? 0 : 1)) * 50 + 200, self.view.bounds.size.width - 20, self.view.bounds.size.height - 370 - (self.model.Data.Album.Images.count / 3 + (self.model.Data.Album.Images.count % 3 == 0 ? 0 : 1)) * 50)];
    _comment = [_comment initWithData:self.model];
    return _comment;
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

-(instancetype)initWithData:(PublicItemModel*) data withCanDelete:(Boolean)canDelete {
    if (self == nil) {
        self = [super init];
    }
    self.model = data;
    UIImageView* avatar = [self avatar];
    UILabel* username = [self username];
    UILabel* contentTitle = [self contentTitle];
    UITextView* content = [self content];
    UIButton* like = [self like];
    [self images];
    [self comment];
    UIButton* addNew = [self addNew];
    [addNew setTitle:@"评论" forState:UIControlStateNormal];
    [[self addNew] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [username setText:data.User.Name];
    [contentTitle setText:data.Data.Name];
    [content setText:data.Data.Detail];
    _likeNum = data.Data.LikeNum;
    [like setTitle:[NSString stringWithFormat:@"%ld 👍", _likeNum] forState:UIControlStateNormal];
    [[self like] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    avatar.image = nil;
    [self loadAvatar:avatar withUrl:data.User.Avatar];
    [self.images refreshControl];
    [self.images reloadData];
    [self.navigationItem setTitle:@"详情"];
    if (!canDelete) {
        if (self.delete != nil) [self.delete removeFromSuperview];
    }
    else {
        [self delete];
    }
    return self;
}

- (UIImageView *)avatar {
    if (_avatar == nil) {
        _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self.view addSubview:_avatar];
    }
    return _avatar;
}

- (UILabel *)username {
    if (_username == nil) {
        _username = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, self.view.bounds.size.width - 100, 40)];
        [self.view addSubview:_username];
    }
    return _username;
}

- (UILabel *)contentTitle {
    if (_contentTitle == nil) {
        _contentTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, self.view.bounds.size.width - 20, 40)];
        [self.view addSubview:_contentTitle];
    }
    return _contentTitle;
}

- (UITextView *)content {
    if (_content == nil) {
        _content = [[UITextView alloc] initWithFrame:CGRectMake(10, 90, self.view.bounds.size.width - 20, 100)];
        [_content setEditable:false];
        [self.view addSubview:_content];
    }
    return _content;
}

- (UIButton *)like {
    if (_like == nil) {
        _like = [[UIButton alloc] initWithFrame:CGRectMake([self.view bounds].size.width - 100, 10, 70, 40)];
        //[_like.layer setBorderWidth:1];
        [_like setShowsTouchWhenHighlighted:YES];
        [_like addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_like];
    }
    return _like;
}

-(void)likeClick:(UIButton*)sender{
    _likeNum++;
    [[self like] setTitle:[NSString stringWithFormat:@"%ld 👍", _likeNum] forState:UIControlStateNormal];
    [[self like] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [AppDelegate likeWithContent:_model.Data.Id isContent:@YES isComment:@NO isReply:@NO];
    NSLog(@"Button%ld", _likeNum);
}

- (UICollectionView *)images {
    if (_images == nil) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake((self.view.bounds.size.width - 180) / 3, 40)];
        [layout setMinimumLineSpacing:10];
        [layout setMinimumInteritemSpacing:10];
        _images = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 200, self.view.bounds.size.width - 150, (self.model.Data.Album.Images.count / 3 + (self.model.Data.Album.Images.count % 3 == 0 ? 0 : 1)) * 50) collectionViewLayout:layout];
        [_images setDelegate:self];
        [_images setDataSource:self];
        [_images setBackgroundColor:UIColor.clearColor];
        [self.images registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"image"];
        [self.view addSubview:_images];
    }
    return _images;
}

-(void)loadImage:(NSString*)url withView:(UIImageView*) view {
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
    UICollectionViewCell *cell = [self.images dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
    for (int i = 0; i < cell.subviews.count; i++) {
        [cell.subviews[i] removeFromSuperview];
    }
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (self.view.bounds.size.width - 180) / 3, 40)];
    [cell addSubview:image];
    PublicContentImageModel *model = self.model.Data.Album.Images[indexPath.row];
    [self loadImage:[[NSString alloc] initWithFormat:@"http://172.18.178.56/api/thumb/%@", model.Thumb] withView:image];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.Data.Album.Images.count;
}

- (BigImage *)bigImage {
    if (_bigImage == nil) {
        _bigImage = [[BigImage alloc] init];
    }
    return _bigImage;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PublicContentImageModel *model = self.model.Data.Album.Images[indexPath.row];
    BigImage* image = [self.bigImage initWithUrl:[[NSString alloc] initWithFormat:@"http://172.18.178.56/api/thumb/%@", model.Thumb]];
    [self.navigationController pushViewController:image animated:true];
}

@end
