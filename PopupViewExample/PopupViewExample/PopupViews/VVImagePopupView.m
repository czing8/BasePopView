//
//  VImagePopupView.m
//  PopupViewExample
//
//  Created by Vols on 2017/6/22.
//  Copyright © 2017年 vols. All rights reserved.
//

#import "VVImagePopupView.h"
#import "UIImage+ResizeMagick.h"

@interface VVImagePopupView ()

@property (nonatomic, strong) UIImageView * imageView;

@end


@implementation VVImagePopupView

#pragma mark - Public

+ (VVImagePopupView *)showWithImage:(NSString *)imageString otherSettings:(void (^) (VVImagePopupView * popupView))otherSetting {
    
    VVImagePopupView *popupMenu = [[VVImagePopupView alloc] init];
    popupMenu.imageString = imageString;
    
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
        make.centerX.equalTo(self.superview);
        make.centerY.equalTo(self.superview);
        make.size.mas_equalTo(CGSizeMake(180, 180));
    }];
    
    [self addSubview:self.imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    //    [self.superview setNeedsLayout];
    
    self.backgroundColor = [UIColor clearColor];
}


- (void)setImageString:(NSString *)imageString {
    
    if (imageString == nil) {
        return;
    }
    
    _imageString = imageString;
    
    UIImage * image = [UIImage imageNamed:imageString];
    UIImage *resizedImage = [image resizedImageWithMaximumSize:CGSizeMake(360, 360)];
    self.imageView.image = resizedImage;
}

#pragma mark - Properties

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (void)showAnimation {
    CGPoint center = CGPointMake(self.superview.bounds.size.width / 2.0, self.superview.bounds.size.height / 2.0);

    self.alpha = 0.0;
    self.center = center;
    self.transform = CGAffineTransformMakeScale(0.05, 0.05);

    double dDuration = 0.2;

    [UIView animateWithDuration:dDuration animations:^(void) {
        
        self.alpha = 1.0;
        self.alpha = 1.0;
        self.transform = CGAffineTransformMakeScale(1.05, 1.05);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^(void) {
            self.alpha = 1.0;
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}



- (void)dismissAnimation {
    double dDuration = 0.1;
    
    [UIView animateWithDuration:dDuration animations:^(void) {
        self.transform = CGAffineTransformMakeScale(1.05, 1.05);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^(void) {
            
            [UIView setAnimationDelay:0.05];
            self.alpha = 0.0;
            self.transform = CGAffineTransformMakeScale(0.05, 0.05);
            self.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            [self.superview removeFromSuperview];
        }];
    }];
}

@end
