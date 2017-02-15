//
//  BasePopupView.m
//  PopupViewExample
//
//  Created by Vols on 2015/11/1.
//  Copyright © 2015年 hibor. All rights reserved.
//

#import "BasePopupView.h"
#import "Masonry.h"

#define kDefaultDuration    0.3

#define kRGBA(r, g, b, a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define kDIMMED_COLOR       kRGBA(0, 0, 0, 0.3)


@interface BasePopupView ()

@property (nonatomic, strong) UIView    * container;    //Pop的最底层容器
@property (nonatomic, strong) UIView    * overlayView;  //遮罩层
@property (nonatomic, assign) CGRect     selfFrame;  //遮罩层

@end

@implementation BasePopupView

#pragma mark - 初始化

- (id)init {
    if (self = [super init]) {
        _isHideOverLay = NO;                    // 默认显示遮罩层
        _isHideWhenTouchOverLay = YES;          // 默认点击遮罩层消失
        _animationType = PopTransitionTypeNone;  // 默认动画类型
        _attachedView = [UIApplication sharedApplication].keyWindow;    // 默认显示到UIWindow
        [self configureBasePopupUI];
    }
    return self;
}

- (void)configureBasePopupUI {
    [self.container addSubview:self.overlayView];
    [self.container addSubview:self];
    
    [_overlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.container);
    }];
}

#pragma mark - Public


- (void)show {
    [self showWithCompletion:nil];
}

- (void)showWithCompletion:(PopupCompletionBlock)block {
    self.showCompleteHandler = block;
    [self.attachedView addSubview:self.container];
    
    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.attachedView);
    }];
    
    [self.superview setNeedsLayout];
    [self.superview layoutIfNeeded];    //使约束生效，以便后边frame操作

    [self showAnimation];
}


- (void)hide {
    [self hideWithCompletion:nil];
}

- (void)hideWithCompletion:(PopupCompletionBlock)block {
    [self endEditing:YES];
    
    self.hideCompleteHandler = block;
    [self hideAnimation];
}


- (void)showAnimation {
    
    CGPoint ptCenter = CGPointMake(self.container.bounds.size.width / 2.0, self.container.bounds.size.height / 2.0);
    _selfFrame = self.frame;
    _overlayView.alpha = 0.0f;

    double dDuration = 0.2;
    switch (_animationType) {
        case PopTransitionTypeZoom:{
            self.alpha = 0.0;
            self.center = ptCenter;
            self.transform = CGAffineTransformMakeScale(0.05, 0.05);
        }
            break;
            
        case PopTransitionStyleTopDown:{
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, -self.bounds.size.height/2);
        }
            break;
            
        case PopTransitionStyleBottomUp:{
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height + self.bounds.size.height/2);
        }
            break;
            
        case PopTransitionStyleSheet:{
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height + self.bounds.size.height/2);
        }
            break;
            
        case PopTransitionStyleFade:{
            self.alpha = 0.0;
        }
            break;
            
        case PopTransitionStyleLine:{
            self.frame = CGRectMake(self.container.bounds.size.width / 2.0, self.container.bounds.size.height / 2.0, 1, 1);
            self.clipsToBounds = YES;
        }
            break;

            
        default:
            break;
    }
    
    
    [UIView animateWithDuration:dDuration animations:^{
        _overlayView.alpha = 1.0f;
        self.alpha = 1.0f;

        switch (_animationType) {
            case PopTransitionTypeNone:
                break;
                
            case PopTransitionStyleFade:
                self.alpha = 1.0;
                break;

            case PopTransitionTypeZoom:{
                self.alpha = 1.0;
                self.transform = CGAffineTransformMakeScale(1.05, 1.05);
            }
                break;
                
            case PopTransitionStyleBottomUp:
            case PopTransitionStyleTopDown:{
                self.alpha = 1.0f;
                self.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
            }
                break;
                
            case PopTransitionStyleSheet:{
                self.alpha = 1.0f;
                self.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height - _selfFrame.size.height/2);
                NSLog(@"%f", _selfFrame.size.height);
            }
                break;

            case PopTransitionStyleLine:
                self.frame = CGRectMake(_selfFrame.origin.x, self.container.bounds.size.height / 2.0, _selfFrame.size.width, 1);
                break;

            default:
                break;
        }
        
    } completion:^(BOOL finished) {
        
        if (_animationType == PopTransitionTypeZoom) {
            [UIView animateWithDuration:0.1 animations:^(void) {
                self.alpha = 1.0;
                self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        }
        if (_animationType == PopTransitionStyleLine) {
            [UIView animateWithDuration:0.2 animations:^(void) {
                [UIView setAnimationDelay:0.1];
                self.center = ptCenter;
                self.frame = _selfFrame;
            }];
        }
        
        if (self.showCompleteHandler) {
            self.showCompleteHandler(self, finished);
        }
    }];
}


