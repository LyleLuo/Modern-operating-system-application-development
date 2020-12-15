//
//  InputVC.m
//  frontend
//
//  Created by 陈志远 on 2020/12/2.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../../AppDelegate.h"
#import "InputVC.h"
#import "../HomeController.h"
#import "MetaData.h"
#import "BigImage.h"
#import <AFNetworking.h>

@interface InputVC () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, strong) UITextField *titleIn;
@property(nonatomic, strong) UITextField *input;
@property(nonatomic, strong) UILabel *finish;
@property(nonatomic, strong) NSMutableArray *images;
@property(nonatomic, strong) NSMutableArray *pos;
@property(nonatomic, strong) NSMutableArray *imgvs;
@property(nonatomic, strong) UISwitch *mySwitch;
@property(nonatomic, strong) UILabel *public;
@property(nonatomic, strong) UIButton *addbtn;
@property(nonatomic, strong) UIImage *img;
@property(nonatomic) NSInteger num;

@end


@implementation InputVC

- (id)init {
    self = [super init];
    if (self) {
        self.num = 0;
        self.images = [[NSMutableArray alloc] init];
        self.pos = [[NSMutableArray alloc] init];
        self.imgvs = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"发表内容"];
    
    [self setpos];
    [self addSwitch];
    [self setInfo];
}

- (void)setInfo {
    self.titleIn = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, wlen - 40, 50)];
    self.titleIn.placeholder = @"简要...";
    [self.view addSubview:self.titleIn];
    self.input = [[UITextField alloc] initWithFrame:CGRectMake(20, 155, wlen - 40, 50)];
    self.input.placeholder = @"这一刻的想法...";
    [self.view addSubview:self.input];
    
    self.addbtn = [[UIButton alloc]init];
    self.addbtn.frame = CGRectMake(20, 270, 80, 80);
    self.addbtn.backgroundColor = [UIColor whiteColor];
    [self.addbtn setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    self.addbtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.addbtn.layer.borderWidth = 1.0;
    [self.addbtn addTarget:self action:@selector(selectImages:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addbtn];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(publish:)];
    self.navigationItem.rightBarButtonItem = btn;
}

- (void)publish:(UIBarButtonItem*)btn {
    NSString *text = self.input.text;
    NSString *title = self.titleIn.text;
    NSObject *isp = [[NSObject alloc] init];
    if ([self.mySwitch isOn]) {
        isp = @YES;
        NSLog(@"on");
    } else {
        isp = @NO;
    }

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:title forKey:@"title"];
    [params setObject:text forKey:@"detail"];
    [params setObject:isp forKey:@"isPublic"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://172.18.178.56/api/content/album" parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for(int i = 0; i < self.images.count;i++){
            UIImage *imgtmp = self.images[i];
            NSData *imgData = UIImageJPEGRepresentation(imgtmp, 0.4);
            NSString *fileKey = [NSString stringWithFormat:@"file%d", (i + 1)];
            NSString *thumbKey = [NSString stringWithFormat:@"thumb%d", (i + 1)];
            [formData appendPartWithFileData:imgData name:fileKey fileName:fileKey mimeType:@"image/png"];
            [formData appendPartWithFileData:imgData name:thumbKey fileName:thumbKey mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"post content successfully");
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"responseObject: %@",JSON);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"post failed");
    }];
}

- (void)selectImages:(UIButton*)btn {
    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
    pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pick.delegate = self;
    [self presentViewController:pick animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.img = image;
    [self.images addObject:self.img];
    UIImageView *imv = [[UIImageView alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanClick:)];
    imv.frame = CGRectFromString(self.pos[(int)self.num]);
    [imv setImage:self.img];
    [self.imgvs addObject:imv];
    [self.view addSubview:self.imgvs[(int)self.num]];
    [self.imgvs[(int)self.num] addGestureRecognizer:tap];
    [self.imgvs[(int)self.num] setUserInteractionEnabled:YES];
    
    self.num++;
    self.addbtn.frame = CGRectFromString(self.pos[(int)self.num]);
    if (self.num >= 10) {
        self.addbtn.enabled = false;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)scanClick:(UITapGestureRecognizer*)tap {
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [ImageZoom ImageZoomWithImageView:clickedImageView];
}

- (void)setpos {
    NSString *p1 = NSStringFromCGRect(CGRectMake(20, 270, 80, 80));
    NSString *p2 = NSStringFromCGRect((CGRectMake(110, 270, 80, 80)));
    NSString *p3 = NSStringFromCGRect(CGRectMake(200, 270, 80, 80));
    NSString *p4 = NSStringFromCGRect(CGRectMake(290, 270, 80, 80));
    NSString *p5 = NSStringFromCGRect(CGRectMake(20, 360, 80, 80));
    NSString *p6 = NSStringFromCGRect(CGRectMake(110, 360, 80, 80));
    NSString *p7 = NSStringFromCGRect(CGRectMake(200, 360, 80, 80));
    NSString *p8 = NSStringFromCGRect(CGRectMake(290, 360, 80, 80));
    NSString *p9 = NSStringFromCGRect(CGRectMake(20, 450, 80, 80));
    
    [self.pos addObject:p1];
    [self.pos addObject:p2];
    [self.pos addObject:p3];
    [self.pos addObject:p4];
    [self.pos addObject:p5];
    [self.pos addObject:p6];
    [self.pos addObject:p7];
    [self.pos addObject:p8];
    [self.pos addObject:p9];
}

- (void)addSwitch {
    self.public = [[UILabel alloc] initWithFrame:CGRectMake(20, 210, 60, 40)];
    [self.public setText:@"公开"];
    [self.public setTextColor:[UIColor grayColor]];
    [self.view addSubview:self.public];
    
    self.mySwitch = [[UISwitch alloc] init];
    [self.view addSubview:self.mySwitch];
    self.mySwitch.center = CGPointMake(85, 230);
    [self.mySwitch addTarget:self.public action:@selector(changeColor:) forControlEvents:UIControlEventTouchDown];
}

- (void)changeColor:(UISwitch*)s {
    if (s.isOn) {
        [self.public setTextColor:[UIColor blueColor]];
    }
}

@end
