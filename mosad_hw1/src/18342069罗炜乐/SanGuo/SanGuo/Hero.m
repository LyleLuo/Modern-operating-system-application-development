#import "Hero.h"

@implementation Hero
@synthesize bloodValue = _bloodValue;
@synthesize energyValue = _energyValue;
@synthesize country = _country;
@synthesize name = _name;
@synthesize skillName = _skillName;

- (id)init {
    self = [super init];
    if (self) {
        // 默认血量和能量值
        self.bloodValue = 100;
        self.energyValue = 100;
    }
    return self;
}

- (void)PKOneUnit {
    // 输出每个回合的状态
    NSLog(@"%@ currently has blood: %ld and energy: %ld.\n", self.name, (long)self.bloodValue, (long)self.energyValue);
    self.energyValue += 10;
}

// 每个英雄的普通攻击
- (void)normalAttackTo:(Hero *) other {
    other.bloodValue -= 10;
}

// 每个英雄的技能，默认返回false表示只有普通攻击
- (BOOL)skillTo:(Hero *) other {
    return false;
}
@end

@implementation LiuBei : Hero
- (id)init {
    self = [super init];
    if (self) {
        // 初始化自己的国家、名字、技能名字
        self.country = @"蜀国";
        self.name = @"刘备";
        self.skillName = @"以德服人";
    }
    return self;
}

- (BOOL)skillTo:(Hero *)other {
    if (self.energyValue >= 30 && self.bloodValue < 50) {
        self.energyValue -= 30;
        self.bloodValue += 30;
        return true;
    }
    return false;
}
@end

@implementation GuanYu : Hero
- (id)init {
    self = [super init];
    if (self) {
        self.country = @"蜀国";
        self.name = @"关羽";
        self.skillName = @"青龙偃月刀";
    }
    return self;
}

- (BOOL)skillTo:(Hero *)other {
    if (self.energyValue >= 40) {
        self.energyValue -= 40;
        other.bloodValue *= 0.8;
        [self normalAttackTo:other];
        return true;
    }
    return false;
}
@end

@implementation ZhangFei : Hero
- (id)init {
    self = [super init];
    if (self) {
        self.country = @"蜀国";
        self.name = @"张飞";
        self.skillName = @"狮子吼";
    }
    return self;
}

- (BOOL)skillTo:(Hero *)other {
    if (self.energyValue >= 30) {
        self.energyValue -= 30;
        other.bloodValue -= 20;
        other.energyValue -= 20;
        return true;
    }
    return false;
}
@end

@implementation ZhaoYun : Hero
- (id)init {
    self = [super init];
    if (self) {
        self.country = @"蜀国";
        self.name = @"赵云";
        self.skillName = @"破云之龙";
    }
    return self;
}

- (BOOL)skillTo:(Hero *)other {
    other.bloodValue -= 25;
    return true;
}
@end

@implementation CaoCao : Hero
- (id)init {
    self = [super init];
    if (self) {
        self.country = @"魏国";
        self.name = @"曹操";
        self.skillName = @"护驾";
    }
    return self;
}

- (BOOL)skillTo:(Hero *)other {
    if (self.energyValue >= 60) {
        self.energyValue += other.energyValue * 0.3;
        other.energyValue = 0;
        return true;
    }
    return false;
}
@end

@implementation SiMaYi : Hero
- (id)init {
    self = [super init];
    if (self) {
        self.country = @"魏国";
        self.name = @"司马懿";
        self.skillName = @"借尸还魂";
    }
    return self;
}

- (BOOL)skillTo:(Hero *)other {
    if (self.energyValue >= 60) {
        self.energyValue *= 1.3;
        self.bloodValue *= 1.3;
        self.energyValue -= 60;
        return true;
    }
    return false;
}
@end

@implementation ZhenJi : Hero
- (id)init {
    self = [super init];
    if (self) {
        self.country = @"魏国";
        self.name = @"甄姬";
        self.skillName = @"倾国倾城";
    }
    return self;
}

- (BOOL)skillTo:(Hero *)other {
    if (self.energyValue >= 30) {
        self.energyValue -= 30;
        self.bloodValue += 20;
        other.bloodValue -= 20;
        return true;
    }
    return false;
}
@end

@implementation SunQuan : Hero
- (id)init {
    self = [super init];
    if (self) {
        self.country = @"吴国";
        self.name = @"孙权";
        self.skillName = @"制衡";
    }
    return self;
}

- (BOOL)skillTo:(Hero *)other {
    if (self.energyValue >= 40) {
        if (self.bloodValue < other.bloodValue) {
            self.bloodValue = (self.bloodValue + other.bloodValue) / 2;
            other.bloodValue = (self.bloodValue + other.bloodValue) / 2;
        }
        return true;
    }
    return false;
}
@end

@implementation SunCe : Hero
- (id)init {
    self = [super init];
    if (self) {
        self.country = @"吴国";
        self.name = @"孙策";
        self.skillName = @"惊涛骇浪";
    }
    return self;
}

- (BOOL)skillTo:(Hero *)other {
    other.bloodValue -= 2 * (150 - self.bloodValue);
    return true;
}
@end

@implementation DaQiao : Hero
- (id)init {
    self = [super init];
    if (self) {
        self.country = @"吴国";
        self.name = @"大乔";
        self.skillName = @"川流不息";
    }
    return self;
}

- (BOOL)skillTo:(Hero *)other {
    self.bloodValue += 15;
    return true;
}
@end

@implementation ZhangLiao : Hero
- (id)init {
    self = [super init];
    if (self) {
        self.country = @"魏国";
        self.name = @"张辽";
        self.skillName = @"突袭";
    }
    return self;
}

- (BOOL)skillTo:(Hero *)other {
    if (self.energyValue >= 70) {
        other.bloodValue -= 40;
        return true;
    }
    return false;
}
@end

@implementation NormalOne : Hero
- (id)init {
    self = [super init];
    if (self) {
        self.country = @"无";
        self.name = @"普通士兵";
        self.skillName = @"无";
    }
    return self;
}
@end
