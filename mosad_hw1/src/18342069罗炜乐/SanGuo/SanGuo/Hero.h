//
//  Hero.h
//  SanGuo
//
//  Created by luowle on 2020/10/4.
//  Copyright © 2020 luowle. All rights reserved.
//

#ifndef Hero_h
#define Hero_h
//
//  Hero.h
//  HeroPK
//  Copyright © 2019 TMachine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Hero : NSObject

@property(nonatomic) NSInteger bloodValue;
@property(nonatomic) NSInteger energyValue;
@property(nonatomic) NSString* country;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* skillName;

- (void)PKOneUnit;
// 普通攻击
- (void)normalAttackTo:(Hero *) other;
// 技能攻击
- (BOOL)skillTo:(Hero *) other;
@end

@interface LiuBei : Hero
@end

@interface GuanYu : Hero
@end

@interface ZhangFei : Hero
@end

@interface ZhaoYun : Hero
@end

@interface CaoCao : Hero
@end

@interface SiMaYi : Hero
@end

@interface ZhenJi : Hero
@end

@interface SunQuan : Hero
@end

@interface SunCe : Hero
@end

@interface DaQiao : Hero
@end

@interface ZhangLiao : Hero
@end

@interface NormalOne : Hero
@end



NS_ASSUME_NONNULL_END
#endif /* Hero_h */
