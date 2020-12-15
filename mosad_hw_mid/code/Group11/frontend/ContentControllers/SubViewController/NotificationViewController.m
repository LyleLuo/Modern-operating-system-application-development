//
//  NotificationController.m
//  frontend
//
//  Created by luowle on 2020/11/17.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotificationViewController.h"
#import "../../Models/PublicContentModel.h"
#import "../../Views/NotificationCellView.h"
#import "../../AppDelegate.h"
#import "../DetailViewController.h"

@interface NotificationViewController()

@property(nonatomic, strong) UICollectionView* notifications;
@property(nonatomic, strong) NSMutableArray* data;

@end

@implementation NotificationViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:@"通知"];
}

- (void)loadData {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = @"http://172.18.178.56/api/notification/all";
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString* state = [dic objectForKey:@"State"];
        if (![state isEqualToString:@"success"]) {
            return;
        }
        NSArray* items = [dic objectForKey:@"Notification"];
        
        for (unsigned long i = items.count; i > 0; i--) {
            NotificationModel *model = [[NotificationModel alloc] init];
            NSDictionary* itemData = [items[i - 1] objectForKey:@"Data"];
            NSDictionary* itemUser = [items[i - 1] objectForKey:@"User"];
            model.Data = [[NotificationDataModel alloc] init];
            model.User = [[PublicItemUserModel alloc] init];
            model.Data.Id = [itemData objectForKey:@"ID"];
            model.Data.CreateTime = [[NSDate alloc] initWithTimeIntervalSince1970:[[itemData objectForKey:@"CreateTime"] integerValue]];
            model.Data.Read = [[itemData objectForKey:@"Read"] boolValue];
            model.Data.Type = [itemData objectForKey:@"Type"];
            model.Data.Content = [itemData objectForKey:@"Content"];
            model.Data.SourceId = [itemData objectForKey:@"SourceID"];
            model.Data.TargetId = [itemData objectForKey:@"TargetID"];
            model.User.Avatar = [itemUser objectForKey:@"Avatar"];
            model.User.Name = [itemUser objectForKey:@"Name"];
            model.User.Gender = [[itemUser objectForKey:@"Gender"] integerValue];
            
            [self.data addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
        
    }];
    [task resume];
}

- (void)setRead:(NSString*)nid {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://172.18.178.56/api/notification/read/%@", nid];
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"PATCH"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    }];
    [task resume];
}

- (void)navigateToContent:(NSString*)contentId {
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            DetailViewController* detail = [[DetailViewController alloc] initWithData:model withCanDelete:YES];
            [self.navigationController pushViewController:detail animated:true];
        });
    }];
    [task resume];
}

- (void) reloadData{
    [self.notifications refreshControl];
    [self.notifications reloadData];
}

- (instancetype)init {
    self = [super init];
    _data = [[NSMutableArray alloc] init];
    return self;
}

- (void)viewDidLoad {
    [self notifications];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.data removeAllObjects];
    [self loadData];
}

- (UICollectionView *)notifications {
    if (_notifications == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width - 20, 150);
        _notifications = [[UICollectionView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + 10, self.view.bounds.origin.y + 100, self.view.bounds.size.width - 20, self.view.bounds.size.height - 150) collectionViewLayout:flowLayout];
        [_notifications setBackgroundColor:UIColor.clearColor];
        [_notifications setDataSource:self];
        [_notifications setDelegate:self];
        [_notifications registerClass:[NotificationCellView class] forCellWithReuseIdentifier:@"cell"];
        [self.view addSubview:_notifications];
    }
    return _notifications;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NotificationModel* model = self.data[indexPath.row];
    NotificationCellView *cell = [[self.notifications dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath] initWithData:model];
    
    cell.layer.borderColor = [UIColor grayColor].CGColor;
    cell.layer.borderWidth = 1.0;
    cell.layer.cornerRadius = 10.0;
    
    cell.backgroundColor = [UIColor clearColor];
    if (!model.Data.Read) {
        [self setRead:model.Data.Id];
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NotificationModel* model = self.data[indexPath.row];
    [self navigateToContent:model.Data.TargetId];
}

@end
