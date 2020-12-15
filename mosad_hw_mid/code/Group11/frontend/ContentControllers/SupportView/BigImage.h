//
//  BigImage.h
//  frontend
//
//  Created by 陈志远 on 2020/12/3.
//  Copyright © 2020 sysu. All rights reserved.
//

#import "Foundation/Foundation.h"
#import "UIKit/UIKit.h"
#ifndef BigImage_h
#define BigImage_h


@interface BigImage : UIViewController
-(instancetype) initWithUrl:(NSString*)url;

@end

@interface ImageZoom : NSObject

+ (void)ImageZoomWithImageView:(UIImageView*)view;

@end
#endif /* BigImage_h */
