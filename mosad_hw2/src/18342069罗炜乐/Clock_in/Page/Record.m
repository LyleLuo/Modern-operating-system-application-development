#import "Record.h"

#pragma mark “查看打卡”页面的实现
@implementation Examine
#pragma mark 添加各个子部件
-(void)viewDidLoad{
    [super viewDidLoad];
    
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(id)[UIColor whiteColor].CGColor, (id)[UIColor systemPinkColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    [self.view addSubview:self.emptyNBar];
    [self.view addSubview:self.headNBar];
    [self.view addSubview:self.dateLabel];
    [self.view addSubview:self.placeLabel];
    [self.view addSubview:self.experienceLabel];
    [self.view addSubview:self.attractionsLabel];
    [self.view addSubview:self.picBtn1];
    [self.view addSubview:self.picBtn2];
    [self.view addSubview:self.picBtn3];
    [self.view addSubview:self.picBtn4];
    [self.view addSubview:self.picBtn5];
    [self.view addSubview:self.picBtn6];
    [self.view addSubview:self.returnBtn];
}

#pragma mark 最上面的两个bar
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
        [_headNBar pushNavigationItem:[[UINavigationItem alloc] initWithTitle:@"查看打卡"] animated:YES];
        _headNBar.backgroundColor = [UIColor whiteColor];
    }
    return _headNBar;
}

#pragma mark 显示日期的标签
-(UILabel *) dateLabel{
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 125, 320, 30)];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
        _dateLabel.text = [[NSString alloc] initWithFormat:@"%@", [dateFormatter stringFromDate:(NSDate * _Nonnull)_date]];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _dateLabel;
}

#pragma mark 显示地点的标签
-(UILabel *) placeLabel{
    if (_placeLabel == nil) {
        _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 185, 320, 60)];
        _placeLabel.text = [[NSString alloc] initWithFormat:@"%@", _place];
        _placeLabel.textAlignment = NSTextAlignmentLeft;
        _placeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _placeLabel;
}

#pragma mark 显示旅游景点的标签
-(UILabel *) attractionsLabel{
    if (_attractionsLabel == nil) {
        _attractionsLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 245, 320, 60)];
        _attractionsLabel.text = [[NSString alloc] initWithFormat:@"%@",_attractions];
        _attractionsLabel.textAlignment = NSTextAlignmentLeft;
        _attractionsLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _attractionsLabel;
}

#pragma mark 显示心得的标签
-(UILabel *) experienceLabel{
    if (_experienceLabel == nil) {
        _experienceLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 305, 320, 150)];
        _experienceLabel.text = [[NSString alloc] initWithFormat:@"%@",_experience];
        _experienceLabel.font = [UIFont systemFontOfSize:16];
        _experienceLabel.textAlignment = NSTextAlignmentLeft;
        _experienceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _experienceLabel;
}

#pragma mark 显示照片的按钮
-(UIButton *)picBtn1{
    if (_picBtn1 == nil) {
        _picBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(50, 460, 100, 80)];
        [_picBtn1.layer setBorderWidth:1.0];
        [_picBtn1.layer setBorderColor:[UIColor blackColor].CGColor];
        [_picBtn1 setImage:_photo1 forState:UIControlStateNormal];
    }
    return _picBtn1;
}

-(UIButton *)picBtn2{
    if (_picBtn2 == nil) {
        _picBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(160, 460, 100, 80)];
        [_picBtn2.layer setBorderWidth:1.0];
        [_picBtn2.layer setBorderColor:[UIColor blackColor].CGColor];
        [_picBtn2 setImage:_photo2 forState:UIControlStateNormal];
    }
    return _picBtn2;
}

-(UIButton *)picBtn3{
    if (_picBtn3 == nil) {
        _picBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(270, 460, 100, 80)];
        [_picBtn3.layer setBorderWidth:1.0];
        [_picBtn3.layer setBorderColor:[UIColor blackColor].CGColor];
        [_picBtn3 setImage:_photo3 forState:UIControlStateNormal];
    }
    return _picBtn3;
}

