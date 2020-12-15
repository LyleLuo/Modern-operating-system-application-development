//
//  DetailViewController.h
//  frontend
//
//  Created by student13 on 2020/12/4.
//  Copyright © 2020 sysu. All rights reserved.
//

#ifndef DetailViewController_h
#define DetailViewController_h

#import <UIKit/UIKit.h>
#import "../Models/PublicContentModel.h"

@interface CommentController : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

-(instancetype)initWithData:(PublicItemModel*)model;

@end

@interface DetailViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

-(instancetype)initWithData:(PublicItemModel*)model withCanDelete:(Boolean)canDelete;

@end

#endif /* DetailViewController_h */
