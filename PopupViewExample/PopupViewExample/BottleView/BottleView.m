//
//  BottleView.m
//  BottleView
//
//  Created by Vols on 15/12/3.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "BottleView.h"

#define  kScreenW  [UIScreen mainScreen].bounds.size.width
#define  kScreenH [UIScreen mainScreen].bounds.size.height

#define  kAdaptScale    kScreenW/320
#define  kBottleViewHeight   420*kAdaptScale


@interface BottleView ()

@property (nonatomic, strong) UIImageView * bgImgView;

@property (nonatomic, strong) UIView * menuBgView;
@property (nonatomic, strong) UIButton * throwBtn;
@property (nonatomic, strong) UIButton * myBottleBtn;

@property (nonatomic, strong) UIButton * closeBtn;


@end

@interface BottleOverlay : UIView

@end

@implementation BottleOverlay

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView * grayView = [[UIView alloc] initWithFrame:self.bounds];
        grayView.alpha = 0.2;
        grayView.backgroundColor = [UIColor blackColor];
        grayView.userInteractionEnabled = NO;
        [self addSubview:grayView];
        self.opaque = NO;
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *touched = [[touches anyObject] view];
    if (touched == self) {
        for (UIView *v in self.subviews) {
            if ([v isKindOfClass:[BottleView class]]
                && [v respondsToSelector:@selector(dismissView)]) {
                
                [v performSelector:@selector(dismissView) withObject:nil];
            }
        }
    }
}

@end


@implementation BottleView

- (id)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, kScreenH-kBottleViewHeight, kScreenW, kBottleViewHeight);
        self.backgroundColor = [UIColor brownColor];
        [self displayUI];
    }
    return self;
}


- (void)displayUI{
    [self addSubview:self.bgImgView];
    _bgImgView.backgroundColor = [UIColor blueColor];
    
    [self addSubview:self.menuBgView];
    [self addSubview:self.closeBtn];
}

- (void)showView{
    [self showBottleInView:[UIApplication sharedApplication].keyWindow];
    
}


#pragma mark - actions

- (void)showBottleInView:(UIView *)view{
    
    BottleOverlay *overlay = [[BottleOverlay alloc] initWithFrame:CGRectMake(0,0, kScreenW, kScreenH)];
    [overlay addSubview:self];
    [view addSubview:overlay];
//    overlay.backgroundColor = [UIColor orangeColor];
    overlay.alpha = 0.0;
    
    [UIView animateWithDuration:1 animations:^{
        overlay.alpha = 1.0;
        self.frame = CGRectMake(0, kScreenH-kBottleViewHeight, kScreenW, kBottleViewHeight);
        
    } completion:^(BOOL finished) {
        
    }];
    
//    self.transform = CGAffineTransformMakeScale(0.05, 0.05);
//    
//    double dDuration = 0.2;
//    
//    [UIView animateWithDuration:dDuration animations:^(void) {
//        
//        self.alpha = 1.0;
//        self.transform = CGAffineTransformMakeScale(1.05, 1.05);
//        
//    } completion:^(BOOL finished) {
//        
//        [UIView animateWithDuration:0.1 animations:^(void) {
//            self.alpha = 1.0;
//            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
//        }];
//    }];
}

- (void)dismissView{
    [self endEditing:YES];

    [UIView animateWithDuration:1 animations:^(void) {

        self.alpha = 0;
        self.superview.alpha = 0;
        self.frame = CGRectMake(0, kScreenH + kBottleViewHeight, kScreenW, kBottleViewHeight);
        
    } completion:^(BOOL finished) {
        if ([self.superview isKindOfClass:[BottleOverlay class]])
            [self.superview removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)throwBottleAction:(UIButton *)button{
   
}

- (void)myBottlesAction:(UIButton *)button{
    if (self.myBottlesClick) {
        self.myBottlesClick();
    }
}


#pragma mark - properites

- (UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.frame = self.bounds;
//        _bgImgView.image = [UIImage imageNamed:@""];
    }
    return _bgImgView;
}


- (UIView *)menuBgView{
    if (!_menuBgView) {
        _menuBgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 65, kScreenW, 65)];
        _menuBgView.backgroundColor = [UIColor clearColor];
        
        UIView * overlayView = [[UIView alloc] initWithFrame:_menuBgView.bounds];
        overlayView.alpha = 0.5;
        overlayView.backgroundColor = [UIColor blackColor];
        
        [_menuBgView addSubview:overlayView];
        [_menuBgView addSubview:self.throwBtn];
        [_menuBgView addSubview:self.myBottleBtn];
    }
    return _menuBgView;
}



- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(self.bounds.size.width - 100, 10, 80, 40);
        _closeBtn.backgroundColor = [UIColor redColor];
        [_closeBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}


- (UIButton *)throwBtn{
    
    if (!_throwBtn) {
        _throwBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _throwBtn.frame = CGRectMake(0, 0, 100, 60);
        _throwBtn.center = CGPointMake(kScreenW/4, _menuBgView.bounds.size.height/2);
        _throwBtn.backgroundColor = [UIColor redColor];
        [_throwBtn addTarget:self action:@selector(throwBottleAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _throwBtn;
}


- (UIButton *)myBottleBtn{
    
    if (!_myBottleBtn) {
        _myBottleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _myBottleBtn.frame = CGRectMake(0, 0, 100, 60);
        _myBottleBtn.center = CGPointMake(kScreenW - kScreenW/4, _menuBgView.bounds.size.height/2);
        _myBottleBtn.backgroundColor = [UIColor redColor];
        [_myBottleBtn addTarget:self action:@selector(myBottlesAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myBottleBtn;
}




@end