-(UIButton *)picBtn4{
    if (_picBtn4 == nil) {
        _picBtn4 = [[UIButton alloc]initWithFrame:CGRectMake(50, 550, 100, 80)];
        [_picBtn4.layer setBorderWidth:1.0];
        [_picBtn4.layer setBorderColor:[UIColor blackColor].CGColor];
        [_picBtn4 setImage:_photo4 forState:UIControlStateNormal];

    }
    return _picBtn4;
}


-(UIButton *)picBtn5{
    if (_picBtn5 == nil) {
        _picBtn5 = [[UIButton alloc]initWithFrame:CGRectMake(160, 550, 100, 80)];
        [_picBtn5.layer setBorderWidth:1.0];
        [_picBtn5.layer setBorderColor:[UIColor blackColor].CGColor];
        [_picBtn5 setImage:_photo5 forState:UIControlStateNormal];
    }
    return _picBtn5;
}


-(UIButton *)picBtn6{
    if (_picBtn6 == nil) {
        _picBtn6 = [[UIButton alloc]initWithFrame:CGRectMake(270, 550, 100, 80)];
        [_picBtn6.layer setBorderWidth:1.0];
        [_picBtn6.layer setBorderColor:[UIColor blackColor].CGColor];
        [_picBtn6 setImage:_photo6 forState:UIControlStateNormal];
    }
    return _picBtn6;
}

#pragma mark 返回按钮的实现
-(UIButton *)returnBtn{
    if (_returnBtn == nil) {
        _returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 41, 50, 35)];
        [_returnBtn setShowsTouchWhenHighlighted:YES];
        [_returnBtn.layer setBorderWidth:1.0];
        [_returnBtn.layer setBorderColor:[UIColor grayColor].CGColor];
        [_returnBtn.layer setCornerRadius:15.0];
        [_returnBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",@"返回"]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor]range:NSMakeRange(0,2)];
        [_returnBtn setAttributedTitle:str forState:UIControlStateNormal];
    }
    return _returnBtn;
}

-(void)btnClick:(UIButton*)sender{
    self.view.hidden = YES;
    [self removeFromParentViewController];
}

@end


#pragma mark “打卡”页面的实现
@implementation ClockIn
-(void)viewDidLoad{
    [super viewDidLoad];

    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:gradientLayer];
    gradientLayer.colors = @[(id)[UIColor whiteColor].CGColor, (id)[UIColor systemPinkColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.emptyNBar];
    [self.view addSubview:self.headNBar];
    [self.view addSubview:self.dateLabel];
    [self.view addSubview:self.dateText];
    [self.view addSubview:self.placeLabel];
    [self.view addSubview:self.placeText];
    [self.view addSubview:self.attractionsLabel];
    [self.view addSubview:self.attractionsText];
    [self.view addSubview:self.experienceLabel];
    [self.view addSubview:self.experienceText];
    [self.view addSubview:self.photoLabel];
    [self.view addSubview:self.picBtn1];
    [self.view addSubview:self.picBtn2];
    [self.view addSubview:self.picBtn3];
    [self.view addSubview:self.picBtn4];
    [self.view addSubview:self.picBtn5];
    [self.view addSubview:self.picBtn6];
    [self.view addSubview:self.makeRecord];
}

#pragma mark 最上面的两个bar
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
        [_headNBar pushNavigationItem:[[UINavigationItem alloc] initWithTitle:@"添加打卡"] animated:YES];
        _headNBar.backgroundColor = [UIColor whiteColor];
    }
    return _headNBar;
}

#pragma mark 时间的标签和输入
-(UILabel *) dateLabel{
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 120, 70, 40)];
        _dateLabel.text = @"时间";
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _dateLabel;
}

