//
//  MetaData.h
//  frontend
//
//  Created by 陈志远 on 2020/11/16.
//  Copyright © 2020 sysu. All rights reserved.
//

//
//  MetaData.h
//  frontend
//
//  Created by 陈志远 on 2020/11/16.
//  Copyright © 2020 sysu. All rights reserved.
//

#ifndef MetaData_h
#define MetaData_h
#import "Foundation/Foundation.h"
#import "UIKit/UIKit.h"
#define wlen (UIScreen.mainScreen.bounds.size.width)
#define hlen (UIScreen.mainScreen.bounds.size.height)

@interface MineTextCell : UITableViewCell

@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *etime;
@property(nonatomic, strong) UILabel *text;
@property(nonatomic, strong) UILabel *pub;
@property(nonatomic, strong) UIButton *like;
@property(nonatomic, strong) UIButton *com;

@end

@interface MineImageCell : UITableViewCell

@property(nonatomic, strong) NSMutableArray *images;
@property(nonatomic, strong) UILabel *time;
@property(nonatomic, strong) UILabel *etime;
@property(nonatomic, strong) UILabel *pub;

@end

@interface MineText : NSObject {
    NSString *time;
    NSString *text;
    NSString *editTime;
    NSString *isp;
    NSString *title;
    int likeNum;
    int comNum;
}

- (NSString *) getTitle;
- (NSString *) getTime;
- (NSString *) getText;
- (NSString *) getEdit;
- (NSString *) getIsP;
- (int) getLike;
- (int) getCom;

- (void) setTitle:(NSString*) t;
- (void) setTime:(NSString *)t;
- (void) setText:(NSString *)text;
- (void) setEdit:(NSString *)t;
- (void) setIsP:(NSString *)is;
- (void) addLike;
- (void) addCom;

@end

@interface MineImage : NSObject {
    NSMutableArray *images;
    NSString *time;
    int likeNum;
    int comNum;
    NSInteger count;
    NSString *editTime;
    Boolean isp;
}

- (void)setImages:(NSMutableArray*)is;
- (void)setTime:(NSString*)time;
- (void)setEdit:(NSString *)t;
- (void)addImage:(UIImage*)image;
- (void)addLike;
- (void)addCom;
- (void)setIsP:(Boolean)isp;

- (UIImage*)getImageByIndex:(NSInteger)i;
- (int)getLike;
- (int)getCom;
- (NSString*)getTime;
- (NSString *) getEdit;
- (NSInteger) getCount;
- (Boolean)getIsP;

@end

#endif /* MetaData_h */
