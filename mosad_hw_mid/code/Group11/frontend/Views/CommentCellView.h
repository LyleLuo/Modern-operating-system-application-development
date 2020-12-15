//
//  CommentCellView.h
//  frontend
//
//  Created by student13 on 2020/12/4.
//  Copyright © 2020 sysu. All rights reserved.
//

#ifndef CommentCellView_h
#define CommentCellView_h
#import <UIKit/UIKit.h>
#import "../Models/PublicContentModel.h"

@interface CommentCellView : UICollectionViewCell<UICollectionViewDataSource, UICollectionViewDelegate>
-(instancetype)initWithData:(CommentForContentModel*) data;
@end

#endif /* CommentCellView_h */
