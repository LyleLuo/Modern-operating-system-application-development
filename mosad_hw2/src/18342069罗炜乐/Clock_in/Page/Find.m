#import "Find.h"
#pragma mark "打卡清单"页面实现
@implementation Find
#pragma mark "打卡清单"页面初始化
- (id)init{
    self = [super init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    _date = [[NSMutableArray alloc]init];
    [_date  addObject:[dateFormatter dateFromString:@"2018.9.6"]];
    [_date addObject:[dateFormatter dateFromString:@"2017.1.5"]];
    [_date addObject:[dateFormatter dateFromString:@"2016.11.16"]];
    [_date addObject:[dateFormatter dateFromString:@"2014.1.3"]];
    [_date addObject:[dateFormatter dateFromString:@"2010.4.21"]];
    [_date addObject:[dateFormatter dateFromString:@"1998.5.1"]];
    _place = [[NSMutableArray alloc]initWithObjects:@"广州",@"广州",@"广州",@"广州",@"广州",@"广州", nil];
    _attractions = [[NSMutableArray alloc]initWithObjects:@"中山大学",@"双鸭山大学",@"大山中学",@"大学山中",@"山中大学",@"新港西路", nil];
    _experience = [[NSMutableArray alloc]initWithObjects:@"这就是中大",@"我要上中山大学！我要上中山大学！我要上中山大学！",@"我爱俊俊",@"为什么去gogo要绕一个大圈",@"怎么才能考上中山大学",@"学计算机挺好的，就是头有点秃", nil];
    _photo = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"sysu1.jpg"],[UIImage imageNamed:@"sysu2.jpg"],[UIImage imageNamed:@"sysu3.jpg"],[UIImage imageNamed:@"sysu4.jpg"],[UIImage imageNamed:@"sysu5.jpeg"],[UIImage imageNamed:@"sysu6.jpeg"],[UIImage imageNamed:@"sysu1.jpg"],[UIImage imageNamed:@"sysu2.jpg"],[UIImage imageNamed:@"sysu3.jpg"],[UIImage imageNamed:@"sysu4.jpg"],[UIImage imageNamed:@"sysu5.jpeg"],[UIImage imageNamed:@"sysu6.jpeg"],[UIImage imageNamed:@"sysu1.jpg"],[UIImage imageNamed:@"sysu2.jpg"],[UIImage imageNamed:@"sysu3.jpg"],[UIImage imageNamed:@"sysu4.jpg"],[UIImage imageNamed:@"sysu5.jpeg"],[UIImage imageNamed:@"sysu6.jpeg"],[UIImage imageNamed:@"sysu1.jpg"],[UIImage imageNamed:@"sysu2.jpg"],[UIImage imageNamed:@"sysu3.jpg"],[UIImage imageNamed:@"sysu4.jpg"],[UIImage imageNamed:@"sysu5.jpeg"],[UIImage imageNamed:@"sysu6.jpeg"],[UIImage imageNamed:@"sysu1.jpg"],[UIImage imageNamed:@"sysu2.jpg"],[UIImage imageNamed:@"sysu3.jpg"],[UIImage imageNamed:@"sysu4.jpg"],[UIImage imageNamed:@"sysu5.jpeg"],[UIImage imageNamed:@"sysu6.jpeg"],[UIImage imageNamed:@"sysu1.jpg"],[UIImage imageNamed:@"sysu2.jpg"],[UIImage imageNamed:@"sysu3.jpg"],[UIImage imageNamed:@"sysu4.jpg"],[UIImage imageNamed:@"sysu5.jpeg"],[UIImage imageNamed:@"sysu6.jpeg"],nil];
     return self;
}

#pragma mark 载入bar，搜索栏和清单
- (void)viewDidLoad {
    [super viewDidLoad];

    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(id)[UIColor whiteColor].CGColor, (id)[UIColor systemPinkColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);

    [self.view addSubview:self.emptyNBar];
    [self.view addSubview:self.headNBar];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
}

#pragma mark bar的实现
-(UINavigationBar *)emptyNBar{
    if (_emptyNBar == nil) {
        _emptyNBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
        [_emptyNBar pushNavigationItem:[UINavigationItem new] animated:NO];
        _emptyNBar.backgroundColor = [UIColor whiteColor];
    }
    return _emptyNBar;
}

-(UINavigationBar *)headNBar{
    if (_headNBar == nil) {
        _headNBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 35, self.view.frame.size.width, 35)];
        [_headNBar pushNavigationItem:[[UINavigationItem alloc] initWithTitle:@"打卡清单"] animated:YES];
        _headNBar.backgroundColor = [UIColor whiteColor];
    }
    return _headNBar;
}

#pragma mark 搜索框设置
- (UISearchBar *) searchBar{
    if(_searchBar == nil){
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, 40)];
        _searchBar.placeholder = @"请输入时间或地点搜索";
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = YES;
        _searchBar.keyboardType = UIKeyboardAppearanceDefault;
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    }
    return _searchBar;
}