-(UITextField *)dateText{
    if(_dateText == nil){
        _dateText = [[UITextField alloc]initWithFrame:CGRectMake(100, 125, 250, 30)];
        _dateText.layer.borderWidth = 0.3;
        _dateText.layer.borderColor = [UIColor grayColor].CGColor;
        [_dateText setPlaceholder:@"单行输入"];
        [_dateText setTextColor:[UIColor blackColor]];
        [_dateText setSecureTextEntry:NO];
        [_dateText setKeyboardType:UIKeyboardTypeDefault];
        [_dateText setReturnKeyType:UIReturnKeyDone];
    }
    return _dateText;
}

#pragma mark 地点的标签和输入
-(UILabel *) placeLabel{
    if (_placeLabel == nil) {
        _placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 180, 70, 40)];
        _placeLabel.text = @"地点";
        _placeLabel.textAlignment = NSTextAlignmentLeft;
        _placeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _placeLabel;
}

-(UITextField *)placeText{
    if(_placeText == nil){
        _placeText = [[UITextField alloc]initWithFrame:CGRectMake(100, 185, 250, 30)];
        _placeText.layer.borderWidth = 0.3;
        _placeText.layer.borderColor = [UIColor grayColor].CGColor;
        [_placeText setPlaceholder:@"单行输入"];
        [_placeText setTextColor:[UIColor blackColor]];
        [_placeText setSecureTextEntry:NO];
        [_placeText setKeyboardType:UIKeyboardTypeDefault];
        [_placeText setReturnKeyType:UIReturnKeyDone];
    }
    return _placeText;
}

#pragma mark 旅游景点的标签和输入
-(UILabel *) attractionsLabel{
    if (_attractionsLabel == nil) {
        _attractionsLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 240, 70, 40)];
        _attractionsLabel.text = @"景点名称";
        _attractionsLabel.textAlignment = NSTextAlignmentLeft;
        _attractionsLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _attractionsLabel;
}


-(UITextField *)attractionsText{
    if(_attractionsText == nil){
        _attractionsText = [[UITextField alloc]initWithFrame:CGRectMake(100, 245, 250, 30)];
        _attractionsText.layer.borderWidth = 0.3;
        _attractionsText.layer.borderColor = [UIColor grayColor].CGColor;
        [_attractionsText setPlaceholder:@"单行输入"];
        [_attractionsText setTextColor:[UIColor blackColor]];
        [_attractionsText setSecureTextEntry:NO];
        [_attractionsText setKeyboardType:UIKeyboardTypeDefault];
        [_attractionsText setReturnKeyType:UIReturnKeyDone];
    }
    return _attractionsText;
}

#pragma mark 心得的标签和输入
-(UILabel *) experienceLabel{
    if (_experienceLabel == nil) {
        _experienceLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 300, 70, 40)];
        _experienceLabel.text = @"心得";
        _experienceLabel.textAlignment = NSTextAlignmentLeft;
        _experienceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _experienceLabel;
}

-(UITextView *) experienceText{
    if (_experienceText == nil) {
        _experienceText = [[UITextView alloc]initWithFrame:CGRectMake(100, 305, 250, 150)];
        _experienceText.layer.borderColor = [UIColor grayColor].CGColor;
        _experienceText.layer.borderWidth = 0.3;
        _experienceText.text = @"";
        _experienceText.backgroundColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0];
        [_experienceText setKeyboardType:UIKeyboardTypeDefault];
        [_experienceText setReturnKeyType:UIReturnKeyDone];
        // _placeholderLabel
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"多行输入";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = [UIColor lightGrayColor];
        [_experienceText addSubview:placeHolderLabel];
        [_experienceText setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    }
    return _experienceText;
}

#pragma mark 照片的标签和输入
-(UILabel *) photoLabel{
    if (_photoLabel == nil) {
        _photoLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 470, 70, 40)];
        _photoLabel.text = @"配图";
        _photoLabel.textAlignment = NSTextAlignmentLeft;
        _photoLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _photoLabel;
}

