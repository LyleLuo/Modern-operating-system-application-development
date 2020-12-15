//
//  NotificationCellView.h
//  frontend
//
//  Created by student13 on 2020/12/11.
//  Copyright © 2020 sysu. All rights reserved.
//

#ifndef NotificationCellView_h
#define NotificationCellView_h

#import <UIKit/UIKit.h>
#import "../Models/PublicContentModel.h"

@interface NotificationCellView : UICollectionViewCell

- (instancetype)initWithData:(NotificationModel*)model;

@end

#endif /* NotificationCellView_h */
