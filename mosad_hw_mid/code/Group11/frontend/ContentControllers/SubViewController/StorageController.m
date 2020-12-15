//
//  StorageController.m
//  frontend
//
//  Created by luowle on 2020/11/17.
//  Copyright © 2020 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StorageController.h"
#import "frontend-Bridging-Header.h"
#import "AppDelegate.h"

@interface StorageController()

@end

@implementation StorageController
-(instancetype)init{
    self = [super init];
    _usedStorage = 480.0;
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:@"存储额度"];
    
    PieChartView *chart = [[PieChartView alloc] initWithFrame:self.view.bounds];
    chart.backgroundColor = [UIColor whiteColor];
    [chart setExtraOffsetsWithLeft:30 top:0 right:30 bottom:0];
    chart.usePercentValuesEnabled = NO;
    chart.dragDecelerationEnabled = YES;
    chart.drawHoleEnabled = YES;
    chart.holeRadiusPercent = 0.5;
    chart.holeColor = [UIColor clearColor];
    chart.transparentCircleRadiusPercent = 0.52;
    chart.transparentCircleColor = [UIColor colorWithRed:210/255 green:145/255 blue:165/255 alpha:0.3];
    if (chart.isDrawHoleEnabled == YES) {
        chart.drawCenterTextEnabled = YES;//是否显示中间文字
        NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"存储状况(MB)"];
        [centerText setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
                                NSForegroundColorAttributeName: [UIColor orangeColor]}
                        range:NSMakeRange(0, centerText.length)];
        chart.centerAttributedText = centerText;
    }
    chart.legend.maxSizePercent = 1;//图例在饼状图中的大小占比, 这会影响图例的宽高
    chart.legend.formToTextSpace = 5;//文本间隔
    chart.legend.font = [UIFont systemFontOfSize:10];//字体大小
    chart.legend.textColor = [UIColor grayColor];//字体颜色
    chart.legend.form = ChartLegendFormCircle;//图示样式: 方形、线条、圆形
    chart.legend.formSize = 12;//图示大小
    chart.data = [self setData];
    [self.view addSubview:chart];
}

- (PieChartData *)setData{
    //每个区块的数据
    PieChartDataEntry *used = [[PieChartDataEntry alloc] initWithValue:([AppDelegate getUserModel].UsedSize)/1048576 label:@"已使用"];
    PieChartDataEntry *remain = [[PieChartDataEntry alloc] initWithValue:([AppDelegate getUserModel].MaxSize - [AppDelegate getUserModel].UsedSize)/1048576 label:@"剩余"];
    NSMutableArray *yVals = [[NSMutableArray alloc] initWithObjects:used, remain, nil];

    //dataSet
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithEntries:yVals];
    dataSet.drawValuesEnabled = YES;//是否绘制显示数据
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    dataSet.colors = colors;//区块颜色
    dataSet.entryLabelColor = [UIColor blackColor];
    dataSet.sliceSpace = 0;//相邻区块之间的间距
    dataSet.selectionShift = 8;//选中区块时, 放大的半径
    dataSet.xValuePosition = PieChartValuePositionInsideSlice;//名称位置
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数据位置
    //数据与区块之间的用于指示的折线样式
    dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
    dataSet.valueLinePart1Length = 0.5;//折线中第一段长度占比
    dataSet.valueLinePart2Length = 0.4;//折线中第二段长度最大占比
    dataSet.valueLineWidth = 1;//折线的粗细
    dataSet.valueLineColor = [UIColor brownColor];//折线颜色
    
    //data
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterPercentStyle;
    formatter.maximumFractionDigits = 0;//小数位数
    formatter.multiplier = @1.f;
    //[data setValueFormatter:formatter];//设置显示数据格式
    [data setValueTextColor:[UIColor brownColor]];
    [data setValueFont:[UIFont systemFontOfSize:10]];
    
    return data;
}
@end
