

#import "UIView+__Category.h"
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>

@interface UIView ()

@property (nonatomic, strong) NSNumber *__isShowNumber;

@end

@implementation UIView (__Category)

- (UIViewController *_Nonnull)__viewController{
    UIViewController *viewController = nil;
    UIResponder *next = self.nextResponder;
    while (next){
        if ([next isKindOfClass:[UIViewController class]]){
            viewController = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    }
    return viewController;
}

- (UIViewController *_Nonnull)__navigationController{
    if (self.__viewController == nil) {
        NSAssert(NO, @"view did not have viewController");
        return [[UIViewController alloc] init];
    }
    
    if (self.__viewController.navigationController == nil) {
        NSAssert(NO, @"view did not have nav viewController");
        return [[UIViewController alloc] init];
    }
    
    return self.__viewController.navigationController;
}

- (UIViewController *_Nonnull)__tabBarController{
    if (self.__viewController == nil) {
        NSAssert(NO, @"view did not have viewController");
        return [[UIViewController alloc] init];
    }
    
    if (self.__viewController.navigationController == nil) {
        NSAssert(NO, @"view did not have nav viewController");
        return [[UIViewController alloc] init];
    }
    
    if (self.__viewController.navigationController.tabBarController == nil) {
        NSAssert(NO, @"view did not have tabBar viewController");
        return [[UIViewController alloc] init];
    }
    
    return self.__viewController.navigationController.tabBarController;
}

- (CGRect)__rectFromWindow{
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [self convertRect:self.bounds toView:window];
    return rect;
}

- (void)__logViewHierarchy{
    NSString *description = [self _showViewHierarchyWithlevel:0];
    
    NSLog(@"%@", description);
}

- (void)__setCornerRadius:(CGSize)cornerRadii type:(UIRectCorner)corners{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (NSString *)_showViewHierarchyWithlevel:(NSInteger)level{
    NSMutableString * description = [NSMutableString string];
    NSMutableString * indent = [NSMutableString string];
    
    for (NSInteger i = 0; i < level; i++){
        [indent appendString:@"  |"];
    }
    
    [description appendFormat:@"\n%@%@", indent, [self description]];
    for (UIView * item in self.subviews){
        [description appendFormat:@"%@", [item _showViewHierarchyWithlevel:level + 1]];
    }
    
    return description.copy;
}

- (void)__setAntiAlias{
    self.layer.allowsEdgeAntialiasing = YES;
}

#pragma mark - 添加查看测试信息按钮
-(void)__addDebugInfoButtonToWindowWithRect:(CGRect)rect color:(UIColor *_Nonnull)color{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:rect];
    btn.backgroundColor = color;
    [btn setTitle:@"手机信息" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(touchInfoButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

-(void)touchInfoButton{
    /*
     a = 500
     b = 122
     c = SB
     d = ##$$
     timestamp = 145000
     systemType = 100001
     appVersion=1.0.8
     */
    //    NSDictionary *params = @{
    //                             @"a" : @"500",
    //                             @"b" : @"122",
    //                             @"c" : @"SB",
    //                             @"d" : @"##$$"
    //                             };
    //    [[XSApiManager sharedManager] requestCheckTokenWithParams:params completeHandle:^(BOOL result, id responseObj, NSError *error) {
    //        SSLog(@"responseObj = %@, result = %d, error = %@", responseObj, result, error);
    //    }];
    
    
    /// 系统版本号码
    NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
    /// UDID
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    /// 设备型号
    NSString *deviceModelName = [self deviceModelName];
    
    
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    // 获取App的版本号
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    // 获取App的build版本
    NSString *appBuildVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    // 获取App的名称
    NSString *appName = [infoDic objectForKey:@"CFBundleDisplayName"];
    
    NSString *IDFA = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    NSString *message = [NSString stringWithFormat:
                         @"仅用作测试版本使用!!\n\
                         App 名字: %@\n\
                         App 版本: %@(%@)\n\
                         手机型号: %@\n\
                         手机系统版本: %@\n\
                         手机UDID: %@\n\
                         IDFA : %@", appName, appVersion, appBuildVersion, deviceModelName, sysVersion, deviceUUID, IDFA];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"测试信息" message:message delegate:self cancelButtonTitle:@"我明白了" otherButtonTitles:nil, nil];
    [alertView show];
}

- (NSString*)deviceModelName{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone 系列
    if ([deviceModel isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceModel isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceModel isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    
    //iPod 系列
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad 系列
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceModel isEqualToString:@"iPad4,4"]
        ||[deviceModel isEqualToString:@"iPad4,5"]
        ||[deviceModel isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceModel isEqualToString:@"iPad4,7"]
        ||[deviceModel isEqualToString:@"iPad4,8"]
        ||[deviceModel isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceModel;
}

+ (instancetype _Nonnull)__viewFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (instancetype _Nullable)__viewFromXibWithViewIndex:(NSInteger)viewIndex {
    NSArray *xibViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil];
    if (xibViews.count > viewIndex) {
        return xibViews[viewIndex];
    }
    
    NSAssert(NO, @"view of viewIndex is null!!!");
    return nil;
}

#pragma mark - private method
- (void)set__isShowNumber:(NSNumber *)__isShowNumber {
    objc_setAssociatedObject(self, @selector(__isShowNumber), __isShowNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)__isShowNumber {
    return objc_getAssociatedObject(self, @selector(__isShowNumber));
}

- (BOOL)__isShow {
    return [[self __isShowNumber] boolValue];
}

- (void)set__isShow:(BOOL)__isShow {
    [self set__isShowNumber:@(__isShow)];
}

@end
