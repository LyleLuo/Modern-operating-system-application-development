//
//  PublicContentModel.h
//  frontend
//
//  Created by student13 on 2020/12/1.
//  Copyright © 2020 sysu. All rights reserved.
//

#ifndef PublicContentModel_h
#define PublicContentModel_h

@interface PublicItemUserModel : NSObject

@property(nonatomic) NSString* Name;
@property(nonatomic) NSString* Avatar;
@property(nonatomic) NSInteger Gender;

@end

@interface PublicContentFileModel: NSObject

@property(nonatomic) NSString* File;
@property(nonatomic) NSInteger Size;
@property(nonatomic) NSString* Title;
@property(nonatomic) NSInteger Count;
@property(nonatomic) NSString* Type;
@property(nonatomic) NSDate* Time;

@end

@interface PublicContentImageModel: NSObject

@property(nonatomic) Boolean Native;
@property(nonatomic) NSString* Url;
@property(nonatomic) NSString* Type;
@property(nonatomic) NSString* Thumb;
@property(nonatomic) PublicContentFileModel* File;

@end

@interface PublicContentAlbumModel : NSObject

@property(nonatomic) NSArray* Images;
@property(nonatomic) NSString* Title;
@property(nonatomic) NSDate* Time;
@property(nonatomic) NSString* Location;

@end

@interface PublicContentModel : NSObject

@property(nonatomic) NSString* Id;
@property(nonatomic) NSString* Name;
@property(nonatomic) NSString* Detail;
@property(nonatomic) NSString* OwnId;
@property(nonatomic) NSDate* PublishDate;
@property(nonatomic) NSDate* EditDate;
@property(nonatomic) NSInteger LikeNum;
@property(nonatomic) NSInteger CommentNum;
@property(nonatomic) Boolean Public;
@property(nonatomic) Boolean Native;
@property(nonatomic) NSString* Type;
@property(nonatomic) NSArray* Tag;
@property(nonatomic) NSArray* Image;
@property(nonatomic) NSArray* Files;
@property(nonatomic) NSArray* Movie;
@property(nonatomic) PublicContentAlbumModel* Album;

@end

@interface PublicItemModel : NSObject

@property(nonatomic) PublicContentModel* Data;
@property(nonatomic) PublicItemUserModel* User;

@end

@interface CommentModel : NSObject

@property(nonatomic) NSString* Id;
@property(nonatomic) NSString* ContentId;
@property(nonatomic) NSString* FatherId;
@property(nonatomic) NSString* UserId;
@property(nonatomic) NSDate* Date;
@property(nonatomic) NSString* Content;
@property(nonatomic) NSInteger LikeNum;

@end

@interface ReplyModel : NSObject

@property(nonatomic) CommentModel* Reply;
@property(nonatomic) PublicItemUserModel* User;
@property(nonatomic) PublicItemUserModel* Father;

@end

@interface CommentForContentModel : NSObject

@property(nonatomic) CommentModel* Comment;
@property(nonatomic) PublicItemUserModel* User;
@property(nonatomic) NSMutableArray* Replies;

@end

@interface NotificationDataModel : NSObject

@property(nonatomic) NSString* Id;
@property(nonatomic) NSDate* CreateTime;
@property(nonatomic) NSString* Content;
@property(nonatomic) NSString* SourceId;
@property(nonatomic) NSString* TargetId;
@property(nonatomic) Boolean Read;
@property(nonatomic) NSString* Type;

@end

@interface NotificationModel : NSObject

@property(nonatomic) PublicItemUserModel* User;
@property(nonatomic) NotificationDataModel* Data;

@end

#endif /* PublicContentModel_h */
