//
//  UserModel.h
//  frontend
//
//  Created by student13 on 2020/12/1.
//  Copyright © 2020 sysu. All rights reserved.
//

#ifndef UserModel_h
#define UserModel_h

#import "UserInfo.h"

@interface UserModel : NSObject

@property(nonatomic) NSString* Id;
@property(nonatomic) NSString* State;
@property(nonatomic) NSString* Email;
@property(nonatomic) NSString* Name;
@property(nonatomic) NSInteger Class;
@property(nonatomic) UserInfo* Info;
@property(nonatomic) NSInteger MaxSize;
@property(nonatomic) NSInteger UsedSize;
@property(nonatomic) NSInteger SingleSize;

@end

#endif
