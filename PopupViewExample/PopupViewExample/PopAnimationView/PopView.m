//
//  PopView.m
//  PopAnimation
//
//  Created by Vols on 14-7-25.
//  Copyright (c) 2014年 Vols. All rights reserved.
//

#import "PopView.h"
#import "UIImage+ResizeMagick.h"


#pragma mark - PopViewController

@interface PopViewController : UIViewController

@property (nonatomic, strong) PopView *popView;

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = _popView;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [UIApplication sharedApplication].statusBarStyle;
}

@end


@interface PopView() {
    UIWindow                *_popWindow;
}
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UIImageView * imageView;

@end;

@implementation PopView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)showPopView {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.imageView];
    
    _contentView.frame = (CGRect){0, 0, self.imageView.bounds.size.width, self.imageView.bounds.size.height};
    _imageView.center = (CGPoint){_contentView.bounds.size.width/2, _contentView.bounds.size.height/2};
    
    PopViewController * popVC = [[PopViewController alloc] init];
    popVC.popView = self;
    
    if (!_popWindow) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        window.opaque = NO;
        window.windowLevel = UIWindowLevelAlert;
        window.rootViewController = popVC;
        _popWindow = window;
        
        self.frame = window.frame;
        _contentView.center = window.center;
    }

    [_popWindow makeKeyAndVisible];
    
    [self showAnimation];

    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hideAnimation) userInfo:nil repeats:NO];
}

- (void)showAnimation {
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    self.alpha = 0.0;
    
    _contentView.alpha = 0.0;
    _contentView.center = center;
    _contentView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    
    double dDuration = 0.2;

    [UIView animateWithDuration:dDuration animations:^(void) {
        
        self.alpha = 1.0;
        _contentView.alpha = 1.0;
        _contentView.transform = CGAffineTransformMakeScale(1.05, 1.05);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^(void) {
                    _contentView.alpha = 1.0;
                    _contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}



- (void)hideAnimation {
    double dDuration = 0.1;

    [UIView animateWithDuration:dDuration animations:^(void) {
        _contentView.transform = CGAffineTransformMakeScale(1.05, 1.05);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^(void) {
    
                    [UIView setAnimationDelay:0.05];
                    self.alpha = 0.0;
                    _contentView.transform = CGAffineTransformMakeScale(0.05, 0.05);
                    _contentView.alpha = 0.0;
          
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [_popWindow removeFromSuperview];
            _popWindow = nil;
        }];
    }];
}


#pragma mark - properties

- (UIView *)contentView {
    if (!_contentView) {
        _contentView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 0)];
        
    }
    return _contentView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        UIImage *resizedImage = [_image resizedImageWithMaximumSize:CGSizeMake(360, 360)];
        _imageView = [[UIImageView alloc] initWithImage:resizedImage];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.frame = CGRectMake(0, 0, resizedImage.size.width / 2, resizedImage.size.height / 2);
        _imageView.center = CGPointMake(self.center.x, self.center.y);
        _imageView.backgroundColor = [UIColor clearColor];
        self.bounds = _imageView.bounds;
    }
    return _imageView;
}

@end