-(UIButton *)picBtn1{
    if (_picBtn1 == nil) {
        _picBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(60, 485, 100, 80)];
        [_picBtn1 setShowsTouchWhenHighlighted:NO];
        [_picBtn1.layer setBorderWidth:1.0];
        [_picBtn1.layer setBorderColor:[UIColor blackColor].CGColor];
        [_picBtn1 setImage:[UIImage imageNamed:@"增加灰色.png"] forState:UIControlStateNormal];
        [_picBtn1 setTag:1];
        [_picBtn1 addTarget:self action:@selector(selectphoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _picBtn1;
}

-(UIButton *)picBtn2{
    if (_picBtn2 == nil) {
        _picBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(170, 485, 100, 80)];
        [_picBtn2 setShowsTouchWhenHighlighted:NO];
        [_picBtn2.layer setBorderWidth:1.0];
        [_picBtn2.layer setBorderColor:[UIColor blackColor].CGColor];
        [_picBtn2 setImage:[UIImage imageNamed:@"增加灰色.png"] forState:UIControlStateNormal];
        [_picBtn2 setTag:2];
        [_picBtn2 addTarget:self action:@selector(selectphoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _picBtn2;
}

-(UIButton *)picBtn3{
    if (_picBtn3 == nil) {
        _picBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(280, 485, 100, 80)];
        [_picBtn3 setShowsTouchWhenHighlighted:NO];
        [_picBtn3.layer setBorderWidth:1.0];
        [_picBtn3.layer setBorderColor:[UIColor blackColor].CGColor];
        [_picBtn3 setImage:[UIImage imageNamed:@"增加灰色.png"] forState:UIControlStateNormal];
        [_picBtn3 setTag:3];
        [_picBtn3 addTarget:self action:@selector(selectphoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _picBtn3;
}


-(UIButton *)picBtn4{
    if (_picBtn4 == nil) {
        _picBtn4 = [[UIButton alloc]initWithFrame:CGRectMake(60, 575, 100, 80)];
        [_picBtn4 setShowsTouchWhenHighlighted:NO];
        [_picBtn4.layer setBorderWidth:1.0];
        [_picBtn4.layer setBorderColor:[UIColor blackColor].CGColor];
        [_picBtn4 setImage:[UIImage imageNamed:@"增加灰色.png"] forState:UIControlStateNormal];
        [_picBtn4 setTag:4];
        [_picBtn4 addTarget:self action:@selector(selectphoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _picBtn4;
}


-(UIButton *)picBtn5{
    if (_picBtn5 == nil) {
        _picBtn5 = [[UIButton alloc]initWithFrame:CGRectMake(170, 575, 100, 80)];
        [_picBtn5 setShowsTouchWhenHighlighted:NO];
        [_picBtn5.layer setBorderWidth:1.0];
        [_picBtn5.layer setBorderColor:[UIColor blackColor].CGColor];
        [_picBtn5 setImage:[UIImage imageNamed:@"增加灰色.png"] forState:UIControlStateNormal];
        [_picBtn5 setTag:5];
        [_picBtn5 addTarget:self action:@selector(selectphoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _picBtn5;
}


-(UIButton *)picBtn6{
    if (_picBtn6 == nil) {
        _picBtn6 = [[UIButton alloc]initWithFrame:CGRectMake(280, 575, 100, 80)];
        [_picBtn6 setShowsTouchWhenHighlighted:NO];
        [_picBtn6.layer setBorderWidth:1.0];
        [_picBtn6.layer setBorderColor:[UIColor blackColor].CGColor];
        [_picBtn6 setImage:[UIImage imageNamed:@"增加灰色.png"] forState:UIControlStateNormal];
        [_picBtn6 setTag:6];
        [_picBtn6 addTarget:self action:@selector(selectphoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _picBtn6;
}

#pragma mark 发布按钮的实现
-(UIButton *)makeRecord{
    if (_makeRecord == nil) {
        _makeRecord = [[UIButton alloc]initWithFrame:CGRectMake(320, 695, 60, 40)];
        [_makeRecord setShowsTouchWhenHighlighted:YES];
        [_makeRecord.layer setBorderWidth:1.0];
        [_makeRecord.layer setBorderColor:[UIColor blackColor].CGColor];
        NSString * aStr = @"发布";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:aStr];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]range:NSMakeRange(0,2)];
        [_makeRecord setAttributedTitle:str forState:UIControlStateNormal];
        [_makeRecord addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _makeRecord;
}

- (void)dismiss:(UIAlertController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 发布按钮按下后的弹窗
-(void)btnClick:(UIButton*)sender{
    if (self.delegae &&[self.delegae conformsToProtocol:@protocol(sender)]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
        NSDate *textDate = [dateFormatter dateFromString:_dateText.text];
        if (textDate == nil) {
            UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"输入(日期)格式非法" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertVc animated:NO completion:nil];
            [alertVc addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style: UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction*action) {NSLog(@"点击了取消按钮");}]];
            return;
        }
        _addarr = @[textDate,_placeText.text,_attractionsText.text,_experienceText.text,
                    _picBtn1.currentImage,_picBtn2.currentImage,_picBtn3.currentImage,
                    _picBtn4.currentImage,_picBtn5.currentImage,_picBtn6.currentImage];
        [self.delegae send:_addarr];//data

        UIAlertController *aleView=[UIAlertController alertControllerWithTitle:@"提示" message:@"成功打卡" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:aleView animated:YES completion:nil];
        [self performSelector:@selector(dismiss:) withObject:aleView afterDelay:0.5];
        Examine *examine = [[Examine alloc]init];
        examine.date = textDate;
        examine.place = _placeText.text;
        examine.attractions = _attractionsText.text;
        examine.experience = _experienceText.text;
        examine.photo1 = _picBtn1.currentImage;
        examine.photo2 = _picBtn2.currentImage;
        examine.photo3 = _picBtn3.currentImage;
        examine.photo4 = _picBtn4.currentImage;
        examine.photo5 = _picBtn5.currentImage;
        examine.photo6 = _picBtn6.currentImage;
        _dateText.text = @"";
        _placeText.text = @"";
        _attractionsText.text = @"";
        _experienceText.text = @"";
        [_picBtn1 setImage:[UIImage imageNamed:@"增加灰色.png"] forState:UIControlStateNormal];
        [_picBtn2 setImage:[UIImage imageNamed:@"增加灰色.png"] forState:UIControlStateNormal];
        [_picBtn3 setImage:[UIImage imageNamed:@"增加灰色.png"] forState:UIControlStateNormal];
        [_picBtn4 setImage:[UIImage imageNamed:@"增加灰色.png"] forState:UIControlStateNormal];
        [_picBtn5 setImage:[UIImage imageNamed:@"增加灰色.png"] forState:UIControlStateNormal];
        [_picBtn6 setImage:[UIImage imageNamed:@"增加灰色.png"] forState:UIControlStateNormal];
        [self addChildViewController:examine];
        
        CATransition *animation = [CATransition animation];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        animation.type = @"cube";
        animation.duration = 0.5;
        animation.subtype = kCATransitionFromBottom;
        [self.view.layer addAnimation:animation forKey:nil];
        
        [self.view addSubview:examine.view];
    }
}

#pragma mark 从系统中读取相册的实现
long picSelected;

-(void)selectphoto:(id)sender{
    picSelected = [sender tag];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.delegate =self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    switch (picSelected) {
        case 1:
            [self.picBtn1 setImage:image forState:UIControlStateNormal];
            break;
        case 2:
            [self.picBtn2 setImage:image forState:UIControlStateNormal];
            break;
        case 3:
            [self.picBtn3 setImage:image forState:UIControlStateNormal];
            break;
        case 4:
            [self.picBtn4 setImage:image forState:UIControlStateNormal];
            break;
        case 5:
            [self.picBtn5 setImage:image forState:UIControlStateNormal];
            break;
        case 6:
            [self.picBtn6 setImage:image forState:UIControlStateNormal];
            break;
        default:
            break;
    }

}
@end
