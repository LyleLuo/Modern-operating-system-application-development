//
//  NotificationCellView.m
//  frontend
//
//  Created by student13 on 2020/12/11.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotificationCellView.h"
#import "AppDelegate.h"
@interface NotificationCellView()

@property(nonatomic, strong)NotificationModel* model;

@property(nonatomic, strong)PublicItemModel* contentModel;

@property(nonatomic, strong) UIImageView* avatar;
@property(nonatomic, strong) UILabel* username;
@property(nonatomic, strong) UIButton* like;
@property(nonatomic, strong) UILabel* time;
@property(nonatomic, strong) UILabel* read;
@property(nonatomic, strong) UILabel* title;
@property(nonatomic, strong) UITextView* content;

@end

@implementation NotificationCellView

- (instancetype)initWithData:(NotificationModel*)data {
    if (self == nil) {
        self = [super init];
    }
    self.model = data;
    UIImageView* avatar = [self avatar];
    avatar.image = nil;
    [self loadAvatar:avatar withUrl:data.User.Avatar];
    [[self username] setText:data.User.Name];
    NSString* titleText = [data.Data.Type isEqualToString:@"like"] ? @"赞了你的内容" : @"回复了你的内容";
    [[self title] setText:titleText];
    [[self content] setText:data.Data.Content];
    [self getContent:data.Data.TargetId];
    return self;
}

- (void)getContent:(NSString*)contentId {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://172.18.178.56/api/content/detail/%@", contentId];
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSURLSessionTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString* state = [dic objectForKey:@"State"];
        if (![state isEqualToString:@"success"]) {
            return;
        }

        PublicItemModel *model = [[PublicItemModel alloc] init];
        NSDictionary* itemData = [dic objectForKey:@"Data"];
        model.Data = [[PublicContentModel alloc] init];
        model.User = [[PublicItemUserModel alloc] init];
        model.Data.Id = [itemData objectForKey:@"ID"];
        model.Data.Name = [itemData objectForKey:@"Name"];
        model.Data.Detail = [itemData objectForKey:@"Detail"];
        model.Data.OwnId = [itemData objectForKey:@"OwnID"];
        model.Data.PublishDate = [[NSDate alloc] initWithTimeIntervalSince1970:[[itemData objectForKey:@"PublishDate"] integerValue]];
        model.Data.EditDate = [[NSDate alloc] initWithTimeIntervalSince1970:[[itemData objectForKey:@"EditDate"] integerValue]];
        model.Data.LikeNum = [[itemData objectForKey:@"LikeNum"] integerValue];
        model.Data.CommentNum = [[itemData objectForKey:@"CommentNum"] integerValue];
        model.Data.Public = [[itemData objectForKey:@"Public"] boolValue];
        model.Data.Native = [[itemData objectForKey:@"Native"] boolValue];
        model.Data.Type = [itemData objectForKey:@"Type"];
        model.Data.Tag = [itemData objectForKey:@"Tag"];
        model.Data.Image = [itemData objectForKey:@"Image"];
        model.Data.Files = [itemData objectForKey:@"Files"];
        model.Data.Movie = [itemData objectForKey:@"Movie"];
        model.Data.Album = [[PublicContentAlbumModel alloc] init];
        NSDictionary* album = [itemData objectForKey:@"Album"];
        model.Data.Album.Time =[[NSDate alloc] initWithTimeIntervalSince1970:[[album objectForKey:@"Time"] integerValue]];
        model.Data.Album.Location =[album objectForKey:@"Location"];
        model.Data.Album.Title =[album objectForKey:@"Title"];
        model.User.Avatar = [AppDelegate getUserModel].Info.Avatar;
        model.User.Name = [AppDelegate getUserModel].Info.Name;
        model.User.Gender = [AppDelegate getUserModel].Info.Gender;
        
        NSArray *imageArray = [album objectForKey:@"Images"];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int j = 0; j < imageArray.count; j++) {
            PublicContentImageModel *imageModel = [[PublicContentImageModel alloc] init];
            imageModel.Native = [[imageArray[j] objectForKey:@"Native"] boolValue];
            imageModel.Thumb = [imageArray[j] objectForKey:@"Thumb"];
            imageModel.Url = [imageArray[j] objectForKey:@"URL"];
            NSDictionary *file = [imageArray[j] objectForKey:@"File"];
            imageModel.File = [[PublicContentFileModel alloc] init];
            imageModel.File.File = [[file objectForKey:@"File"] stringByReplacingOccurrencesOfString:@"/" withString:@"|"];
            imageModel.File.Count = [[file objectForKey:@"Count"] integerValue];
            imageModel.File.Size = [[file objectForKey:@"Size"] integerValue];
            imageModel.File.Title = [file objectForKey:@"Title"];
            imageModel.File.Type = [file objectForKey:@"Type"];
            imageModel.File.Time =[[NSDate alloc] initWithTimeIntervalSince1970:[[file objectForKey:@"Time"] integerValue]];
            [array addObject:imageModel];
        }
        self.contentModel = model;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.title setText:[self.title.text stringByAppendingFormat:@": %@", model.Data.Name]];
        });
    }];
    [task resume];
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
        _content = [[UITextView alloc] initWithFrame:CGRectMake(10, 80, self.bounds.size.width - 20, 60)];
        [_content setEditable:false];
        [self addSubview:_content];
    }
    return _content;
}

@end
