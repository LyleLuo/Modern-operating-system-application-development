#pragma once
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "../Common/Common.h"

@interface Home : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UINavigationBar *emptyNBar;
@property (nonatomic, strong) UINavigationBar *headNBar;
@property (nonatomic, strong) UIButton *login;
@property (nonatomic, strong) UIButton *avatar;
@property (nonatomic, retain) UILabel *user;
@property (nonatomic, retain) UITableView* about;
@end

