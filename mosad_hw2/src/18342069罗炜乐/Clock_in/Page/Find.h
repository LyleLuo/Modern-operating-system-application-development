#import <UIKit/UIKit.h>
#import "Record.h"

#pragma once
@interface Find : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,sender>
@property (nonatomic, strong) UINavigationBar *emptyNBar;
@property (nonatomic, strong) UINavigationBar *headNBar;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, retain) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray *date;
@property (nonatomic, strong) NSMutableArray *place;
@property (nonatomic, strong) NSMutableArray *attractions;
@property (nonatomic, strong) NSMutableArray *experience;
@property (nonatomic, strong) NSMutableArray *photo;
@end

