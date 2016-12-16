//
//  ShowAlertView.m
//  Enginner
//
//  Created by Azul-sea on 15/10/9.
//  Copyright © 2015年 wk-iOS. All rights reserved.
//

#import "ShowAlertView.h"

#define FontOfContentText 16.0f

@interface ShowAlertView ()<CAAnimationDelegate>
{
    
    BOOL isShowAlert;
    CGAffineTransform rotationTransform;
}

@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic) CGRect superFrame;
@property (nonatomic, copy) NSMutableString *contentStr;
@property (nonatomic) UIViewController *objectClass;
@property (nonatomic, assign) UIWindow *pWindow;
@property (nonatomic) UIView *objectView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ShowAlertView
#pragma mark - System Method
//pType == 1(like Andriod)
+ (id)initializeAlertViewWithFrame:(CGRect)frame Message:(NSString *)pMessage customType:(NSUInteger)pType Class:(id)objectClass{
    
    static ShowAlertView *alertView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertView = [[ShowAlertView alloc] init];
        alertView.tag = 99;
        alertView.userInteractionEnabled = NO;
        alertView.backgroundColor = [UIColor blackColor];
        //alertView.alpha = 0.7f;
        alertView.layer.cornerRadius = 5;
        alertView.layer.masksToBounds = YES;
        alertView.layer.borderColor = [UIColor blackColor].CGColor;
        alertView.layer.borderWidth = 0.0f;
        [alertView setupViewControl];
    });
    
    if (frame.size.width > 0) {
        alertView.superFrame = frame;
    }else{
        alertView.superFrame = [[UIApplication sharedApplication].delegate window].frame;
    }
    if (pMessage && pMessage.length>0) {
        [alertView.contentStr setString:pMessage];
    }else{
        [alertView.contentStr setString:@"default message！"];
    }
    if (objectClass) {
        if ([objectClass isKindOfClass:[UIViewController class]]) {
            alertView.objectView = nil;
            alertView.pWindow = nil;
            alertView.objectClass = (UIViewController *)objectClass;
        }else if ([objectClass isKindOfClass:[UIView class]]) {
            alertView.objectClass = nil;
            alertView.pWindow = nil;
            alertView.objectView = (UIView *)objectClass;
        }
    }else{
        alertView.objectView = nil;
        alertView.objectClass = nil;
        alertView.pWindow = [UIApplication sharedApplication].keyWindow;
    }
    //update UI config
    [alertView updateUIConfig];
    return alertView;
}
#pragma mark - Custom Method
- (void)updateUIConfig
{
    
    CGSize contentSize = [self heightOfAlertView];
    
    CGRect rect;
    rect = CGRectMake(0, 0, contentSize.width+20, contentSize.height);
    self.frame = rect;
    
    rect = CGRectMake(10, 2, contentSize.width, contentSize.height);
    _contentTextView.frame = rect;
    _contentTextView.text = _contentStr;
    
    CGPoint pt;
    if (_objectClass && !_objectView) {
        pt = _objectClass.view.center;
    }else if (_objectView && !_objectClass) {
        pt = _objectView.center;
    }else if (!_objectClass && !_objectView && _pWindow) {
        pt = _pWindow.center;
    }else{
        
        return;
    }
    self.center = pt;
}
//计算高度
- (CGSize)heightOfAlertView{
    
    CGSize contentSize = {0, 0};
    NSInteger contentWidth = _superFrame.size.width-20;
    UIFont *cFont = [UIFont systemFontOfSize:FontOfContentText];
    if (!_contentStr && _contentStr.length <= 0) {
        if (!_contentStr) {
            _contentStr = [[NSMutableString alloc] initWithString:@""];
        }
        [_contentStr setString:@"falure to show"];
        return CGSizeMake(contentWidth, 10+FontOfContentText);
    }
    
    NSDictionary *attribute_Content = @{NSFontAttributeName:cFont};
    contentSize = [_contentStr boundingRectWithSize:CGSizeMake(contentWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute_Content context:nil].size;
    CGSize lastSize = CGSizeMake(contentSize.width+10, contentSize.height+6);
    CGSize sz = lastSize;
    sz.height = sz.height>(Screen_Height-40)?(Screen_Height-40):sz.height;
    
    return sz;
}

- (void)addAlertView{
    
    if (isShowAlert) {
        [self stopAnimation];
        [self beginAnimation];
    }else{
        [self beginAnimation];
    }
}
- (void)beginAnimation{
    isShowAlert = YES;
    if (_objectClass && !_objectView) {
        [_objectClass.view addSubview:self];
    }else if (_objectView && !_objectClass) {
        [_objectView addSubview:self];
    }else if (!_objectView && !_objectClass && _pWindow) {
        [_pWindow addSubview:self];
    }
    else{
        return;
    }
    CABasicAnimation * animation=[CABasicAnimation  animationWithKeyPath:@"opacity"];
    //Set the transparency of the minimum value
    [animation setFromValue:[NSNumber numberWithFloat:1.0f]];
    //Set the maximum transparency
    [animation setToValue:[NSNumber numberWithInt:0.0f]];
    //Play speed
    [animation setDuration:2.0f];
    //play count(0：many times        只执行1次)
    //[animation setRepeatCount:1.0];
    [animation setDelegate:self];
    //动画结束时自动移除
    [animation setRemovedOnCompletion:YES];
    
    [animation setAutoreverses:YES];//默认的是NO，即透明完毕后立马恢复，YES是延迟恢复
    [self.layer addAnimation:animation forKey:@"img-opacity"];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:animation.duration target:self selector:@selector(targetMethod) userInfo:nil repeats:NO];
}
- (void)targetMethod{//remove animation
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    isShowAlert = NO;
    [self removeFromSuperview];
}
- (void)stopAnimation{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    isShowAlert = NO;
    [self.layer removeAllAnimations];
}
#pragma mark - animate delegate

#pragma mark - initialize
- (void)setupViewControl{
    
    isShowAlert = NO;
    _contentStr = [[NSMutableString alloc] initWithString:@""];

    _contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.frame)-20, CGRectGetHeight(self.frame)-3)];
    _contentTextView.backgroundColor = [UIColor clearColor];
    _contentTextView.userInteractionEnabled = NO;
    _contentTextView.scrollEnabled = NO;
    _contentTextView.editable = NO;
    _contentTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _contentTextView.text = @"";
    _contentTextView.textAlignment = NSTextAlignmentCenter;
    _contentTextView.textColor = [UIColor whiteColor];
    _contentTextView.font = [UIFont systemFontOfSize:FontOfContentText];
    
    [self addSubview:_contentTextView];
}
@end
