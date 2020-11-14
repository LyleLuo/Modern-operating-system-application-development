#pragma once
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Examine:UIViewController
@property (nonatomic, strong) UINavigationBar *headNBar;
@property (nonatomic, strong) UINavigationBar *emptyNBar;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UILabel *attractionsLabel;
@property (nonatomic, strong) UILabel *experienceLabel;
@property (nonatomic, strong) UIButton * picBtn1;
@property (nonatomic, strong) UIButton * picBtn2;
@property (nonatomic, strong) UIButton * picBtn3;
@property (nonatomic, strong) UIButton * picBtn4;
@property (nonatomic, strong) UIButton * picBtn5;
@property (nonatomic, strong) UIButton * picBtn6;
@property (nonatomic, strong) UIButton *returnBtn;
// 数据
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *place;
@property (nonatomic, strong) NSString *attractions;
@property (nonatomic, strong) NSString *experience;
@property (nonatomic, strong) UIImage *photo1;
@property (nonatomic, strong) UIImage *photo2;
@property (nonatomic, strong) UIImage *photo3;
@property (nonatomic, strong) UIImage *photo4;
@property (nonatomic, strong) UIImage *photo5;
@property (nonatomic, strong) UIImage *photo6;
@end

@protocol sender <NSObject>
-(void)send:(NSArray *)arr;
@end

@interface ClockIn:UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UINavigationBar *headNBar;
@property (nonatomic, strong) UINavigationBar *emptyNBar;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UITextField *dateText;
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UITextField *placeText;
@property (nonatomic, strong) UILabel *attractionsLabel;
@property (nonatomic, strong) UITextField *attractionsText;
@property (nonatomic, strong) UILabel *experienceLabel;
@property (nonatomic, strong) UITextView *experienceText;
@property (nonatomic, strong) UILabel *photoLabel;
@property (nonatomic, strong) UIButton * picBtn1;
@property (nonatomic, strong) UIButton * picBtn2;
@property (nonatomic, strong) UIButton * picBtn3;
@property (nonatomic, strong) UIButton * picBtn4;
@property (nonatomic, strong) UIButton * picBtn5;
@property (nonatomic, strong) UIButton * picBtn6;
@property (nonatomic, strong) UIButton * makeRecord;
@property (nonatomic,weak)id <sender> delegae;
@property (nonatomic, strong) NSArray * addarr;
@end
