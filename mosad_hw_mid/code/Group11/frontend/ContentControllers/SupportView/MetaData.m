//
//  MetaData.m
//  frontend
//
//  Created by 陈志远 on 2020/11/16.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MetaData.h"
#import "BigImage.h"

@implementation MineTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.width -= 20;
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (void)initSubView {
    self.backgroundColor = [UIColor colorWithRed:(float)248 / 255.0f green:(float)248 / 255.0f blue:(float)255 / 255.0f alpha:0.5];
    
    self.title = [[UILabel alloc] init];
    [self.title setFrame:CGRectMake(10, 5, 150, 20)];
    self.title.backgroundColor = [UIColor clearColor];
    self.title.font = [UIFont systemFontOfSize:18];
    self.title.textColor = [UIColor colorWithRed:(float)205 / 255.0f green:(float)92 / 255.0f blue:(float)92 / 255.0f alpha:0.7];
    [self addSubview:self.title];
    
    self.etime = [[UILabel alloc] init];
    [self.etime setFrame:CGRectMake(10, 28, 150, 20)];
    self.etime.backgroundColor = [UIColor clearColor];
    self.etime.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.etime];
    
    self.text = [[UILabel alloc]init];
    [self.text setFrame:CGRectMake(20, 50, 200, 40)];
    self.text.backgroundColor = [UIColor clearColor];
    self.text.font = [UIFont systemFontOfSize:18];
    [self addSubview:self.text];
    
    self.pub = [[UILabel alloc] init];
    [self.pub setFrame:CGRectMake(163, 5, 40, 20)];
    self.pub.backgroundColor = [UIColor clearColor];
    self.pub.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.pub];
}

@end

@implementation MineImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.width -= 20;
    frame.size.height -= 10;
}

- (void)initSubView{
    int row = 0, col = 0;
    self.backgroundColor = [UIColor colorWithRed:(float)248 / 255.0f green:(float)248 / 255.0f blue:(float)255 / 255.0f alpha:0.5];
    self.time = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 20)];
    self.time.font = [UIFont systemFontOfSize:18];
    self.time.backgroundColor = [UIColor clearColor];
    [self addSubview:self.time];
    
    self.etime = [[UILabel alloc] initWithFrame:CGRectMake(10, 28, self.bounds.size.width - 20, 20)];
    self.etime.backgroundColor = [UIColor clearColor];
    self.etime.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.etime];
    
    self.pub = [[UILabel alloc] init];
    [self.pub setFrame:CGRectMake(163, 5, 40, 20)];
    self.pub.backgroundColor = [UIColor clearColor];
    self.pub.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.pub];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanClick:)];
    
    for(int i = 0; i < self.images.count; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10 + row * 90, 50 + col * 90, 80, 80)];
        [iv setImage:self.images[i]];
        [iv addGestureRecognizer:tap];
        [iv setUserInteractionEnabled:YES];
        [self addSubview:iv];
        row++;
        if(row == 3) {
            row = 0;
            col++;
        }
    }
}

- (void)scanClick:(UITapGestureRecognizer*)tap {
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [ImageZoom ImageZoomWithImageView:clickedImageView];
}

@end

@implementation MineText

- (id)init {
    self = [super init];
    if(self) {
        self->time = @"";
        self->text = @"";
        self->title = @"";
        self->likeNum = 0;
        self->comNum = 0;
    }
    return self;
}

- (void) setTitle:(NSString*) t {
    self->title = t;
}

- (NSString *)getTitle {
    return self->title;
}
- (NSString *) getTime {
    return self->time;
}

- (NSString *) getText {
    return self->text;
}

- (NSString *) getEdit {
    return self->editTime;
}

- (int) getLike {
    return self->likeNum;
}

- (int) getCom {
    return self->comNum;
}

- (NSString*)getIsP {
    return self->isp;
}

- (void) setIsP:(NSString *)is {
    self->isp = is;
}

- (void) addLike {
    self->likeNum++;
}

- (void) addCom {
    self->comNum++;
}

- (void) setTime:(NSString *)time {
    self->time = time;
}

- (void) setText:(NSString *)text {
    self->text = text;
}

- (void) setEdit:(NSString *)t {
    self->editTime = t;
}

@end

@implementation MineImage

- (id)init {
    self = [super init];
    if(self) {
        self->images = [[NSMutableArray alloc] init];
        self->time = @"";
        self->count = 0;
        self->comNum = 0;
        self->likeNum = 0;
    }
    return self;
}

- (void)setImages:(NSMutableArray*)is {
    self->count = is.count;
    for(int i = 0; i < is.count; i++) {
        [self->images addObject:is[i]];
    }
}

- (int) getLike {
    return self->likeNum;
}

- (int) getCom {
    return self->comNum;
}

- (Boolean)getIsP {
    return self->isp;
}

- (void) setIsP:(Boolean)is {
    self->isp = is;
}

- (void) addLike {
    self->likeNum++;
}

- (void) addCom {
    self->comNum++;
}

- (void)setTime:(NSString*)time {
    self->time = time;
}

- (void)setEdit:(NSString *)t {
    self->editTime = t;
}

- (void)addImage:(UIImage *)image {
    [self->images addObject:image];
}

- (UIImage *)getImageByIndex:(NSInteger)i {
    return self->images[i];
}

- (NSInteger)getCount{
    return self->count;
}

- (NSString*)getTime {
    return self->time;
}

- (NSString *)getEdit {
    return self->editTime;
}

@end
