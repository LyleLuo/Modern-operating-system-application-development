//
//  Photo.m
//  mosad_hw3
//
//  Created by luowle on 2020/12/9.
//  Copyright © 2020 luowle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
//#import "ItemCellView.h"

#define CachedImageFile(url) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[url lastPathComponent]]

@interface PhotoController()
@property(nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray *photoURL;
@property (nonatomic, strong) UIButton *loadBtn;
@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) UIButton *cacheBtn;
@property (nonatomic) bool isClear;
@end


@implementation PhotoController

- (instancetype)init {
    self = [super init];
    [self.tabBarItem setTitle:@"图库"];
    [self.tabBarItem setImage:[UIImage imageNamed:@"browse-3.png"]];
    self.navigationBarHidden = YES;
    [self.view addSubview:[self collection]];
    _photoURL = [[NSMutableArray alloc]initWithObjects:@"https://pic2.zhimg.com/v2-7fe7be50e50d71269e5b9b503ccfeec1_r.jpg",@"https://pic2.zhimg.com/v2-044c489e38af16b395e6ed325ebb1ad5_r.jpg",@"https://pic1.zhimg.com/v2-d5acce783ec584dd52df084052549358_r.jpg",@"https://pic3.zhimg.com/v2-a628d92e99ed536ac5a7ad629809b706_r.jpg",@"https://pic3.zhimg.com/v2-568070da980842567ce95a5596c4aab2_r.jpg", @"https://pic4.zhimg.com/80/v2-2e77b2aa91fc094c3d69ff5f20231d8b_720w.jpg", nil];
    [self.view addSubview:self.loadBtn];
    [self.view addSubview:self.clearBtn];
    [self.view addSubview:self.cacheBtn];
    _isClear = false;
    return self;
}

- (UICollectionView *)collection {
    if (_collection == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width - 20, 350);
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x + 10, self.view.bounds.origin.y + 100, self.view.bounds.size.width - 20, self.view.bounds.size.height - 150) collectionViewLayout:flowLayout];
        [_collection setBackgroundColor:UIColor.clearColor];
        [_collection setDataSource:self];
        [_collection setDelegate:self];
        [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collection;
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
            [data writeToFile:CachedImageFile(url) atomically:YES];
            view.image = [[UIImage alloc] initWithData:data];
        });
    }];
    [task resume];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //PublicItemModel* model = self.data[indexPath.row];
    UICollectionViewCell *cell = [self.collection dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];// initWithData:model];
    
    cell.layer.borderColor = [UIColor grayColor].CGColor;
    cell.layer.borderWidth = 1.0;
    cell.layer.cornerRadius = 10.0;
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 350)];
    // 获得url对于的沙盒缓存路径
    NSString *file = CachedImageFile(_photoURL[indexPath.item]);
    // 先从沙盒中取出图片
    NSData *data = [NSData dataWithContentsOfFile:file];
    [cell addSubview:image];
    if (data) {
        //data不为空，说明沙盒中存在这个文件
        image.image = [[UIImage alloc] initWithData:data];

    } else {
        image.image = [UIImage imageNamed:@"timg.gif"];
        [self loadThumb:_photoURL[indexPath.item] withView:image];
    }

    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _isClear ? 0 : 6;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // null
}

- (void)clearFile {
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:fileAbsolutePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:fileAbsolutePath error:&error];
        }
    }
}

-(UIButton *)loadBtn{
    if (_loadBtn == nil) {
        _loadBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 55, 100, 30)];
        [_loadBtn setShowsTouchWhenHighlighted:YES];
        [_loadBtn addTarget:self action:@selector(loadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",@"加载列表"]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor]range:NSMakeRange(0,4)];
        [_loadBtn setAttributedTitle:str forState:UIControlStateNormal];
    }
    return _loadBtn;
}

-(void)loadBtnClick:(UIButton*)sender{
    _isClear = false;
    [_collection reloadData];
    [_collection refreshControl];
}

-(UIButton *)clearBtn{
    if (_clearBtn == nil) {
        _clearBtn = [[UIButton alloc]initWithFrame:CGRectMake(160, 55, 100, 30)];
        [_clearBtn setShowsTouchWhenHighlighted:YES];
        [_clearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",@"清空列表"]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor]range:NSMakeRange(0,4)];
        [_clearBtn setAttributedTitle:str forState:UIControlStateNormal];
    }
    return _clearBtn;
}

-(void)clearBtnClick:(UIButton*)sender{
    _isClear = true;
    [_collection reloadData];
    [_collection refreshControl];
}

-(UIButton *)cacheBtn{
    if (_cacheBtn == nil) {
        _cacheBtn = [[UIButton alloc]initWithFrame:CGRectMake(290, 55, 100, 30)];
        [_cacheBtn setShowsTouchWhenHighlighted:YES];
        [_cacheBtn addTarget:self action:@selector(cacheBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",@"删除缓存"]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor]range:NSMakeRange(0,4)];
        [_cacheBtn setAttributedTitle:str forState:UIControlStateNormal];
    }
    return _cacheBtn;
}

-(void)cacheBtnClick:(UIButton*)sender{
    [self clearFile];
}

@end
