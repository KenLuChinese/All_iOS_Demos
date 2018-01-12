//
//  ImgeViewController.m
//  iOS_ALL_Demo
//
//  Created by Ken on 2017/12/30.
//  Copyright © 2017年 Ken lu. All rights reserved.
//

#import "ImgeViewController.h"

@interface ImgeViewController ()
<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImage  *pointImage;
@property (nonatomic, strong) UIImageView  *originImageView;
@property (nonatomic, strong) UIImageView  *insetsMethod_ImageView;
@property (nonatomic, strong) UIImageView  *pointMethod_ImageView;

@end

@implementation ImgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initUI];
    [self _insetsMethod];
    [self _pointMethod];
}

- (void)_insetsMethod{
//    self.insetsMethod_ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 100)];
    self.insetsMethod_ImageView.backgroundColor = [UIColor lightGrayColor];
    UIImage *imgLogin = [UIImage imageNamed:@"Personal_auto_voice"];
    
    /// 方法第一个参数是指图片的左边界到拉伸点的距离, 带二个参数是图片顶部到拉伸点的距离
    imgLogin = [imgLogin stretchableImageWithLeftCapWidth:floorf(70.0) topCapHeight:floorf(30.0)];
    self.insetsMethod_ImageView.image = imgLogin;
    
    return;
    
    CGFloat imageWidth = self.pointImage.size.width;
    CGFloat imageHeight = self.pointImage.size.height;
    UIEdgeInsets insets = UIEdgeInsetsMake(imageHeight*0.5, imageWidth*0.5, imageHeight*0.5-1, imageWidth*0.5-1);
    /// !!!: insets method
    self.pointImage = [self.pointImage __resizableImage:insets];
    self.insetsMethod_ImageView.image = self.pointImage;
}

- (void)_pointMethod{
    CGFloat imageWidth = self.pointImage.size.width;
    CGFloat imageHeight = self.pointImage.size.height;
    CGPoint centerPoint = CGPointMake(imageWidth*0.5, imageHeight*0.5);
    /// !!!: point method
    self.pointImage = [self.pointImage __resizableImageWithPoint:centerPoint];
    self.pointMethod_ImageView.image = self.pointImage;
}

#pragma mark - init UI
- (void)_initUI{
    self.originImageView.frame = CGRectMake(0.0, 64.0, __ScreenWidth, 100.0);
    self.originImageView.image = self.pointImage;
    [self.view addSubview:self.originImageView];
    
    self.insetsMethod_ImageView = [[UIImageView alloc] init];
    self.insetsMethod_ImageView.frame = CGRectMake(0.0, 174.0, __ScreenWidth, 100.0);
    [self.view addSubview:self.insetsMethod_ImageView];
    
    self.pointMethod_ImageView = [[UIImageView alloc] init];
    self.pointMethod_ImageView.frame = CGRectMake(0.0, 284.0, __ScreenWidth, 100.0);
    [self.view addSubview:self.pointMethod_ImageView];
}

#pragma mark - lazy load
- (UIImage *)pointImage{
    if (_pointImage == nil) {
        _pointImage = [UIImage imageNamed:@"Personal_auto_voice"];
    }
    return _pointImage;
}

- (UIImageView *)originImageView{
    if (_originImageView == nil) {
        _originImageView = [[UIImageView alloc] init];
    }
    return _originImageView;
}

- (UIImageView *)insetsMethod_ImageView{
    if (_insetsMethod_ImageView == nil) {
        _insetsMethod_ImageView = [[UIImageView alloc] init];
    }
    return _insetsMethod_ImageView;
}

- (UIImageView *)pointMethod_ImageView{
    if (_pointMethod_ImageView == nil) {
        _pointMethod_ImageView = [[UIImageView alloc] init];
    }
    return _pointMethod_ImageView;
}

@end
