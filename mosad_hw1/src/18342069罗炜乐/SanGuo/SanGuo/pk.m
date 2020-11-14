//
//  pk.m
//  SanGuo
//
//  Created by luowle on 2020/10/5.
//  Copyright © 2020 luowle. All rights reserved.
//

#import "pk.h"

struct pair makePairHero() {
    struct pair heroPair;
    heroPair.h1 = arc4random() % 12;
    heroPair.h2 = arc4random() % 12;
    while (heroPair.h1 == heroPair.h2) {
        heroPair.h2 = arc4random() % 12;
    }
    return heroPair;
}

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
