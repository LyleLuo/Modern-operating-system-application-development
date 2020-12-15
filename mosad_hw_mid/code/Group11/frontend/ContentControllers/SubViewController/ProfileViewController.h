//
//  ProfileViewController.h
//  frontend
//
//  Created by luowle on 2020/11/17.
//  Copyright © 2020 sysu. All rights reserved.
//

#ifndef ProfileViewController_h
#define ProfileViewController_h
#import <UIKit/UIKit.h>
#import "../SettingsController.h"

@interface ProfileViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) SettingsController* father;
@property(nonatomic, strong) UITableViewController *info;
@end
#endif /* ProfileViewController_h */
