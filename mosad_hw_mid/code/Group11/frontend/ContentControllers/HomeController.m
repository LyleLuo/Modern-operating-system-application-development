//
//  HomeController.m
//  frontend
//
//  Created by student13 on 2020/11/16.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeController.h"
#import "MetaData.h"
#import "AppDelegate.h"
#import "SupportView/InputVC.h"
#import "DetailViewController.h"
#import "../Models/PublicContentModel.h"
#import "../Views/ItemCellView.h"

@interface HomeController ()

@property(nonatomic, strong) UISearchBar *search;
@property(nonatomic, strong) NSMutableArray *data;
@property(nonatomic, strong) UICollectionView *collection;
@property(nonatomic, strong) UIButton *addNew;

@end

@implementation HomeController

- (UIButton*)addNew {
    if (_addNew == nil) {
        _addNew = [UIButton buttonWithType:UIButtonTypeCustom];
        _addNew.frame = CGRectMake(wlen - 90, hlen - 180, 80, 80);
        [_addNew setTitle:@"添加" forState:UIControlStateNormal];
        _addNew.backgroundColor = [UIColor colorWithRed:(float) 255 / 255.0f green:(float)228 / 255.0f blue:(float)196 / 255.0f alpha:0.5];
        //半径
        _addNew.layer.cornerRadius = 40;
        //裁边
        _addNew.layer.masksToBounds = YES;
        //边框宽度
        _addNew.layer.borderWidth = 3.0;
        //边框颜色
        _addNew.layer.borderColor = [UIColor whiteColor].CGColor;
        [_addNew setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        //想要实现圆形,需要将layer的cornerRadius大小设置为Button宽高的一半,前提width=height
        [_addNew addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:_addNew];
    }
    return _addNew;
}

- (void)addItem:(UIButton*)btn {
   InputVC *ivc = [[InputVC alloc] init];
   [self.navigationController pushViewController:ivc animated:YES];
}

- (void)loadData {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = @"http://172.18.178.56/api/content/album/self";
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
        NSArray* items = [dic objectForKey:@"Data"];
        
        for (int i = 0; i < items.count; i++) {
            PublicItemModel *model = [[PublicItemModel alloc] init];
            NSDictionary* itemData = items[i];
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
            model.Data.Album.Images = array;
            
            [self.data addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
        
    }];
    [task resume];
}

- (void)reloadData {
    [self.collection refreshControl];
    [self.collection reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:@"个人主页"];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.data removeAllObjects];
    [self loadData];
}

- (instancetype) init{
    self = [super init];
    [self.view addSubview:[self collection]];
    [self addNew];
    return self;
}

-(NSMutableArray *)data {
    if (_data == nil) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (UICollectionView *)collection {
    if (_collection == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width - 20, 250);
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + 10, self.view.bounds.origin.y + 150, self.view.bounds.size.width - 20, self.view.bounds.size.height - 150) collectionViewLayout:flowLayout];
        [_collection setBackgroundColor:UIColor.clearColor];
        [_collection setDataSource:self];
        [_collection setDelegate:self];
        [_collection registerClass:[ItemCellView class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collection;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PublicItemModel* model = self.data[indexPath.row];
    ItemCellView *cell = [[self.collection dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath] initWithData:model];
    cell.layer.borderColor = [UIColor grayColor].CGColor;
    cell.layer.borderWidth = 1.0;
    cell.layer.cornerRadius = 10.0;
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController* detail = [[DetailViewController alloc] initWithData:self.data[indexPath.row] withCanDelete:YES];
    [self.navigationController pushViewController:detail animated:true];
}

@end