#pragma mark 搜索框代理
#pragma mark 取消搜索
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //放弃第一响应者对象，关闭软键盘
    [_searchBar resignFirstResponder];
}

#pragma mark 进行搜索的函数
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchBar resignFirstResponder];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *place = _searchBar.text;
    NSDate *date = [dateFormatter dateFromString:_searchBar.text];
    for (int i = 0; i < _date.count; ++i) {
        if ([place isEqualToString:_place[i]] || date == _date[i]) {
            NSLog(@"%@", place);
            NSString *str = [NSString stringWithFormat:@"日期：%@\n地点：%@\n景点:%@\n心得:%@",[dateFormatter stringFromDate:_date[i]], _place[i], _attractions[i], _experience[i]];
            // 弹框返回结果
            UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"搜索结果" message:str preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertVc animated:NO completion:nil];
            [alertVc addAction:[UIAlertAction actionWithTitle:@"确认"
                                                        style: UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction*action) {NSLog(@"点击了确认按钮");}]];
            return;
        }
    }
    UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"搜索结果" message:@"无结果" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertVc animated:NO completion:nil];
    [alertVc addAction:[UIAlertAction actionWithTitle:@"确认"
                                                style: UIAlertActionStyleCancel
                                              handler:^(UIAlertAction*action) {NSLog(@"点击了确认按钮");}]];
}

#pragma mark 清单展示
- (UITableView*)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 115, self.view.frame.size.width, self.view.frame.size.height-120) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
       _tableView.backgroundColor = [UIColor clearColor];
       [_tableView setScrollEnabled:YES];
       _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _date.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 设置标示符
    static NSString *cell_id = @"cell_id";
    //
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    // 判断cell是否存在
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    // 各行显示内容
    if(indexPath.row == 0){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@%@" ,@"日期： ",[dateFormatter stringFromDate:[_date objectAtIndex:indexPath.section]] ] ;
    }else if (indexPath.row == 1){
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@%@" ,@"地点 ： ",[_place objectAtIndex:indexPath.section] ] ;
    }else if (indexPath.row == 2){
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@%@" ,@"旅游心得 ： ",[_experience objectAtIndex:indexPath.section] ] ;
    }
    return cell;
}

 #pragma mark 某个打卡记录被点击后跳转到详情
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    Examine *examine = [[Examine alloc]init];
    examine.date = _date[indexPath.section];
    examine.place = _place[indexPath.section];
    examine.attractions = _attractions[indexPath.section];
    examine.experience = _experience[indexPath.section];
    examine.photo1 = _photo[indexPath.section * 6];
    examine.photo2 = _photo[indexPath.section * 6 + 1];
    examine.photo3 = _photo[indexPath.section * 6 + 2];
    examine.photo4 = _photo[indexPath.section * 6 + 3];
    examine.photo5 = _photo[indexPath.section * 6 + 4];
    examine.photo6 = _photo[indexPath.section * 6 + 5];
    [self addChildViewController:examine];

    CATransition *animation = [CATransition animation];
    animation.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"pageCurl";
    animation.duration = 0.5;
    animation.subtype = kCATransitionFromBottom;

    [self.view.layer addAnimation:animation forKey:nil];
    [self.view addSubview:examine.view];
}

// 重新绘制cell边框

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([cell respondsToSelector:@selector(tintColor)]) {
        CGFloat cornerRadius = 20.f;
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGMutablePathRef pathRef = CGPathCreateMutable();
        CGRect bounds = CGRectInset(cell.bounds, 10, 0);
        if (indexPath.row == 0) {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMinY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
        }
        else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
        }
        else {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            CGPathMoveToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
        }
        layer.path = pathRef;
        CFRelease(pathRef);
        //颜色修改
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor=[UIColor blackColor].CGColor;
        UIView *bgView = [[UIView alloc] initWithFrame:bounds];
        [bgView.layer insertSublayer:layer atIndex:0];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundView = bgView;
    }
    
    // 滑动清单时展现从小到大的动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    scaleAnimation.toValue  = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation.duration = 0.5;
    [cell.layer addAnimation:scaleAnimation forKey:@"transform"];
}

#pragma mark 打卡后将信息按时间顺序插入到清单中
- (void)send:(NSArray *)arr {
    if(arr != nil){
        int i = 0;
        for (; i < _date.count; i++) {
            if ([_date[i] compare:arr[0]] == -1) {
                break;
            }
        }
        [_date insertObject:arr[0] atIndex:i];
        [_place insertObject:arr[1] atIndex:i];
        [_attractions insertObject:arr[2] atIndex:i];
        [_experience insertObject:arr[3] atIndex:i];
        [_photo insertObject:arr[4] atIndex:i*6];
        [_photo insertObject:arr[5] atIndex:i*6+1];
        [_photo insertObject:arr[6] atIndex:i*6+2];
        [_photo insertObject:arr[7] atIndex:i*6+3];
        [_photo insertObject:arr[8] atIndex:i*6+4];
        [_photo insertObject:arr[9] atIndex:i*6+5];

        [self.tableView reloadData];
    }
}
@end
