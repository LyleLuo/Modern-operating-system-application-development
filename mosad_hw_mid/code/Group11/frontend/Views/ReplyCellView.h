//
//  ReplyCellView.h
//  frontend
//
//  Created by student13 on 2020/12/4.
//  Copyright © 2020 sysu. All rights reserved.
//

#ifndef ReplyCellView_h
#define ReplyCellView_h

#import <UIKit/UIKit.h>
#import "../Models/PublicContentModel.h"

@interface ReplyCellView : UICollectionViewCell
-(instancetype)initWithData:(ReplyModel*) data;
@end

#endif /* ReplyCellView_h */
