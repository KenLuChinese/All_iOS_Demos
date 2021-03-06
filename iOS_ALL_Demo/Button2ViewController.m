//
//  Button2ViewController.m
//  iOS_ALL_Demo
//
//  Created by Ken_lu on 2018/1/4.
//  Copyright © 2018年 Ken lu. All rights reserved.
//

#import "Button2ViewController.h"

@interface Button2ViewController ()

@property (nonatomic, strong) UIButton  *roundBtn;

@end

@implementation Button2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * roundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [roundBtn setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-60)/2, 200, 60, 60)];
    [roundBtn setBackgroundColor:[UIColor blueColor]];
    
    roundBtn.__string = @"__string";
    roundBtn.__object = @"__object";
    roundBtn.__isShow = NO;
    [roundBtn addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:roundBtn];
    _roundBtn = roundBtn;
    
    UILongPressGestureRecognizer * longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesture:)];
    [roundBtn addGestureRecognizer:longGesture];
}

- (void)touchButton:(UIButton *)button {
    DEBUGLOG(@"button.__string == %@", button.__string);
    DEBUGLOG(@"button.__object == %@", button.__object);
    DEBUGLOG(@"button.__isShow == %d", button.__isShow);
}

-(void)longGesture:(UILongPressGestureRecognizer *)gesture{
    int sendState = 0;
    CGPoint  point = [gesture locationInView:_roundBtn];
    
    if (point.y<0){
        DEBUGLOG(@"已移动到按钮区域以外，松开手指会取消发送");
        sendState = 1;
    }
    else{
        //重新进入长按录音范围内
        DEBUGLOG(@"重新进入长按录音范围内");
        sendState = 0;
    }
    
    //手势状态
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            DEBUGLOG(@"这里开始录音");
        }
            break;
            
        case UIGestureRecognizerStateEnded:{
            if (sendState == 0){
                DEBUGLOG(@"结束录音并发送录音");
            }
            else{
                //向上滑动取消发送
                DEBUGLOG(@"取消发送删除录音");
            }
        }
            break;
            
        case UIGestureRecognizerStateFailed:
            DEBUGLOG(@"长按手势失败");
            break;
            
        default:
            break;
    }
}

@end
