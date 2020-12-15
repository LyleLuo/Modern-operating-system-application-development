//
//  BigImage.m
//  frontend
//
//  Created by 陈志远 on 2020/12/3.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BigImage.h"

@interface BigImage ()

@property(strong, nonatomic) UIImageView* image;

@end

@implementation BigImage

-(void)downloadResource:(NSString*)url {
    NSURLSession * session = [NSURLSession sharedSession];
    NSString *urlString = url;
    urlString=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self image].image = [[UIImage alloc] initWithData:data];
        });
    }];
    [task resume];
}

-(instancetype) initWithUrl:(NSString*)url{
    if (self == nil) {
        self = [super init];
    }
    [self.navigationItem setTitle:@"查看大图"];
    [self image];
    [self loadImage:url];
    return self;
}

-(void)loadImage:(NSString*)url {
    [self downloadResource:url];
}

- (UIImageView *)image {
    if (_image == nil) {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height - 400)];
        [self.view addSubview:_image];
    }
    return _image;
}
@end

@implementation ImageZoom

static CGRect oldframe;

+(void)scanBigImageWithImage:(UIImage *)image frame:(CGRect)pOldframe {
    oldframe = pOldframe;
    //当前视图
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //背景
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:107/255.0 green:107/255.0 blue:99/255.0 alpha:0.6]];
    //此时视图不会显示
    [backgroundView setAlpha:0];
    //将所展示的imageView重新绘制在Window中
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
    [imageView setImage:image];
    [imageView setTag:1024];
    [backgroundView addSubview:imageView];
    //将原始视图添加到背景视图中
    [window addSubview:backgroundView];
    
    //添加点击事件同样是类方法 -> 作用是再次点击回到初始大小
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
    [backgroundView addGestureRecognizer:tapGestureRecognizer];
    
    //动画放大所展示的ImageView
    
    [UIView animateWithDuration:0.4 animations:^{
        CGFloat y,width,height;
        y = ([UIScreen mainScreen].bounds.size.height - image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width) * 0.5;
        //宽度为屏幕宽度
        width = [UIScreen mainScreen].bounds.size.width;
        //高度 根据图片宽高比设置
        height = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
        [imageView setFrame:CGRectMake(0, y, width, height)];
        //重要！ 将视图显示出来
        [backgroundView setAlpha:1];
    } completion:^(BOOL finished) {
        
    }];
    
}

+ (void)ImageZoomWithImageView:(UIImageView *)view {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self scanBigImageWithImage:view.image frame:[view convertRect:view.bounds toView:window]];
}

/**
 *  恢复imageView原始尺寸
 *
 *  @param tap 点击事件
 */
+(void)hideImageView:(UITapGestureRecognizer *)tap{
    UIView *backgroundView = tap.view;
    //原始imageview
    UIImageView *imageView = [tap.view viewWithTag:1024];
    //恢复
    [UIView animateWithDuration:0.4 animations:^{
        [imageView setFrame:oldframe];
        [backgroundView setAlpha:0];
    } completion:^(BOOL finished) {
        //完成后操作->将背景视图删掉
        [backgroundView removeFromSuperview];
    }];
}

@end
