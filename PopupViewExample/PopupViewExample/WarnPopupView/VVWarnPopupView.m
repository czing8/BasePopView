//
//  VVWarnPopupView.m
//  PopupViewExample
//
//  Created by Vols on 2017/6/22.
//  Copyright © 2017年 vols. All rights reserved.
//

#import "VVWarnPopupView.h"

@implementation VVWarnPopupView

#pragma mark - Public

+ (VVWarnPopupView *)showWithSettings:(void (^)(VVWarnPopupView *))otherSetting {
    VVWarnPopupView *popupMenu = [[VVWarnPopupView alloc] init];
    if (otherSetting)  otherSetting(popupMenu);
    [popupMenu show];
    
    return popupMenu;
}


#pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self configureViews];
    }
    return self;
}


- (void)configureViews{
    
    self.isHideOverLay = YES;
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview).offset(-64);
        make.left.right.top.equalTo(self.superview);
        make.height.mas_equalTo(64);
    }];
    //    [self.superview setNeedsLayout];
    
    self.backgroundColor = [UIColor purpleColor];
}



//重写showAnimation
- (void)showAnimation {
    
    [UIView animateWithDuration:1.0f
                          delay:0
         usingSpringWithDamping:0.3f
          initialSpringVelocity:6.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.center = CGPointMake(self.center.x, self.bounds.size.height/2);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

//重写dismissAnimation
- (void)dismissAnimation {
    [UIView animateWithDuration:0.3f
                          delay:0
         usingSpringWithDamping:0.99f
          initialSpringVelocity:8.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.center = CGPointMake(self.center.x, -self.bounds.size.height/2);
                     }
                     completion:^(BOOL finished) {
                         [self.superview removeFromSuperview];
                     }];
}


@end

