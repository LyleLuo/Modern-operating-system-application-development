# 18342069 罗炜乐 实验一报告
## 基类的设计
由于诸如 bloodValue 之类的变量均有 setter 和 getter 的需求，所以此处将其设置为属性变量。该属性变量有**数据隐秘性**，现在可以用编译器生成的 setter 和 getter 进行操作。
```objectivec
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
```

具体的实现如下
``` objectivec
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
```

## 派生类
各个英雄的具体实现略有不同，以下以刘备作为例子

刘备需要**继承**英雄这个父类。
```objectivec
@interface LiuBei : Hero
@end
```

初始化时调用父类的构造函数，并初始化自己特有的属性。
``` objectivec
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
```

每个英雄都有自己的特有技能，这需要重写父类的 SkillTo 方法，如果是“普通士兵”则不需要重写。重写体现了**多态**。技能的具体实现已经**封装**在该方法中。刘备的技能是“以德服人”，当自身血量小于50时，花费30的能量值来恢复30的血量。

```objectivec
- (BOOL)skillTo:(Hero *)other {
    if (self.energyValue >= 30 && self.bloodValue < 50) {
        self.energyValue -= 30;
        self.bloodValue += 30;
        return true;
    }
    return false;
}
```

## PK过程

### 代码实现
PK具体实现如下，看代码中的注释即可。父类指针指向所有子类体现了**多态**，方法的调用体现了**封装**。
```objectivec
void pk(int pkTimes) {
    // 用一个父类指针指向所有子类，以便随机选择子类。
    Hero * heros[12];
    heros[0] = [LiuBei new];
    heros[1] = [GuanYu new];
    heros[2] = [ZhangFei new];
    heros[3] = [ZhaoYun new];
    heros[4] = [CaoCao new];
    heros[5] = [SiMaYi new];
    heros[6] = [ZhenJi new];
    heros[7] = [SunQuan new];
    heros[8] = [SunCe new];
    heros[9] = [DaQiao new];
    heros[10] = [ZhangLiao new];
    heros[11] = [NormalOne new];
    struct pair hero = makePairHero();
    int h1 = hero.h1, h2 = hero.h2;
    NSLog(@"随机选到的英雄是%@和%@", heros[h1].name, heros[h2].name);
    // 选择英雄开始PK
    for (int i = 1; i <= pkTimes; ++i) {
        NSLog(@"This is the %d round!\n", i);
        [heros[h1] PKOneUnit];
        [heros[h2] PKOneUnit];
        NSLog(@"双方开始攻击！");
        // 有三分之一的概率即使拥有足够的能量值也选择普通攻击
        if (arc4random() % 3 && [heros[h1] skillTo:heros[h2]]) {
            NSLog(@"%@ use skill:%@ to %@\n", heros[h1].name, heros[h1].skillName, heros[h2].name);
        }
        else {
            [heros[h1] normalAttackTo:heros[h2]];
            NSLog(@"%@ use normal attack to %@\n", heros[h1].name, heros[h2].name);
        }
        if (arc4random() % 3 && [heros[h2] skillTo:heros[h1]]) {
            NSLog(@"%@ use skill:%@ to %@\n", heros[h2].name, heros[h2].skillName, heros[h1].name);
        }
        else {
            [heros[h2] normalAttackTo:heros[h1]];
            NSLog(@"%@ use normal attack to %@\n", heros[h2].name, heros[h1].name);
        }
        
        if (heros[h1].bloodValue <= 0 || heros[h2].bloodValue <= 0) {
            NSLog(@"有一方已阵亡，PK结束！");
            break;
        }
    }
    [heros[h1] PKOneUnit];
    [heros[h2] PKOneUnit];
    if (heros[h1].bloodValue <= 0 && heros[h1].bloodValue == heros[h2].bloodValue) {
        NSLog(@"%@和%@同时死亡，平局！\n\n", heros[h1].name, heros[h2].name);
    }
    else if (heros[h1].bloodValue < heros[h2].bloodValue) {
        NSLog(@"%@血量值更少，%@赢！\n\n", heros[h1].name, heros[h2].name);
    }
    else if (heros[h1].bloodValue > heros[h2].bloodValue) {
        NSLog(@"%@血量值更少，%@赢！\n\n", heros[h2].name, heros[h1].name);
    }
    else {
        NSLog(@"%@和%@血量值相等，平局！\n\n", heros[h1].name, heros[h2].name);
    }

}
```

