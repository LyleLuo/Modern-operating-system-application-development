#import "Home.h"

#pragma mark "我的"页面实现
@implementation Home
- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIImage *img = [self getBackgroundImg];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [self.view addSubview:imgView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.emptyNBar];
    [self.view addSubview:self.headNBar];
    [self.view addSubview:self.login];
    self.view.backgroundColor = [UIColor whiteColor];
}

// 获得一个从中心向四周渐变的背景图
- (UIImage*)getBackgroundImg{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMinY(rect));
    CGPathCloseSubpath(path);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[(__bridge id)[UIColor systemPinkColor].CGColor , (__bridge id)[UIColor whiteColor].CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint center = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMidY(pathRect));
    CGFloat radius = MAX(pathRect.size.width / 2.0, pathRect.size.height / 2.0) * sqrt(2);
    CGContextSaveGState(gc);
    CGContextAddPath(gc, path);
    CGContextEOClip(gc);
    CGContextDrawRadialGradient(gc, gradient, center, 0, center, radius, 0);
    CGContextRestoreGState(gc);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGPathRelease(path);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

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
        [_headNBar pushNavigationItem:[[UINavigationItem alloc] initWithTitle:@"我的"] animated:YES];
        _headNBar.backgroundColor = [UIColor whiteColor];
    }
    return _headNBar;
}

#pragma mark 登陆按钮的实现
-(UIButton *)login{
    if (_login == nil) {
        _login = [[UIButton alloc]initWithFrame:CGRectMake(100, 350, 200, 200)];
        [_login.layer setBorderWidth:2.0];
        [_login.layer setBorderColor:[UIColor blackColor].CGColor];
        [_login.layer setCornerRadius:100.0];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", @"登陆"]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]range:NSMakeRange(0,2)];
        [_login setAttributedTitle:str forState:UIControlStateNormal];
        [_login addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _login;
}

-(void)btnClick:(id)sender{
    _login.hidden = YES;
    [self.view addSubview:self.avatar];
    [self.view addSubview:self.about];
    [self.view addSubview:self.user];
}

#pragma mark 头像的实现
-(UIButton *)avatar{
    if (_avatar == nil) {
        _avatar = [[UIButton alloc]initWithFrame:CGRectMake(125, 150, 150, 150)];
        [_avatar.layer setBorderWidth:1.0];
        [_avatar.layer setBorderColor:[UIColor blackColor].CGColor];
        [_avatar.layer setCornerRadius:75.0];
        [_avatar setBackgroundImage:[UIImage imageNamed:@"头像.png"] forState:UIControlStateNormal];
    }
    return _avatar;
}

#pragma mark 头像下面第一个标签的实现
- (UILabel *) user{
    if(_user == nil){
        _user = [[UILabel alloc] initWithFrame:CGRectMake(100, 350, 200, 120)];
        _user.text = @"  用户名\n  邮箱\n  电话";
        _user.font =  [UIFont systemFontOfSize:20];
        _user.textAlignment = NSTextAlignmentCenter;
        _user.numberOfLines = 3;
        [_user.layer setBorderColor:[UIColor blackColor].CGColor];
        [_user.layer setBorderWidth:1.0];
        _user.textAlignment = NSTextAlignmentLeft;
        NSMutableAttributedString * attriString =  [[NSMutableAttributedString alloc] initWithString:_user.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:10];//设置距离
        [attriString addAttribute:NSParagraphStyleAttributeName
                            value:paragraphStyle
                            range:NSMakeRange(0, [_user.text length])];
        _user.attributedText = attriString;
    }
    return _user;
}

#pragma mark 头像下面第二个标签的实现，此处也可以用label，不过label并没有title这个东西
- (UITableView*)about{
    if(_about == nil){
        _about = [[UITableView alloc]initWithFrame:CGRectMake(50, 470, 320, 300) style:UITableViewStyleGrouped];
        _about.dataSource = self;
        _about.delegate = self;
        
        _about.backgroundColor = [UIColor clearColor];
        [_about setScrollEnabled:YES];

        _about.separatorStyle = UITableViewCellSeparatorStyleNone;//去除分割线
    }
    return _about;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"关于";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cell_id = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    // section中每行显示的内容
    if(indexPath.row == 0){
        cell.textLabel.text = [NSString stringWithFormat:@"版本："];
    }else if (indexPath.row == 1){
        cell.textLabel.text = [NSString stringWithFormat:@"隐私和cookie："];
    }else if (indexPath.row == 2){
        cell.textLabel.text = [NSString stringWithFormat:@"清除缓存："];
    }else if (indexPath.row == 3){
        cell.textLabel.text = [NSString stringWithFormat:@"同步："];
    }
    return cell;
}

#pragma mark 给每个section画边框
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        CGFloat cornerRadius = 1.f;
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

        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor=[UIColor blackColor].CGColor;
        cell.backgroundColor = UIColor.clearColor;
        UIView *bgView = [[UIView alloc] initWithFrame:bounds];
        [bgView.layer insertSublayer:layer atIndex:0];
        cell.backgroundView = bgView;
    }
}
@end
