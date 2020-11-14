//
//  pk.h
//  SanGuo
//
//  Created by luowle on 2020/10/5.
//  Copyright © 2020 luowle. All rights reserved.
//

#ifndef pk_h
#define pk_h
#import <Foundation/Foundation.h>
#import "Hero.h"
struct pair {
    int h1, h2;
} ;

struct pair makePairHero(void);

void pk(int pkTimes);

#endif /* pk_h */