- (void)hideAnimation {
    
    [UIView animateWithDuration:kDefaultDuration animations:^{
        switch (_animationType) {
            case PopTransitionTypeNone:
                break;
                
            case PopTransitionStyleFade:{
                self.alpha = 0.0;
                [UIView setAnimationDelay:0.2];
                self.overlayView.alpha = 0.0;
            }
                break;

            case PopTransitionTypeZoom:{
                self.transform = CGAffineTransformMakeScale(1.05, 1.05);
            }
                break;

            case PopTransitionStyleTopDown:{
                self.alpha = 1.0f;
                self.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height+self.bounds.size.height/2);
            }
                break;
                
            case PopTransitionStyleBottomUp:{
                self.alpha = 1.0f;
                self.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, -self.bounds.size.height/2);
            }
                break;

            case PopTransitionStyleLine:
                self.frame = CGRectMake(_selfFrame.origin.x, self.container.bounds.size.height / 2.0, _selfFrame.size.width, 1);
                break;

                
            default:
                break;
        }

    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^(void) {
            
            if (_animationType == PopTransitionTypeZoom) {
                [UIView setAnimationDelay:0.05];
                self.overlayView = 0;
                self.transform = CGAffineTransformMakeScale(0.05, 0.05);
                self.alpha = 0.0;
            }
            else if (_animationType == PopTransitionStyleLine) {
                [UIView animateWithDuration:0.2 animations:^(void) {
                    self.frame = CGRectMake(self.container.bounds.size.width / 2.0, self.container.bounds.size.height / 2.0, 1, 1);
                    [UIView setAnimationDelay:0.1];
                }];
            }

        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
                [self.container removeFromSuperview];
            }
            if (self.hideCompleteHandler)  self.hideCompleteHandler(self, finished);
        }];
    }];
}

#pragma mark - Setter

- (void)setIsHideOverLay:(BOOL)isHideOverLay {
    _isHideOverLay = isHideOverLay;
    
    if (_isHideOverLay) {
        _overlayView.backgroundColor = [UIColor clearColor];
    }
    else {
        _overlayView.backgroundColor = kDIMMED_COLOR;
    }
}

- (void)setIsHideWhenTouchOverLay:(BOOL)isHideWhenTouchOverLay {
    _isHideWhenTouchOverLay = isHideWhenTouchOverLay;
    if (!isHideWhenTouchOverLay) {
        self.overlayView.userInteractionEnabled = NO;
    }
    else {
        self.overlayView.userInteractionEnabled = YES;
    }
}


#pragma mark - Actions Methods

- (void)tapAction:(UITapGestureRecognizer *)recognizer {
    
    [self hide];
}

//代码方式适配横竖屏，
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    
//    self.container.frame = self.attachedView.bounds;
//    self.overlayView.frame = self.container.bounds;
//    self.center = self.container.center;
//}


#pragma mark - getter Methods

- (UIView *)container{
    
    if (_container == nil) {
        _container = [[UIView alloc] init];
        _container.backgroundColor = [UIColor clearColor];
    }
    return _container;
}


- (UIView *)overlayView{
    
    if (_overlayView == nil) {
        _overlayView = [[UIView alloc] init];
        _overlayView.backgroundColor = kDIMMED_COLOR;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_overlayView addGestureRecognizer:tapRecognizer];
    }
    return _overlayView;
}


@end
