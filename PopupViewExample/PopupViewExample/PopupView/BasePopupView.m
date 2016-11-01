//
//  BasePopupView.m
//  PopupViewExample
//
//  Created by Vols on 2015/11/1.
//  Copyright © 2015年 hibor. All rights reserved.
//

#import "BasePopupView.h"
#import "Masonry.h"

#define kAnimationDuration  0.3
@interface BasePopupView ()

@property (nonatomic, strong) UIView    * container;
@property (nonatomic, strong) UIView    * overlayView;

@end

@implementation BasePopupView

- (id)init{
    self = [super init];
    if (self) {
        [self displayBasePopupUI];
    }
    return self;
}

- (void)displayBasePopupUI{
    
    [self.container addSubview:self.overlayView];
    [self.container addSubview:self];
    
    [_overlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.container);
    }];
}

#pragma mark - actions Methods

- (void) show {
    [self showWithCompletion:nil];
}

- (void)showWithCompletion:(PopupCompletionBlock)block{
    self.attachedView = [UIApplication sharedApplication].keyWindow;
    [self.attachedView addSubview:self.container];
    
    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.attachedView);
    }];
    
    [self setNeedsLayout];
    
    self.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.0f);
    self.alpha = 0.0f;
    
    [UIView animateWithDuration:kAnimationDuration
                          delay:0.0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         self.layer.transform = CATransform3DIdentity;
                         self.alpha = 1.0f;
                         
                     } completion:^(BOOL finished) {
                         if (block) {
                             block(self, finished);
                         }
                     }];
}


- (void)hide{
    [self hideWithCompletion:nil];
}

- (void)hideWithCompletion:(PopupCompletionBlock)block{
    [self endEditing:YES];
    
    [UIView animateWithDuration:kAnimationDuration
                          delay:0
                        options: UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         
                         if ( finished ) {
                             [self removeFromSuperview];
                             [self.container removeFromSuperview];
                         }
                         
                         if (block) {
                             block(self, YES);
                         }
                     }];
}


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
    
    if (!_container) {
        _container = [[UIView alloc] init];
        _container.backgroundColor = [UIColor clearColor];
    }
    return _container;
}


- (UIView *)overlayView{
    
    if (!_overlayView) {
        _overlayView = [[UIView alloc] init];
        _overlayView.alpha = 0.6;
        _overlayView.backgroundColor = [UIColor blackColor];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_overlayView addGestureRecognizer:tapRecognizer];
    }
    return _overlayView;
}


@end
