//
//  ItemCellView.h
//  frontend
//
//  Created by student13 on 2020/12/2.
//  Copyright © 2020 sysu. All rights reserved.
//

#ifndef ItemCellView_h
#define ItemCellView_h

#import <UIKit/UIKit.h>
#import "../Models/PublicContentModel.h"

@interface ItemCellView : UICollectionViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

-(instancetype)initWithData:(PublicItemModel*) data;

@end

#endif /* ItemCellView_h */
