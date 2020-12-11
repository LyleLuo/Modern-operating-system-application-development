//
//  ViewController.m
//  mosad_hw3
//
//  Created by luowle on 2020/12/9.
//  Copyright © 2020 luowle. All rights reserved.
//

#import "ViewController.h"
#import "NavigationControllers/Photo.h"
#import "NavigationControllers/Profile.h"

@interface ViewController ()

@property (nonatomic, strong) PhotoController *photoController;
@property (nonatomic, strong) ProfileController *profileController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewController:[self profile]];
    [self addChildViewController:[self photo]];
}

- (PhotoController *)photo {
    if (_photoController == nil) {
        _photoController = [[PhotoController alloc] init];
    }
    return _photoController;
}

- (ProfileController *)profile {
    if (_profileController == nil) {
        _profileController = [[ProfileController alloc] init];
    }
    return _profileController;
}

@end