### 对战实例
随机选择一对英雄对战6个回合
```
2020-10-08 22:55:10.961342-0700 SanGuo[1265:66746] 随机选到的英雄是刘备和张辽
2020-10-08 22:55:10.962721-0700 SanGuo[1265:66746] This is the 1 round!
2020-10-08 22:55:10.963026-0700 SanGuo[1265:66746] 刘备 currently has blood: 100 and energy: 100.
2020-10-08 22:55:10.963253-0700 SanGuo[1265:66746] 张辽 currently has blood: 100 and energy: 100.
2020-10-08 22:55:10.963453-0700 SanGuo[1265:66746] 双方开始攻击！
2020-10-08 22:55:10.963640-0700 SanGuo[1265:66746] 刘备 use normal attack to 张辽
2020-10-08 22:55:10.963830-0700 SanGuo[1265:66746] 张辽 use skill:突袭 to 刘备
2020-10-08 22:55:10.963993-0700 SanGuo[1265:66746] This is the 2 round!
2020-10-08 22:55:10.964145-0700 SanGuo[1265:66746] 刘备 currently has blood: 60 and energy: 110.
2020-10-08 22:55:10.964317-0700 SanGuo[1265:66746] 张辽 currently has blood: 90 and energy: 110.
2020-10-08 22:55:10.964482-0700 SanGuo[1265:66746] 双方开始攻击！
2020-10-08 22:55:10.964664-0700 SanGuo[1265:66746] 刘备 use normal attack to 张辽
2020-10-08 22:55:10.965063-0700 SanGuo[1265:66746] 张辽 use skill:突袭 to 刘备
2020-10-08 22:55:10.965417-0700 SanGuo[1265:66746] This is the 3 round!
2020-10-08 22:55:10.970275-0700 SanGuo[1265:66746] 刘备 currently has blood: 20 and energy: 120.
2020-10-08 22:55:10.970542-0700 SanGuo[1265:66746] 张辽 currently has blood: 80 and energy: 120.
2020-10-08 22:55:10.970750-0700 SanGuo[1265:66746] 双方开始攻击！
2020-10-08 22:55:10.970928-0700 SanGuo[1265:66746] 刘备 use skill:以德服人 to 张辽
2020-10-08 22:55:10.971114-0700 SanGuo[1265:66746] 张辽 use normal attack to 刘备
2020-10-08 22:55:10.971276-0700 SanGuo[1265:66746] This is the 4 round!
2020-10-08 22:55:10.971430-0700 SanGuo[1265:66746] 刘备 currently has blood: 40 and energy: 100.
2020-10-08 22:55:10.971613-0700 SanGuo[1265:66746] 张辽 currently has blood: 80 and energy: 130.
2020-10-08 22:55:10.971846-0700 SanGuo[1265:66746] 双方开始攻击！
2020-10-08 22:55:10.972312-0700 SanGuo[1265:66746] 刘备 use skill:以德服人 to 张辽
2020-10-08 22:55:10.973071-0700 SanGuo[1265:66746] 张辽 use skill:突袭 to 刘备
2020-10-08 22:55:10.973279-0700 SanGuo[1265:66746] This is the 5 round!
2020-10-08 22:55:10.973562-0700 SanGuo[1265:66746] 刘备 currently has blood: 30 and energy: 80.
2020-10-08 22:55:10.974061-0700 SanGuo[1265:66746] 张辽 currently has blood: 80 and energy: 140.
2020-10-08 22:55:10.974471-0700 SanGuo[1265:66746] 双方开始攻击！
2020-10-08 22:55:10.975107-0700 SanGuo[1265:66746] 刘备 use skill:以德服人 to 张辽
2020-10-08 22:55:10.975436-0700 SanGuo[1265:66746] 张辽 use normal attack to 刘备
2020-10-08 22:55:10.975822-0700 SanGuo[1265:66746] This is the 6 round!
2020-10-08 22:55:10.976191-0700 SanGuo[1265:66746] 刘备 currently has blood: 50 and energy: 60.
2020-10-08 22:55:10.976593-0700 SanGuo[1265:66746] 张辽 currently has blood: 80 and energy: 150.
2020-10-08 22:55:10.977085-0700 SanGuo[1265:66746] 双方开始攻击！
2020-10-08 22:55:10.977534-0700 SanGuo[1265:66746] 刘备 use normal attack to 张辽
2020-10-08 22:55:10.978096-0700 SanGuo[1265:66746] 张辽 use normal attack to 刘备
2020-10-08 22:55:10.978556-0700 SanGuo[1265:66746] 刘备 currently has blood: 40 and energy: 70.
2020-10-08 22:55:10.979109-0700 SanGuo[1265:66746] 张辽 currently has blood: 70 and energy: 160.
2020-10-08 22:55:10.979793-0700 SanGuo[1265:66746] 刘备血量值更少，张辽赢！


2020-10-08 22:55:11.136547-0700 SanGuo[1265:66746] Hello, 三国!
```
