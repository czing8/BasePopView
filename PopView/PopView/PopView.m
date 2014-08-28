//
//  PopView.m
//  PopView
//
//  Created by Vols on 14-8-28.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import "PopView.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface PopView ()

@property (nonatomic, retain) UIButton * closeButton;
@property (nonatomic, retain) UILabel * contentLabel;

@property (nonatomic, retain) UIButton * lastButton;

@property (nonatomic, retain) UIView * contentView;

@end

@implementation PopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.3;
        [self addSubview:bgView];
        
        [self displayUI];
    }
    return self;
}



- (void)displayUI{
    
    [self addSubview:self.contentView];
    
    [_contentView addSubview:self.closeButton];
    [_contentView addSubview:self.contentLabel];
    
    [self addMenuButtons];
}

- (void)addMenuButtons{
    
    NSArray * titles = @[@"Startup", @"Personal"];
    NSArray * normalImages = @[@"btn_startups_normal", @"btn_personal_normal"];
    NSArray * selectedImages = @[@"btn_startups_checked", @"btn_personal_checked"];
    
    for (int i = 0; i < 2; i ++) {
        
        CGRect frame = (i == 0) ? CGRectMake(45, 80, 70, 70):CGRectMake(300-45-70, 80, 70, 70);
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = frame;
        button.tag = 1010 + i;
        [button setBackgroundImage:[UIImage imageNamed:normalImages[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:selectedImages[i]] forState:UIControlStateHighlighted];
        
        button.backgroundColor = RGBCOLOR(241, 241, 241);
        button.layer.cornerRadius = 36.0;
        [button addTarget:self action:@selector(clickMenuButton:) forControlEvents: UIControlEventTouchUpInside];
        [_contentView addSubview:button];
        
        frame = CGRectMake(0, 0, 100, 30);
        UILabel * label = [[UILabel alloc] initWithFrame:frame];
        label.center = (CGPoint){button.center.x, button.frame.origin.y + button.frame.size.height + 10};
        label.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
        label.textColor = RGBCOLOR(155, 155, 155);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = titles[i];
        label.backgroundColor = [UIColor clearColor];
        [_contentView addSubview:label];
    }
}

#pragma mark - properties

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 120, 300, 210)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 5.0;
    }
    return _contentView;
}

- (UIButton *)closeButton{
    if (!_closeButton) {
        UIImage * closeImage = [UIImage imageNamed:nil];
        
        _closeButton= [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(10, 10, closeImage.size.width, closeImage.size.height);
        _closeButton.backgroundColor = [UIColor clearColor];
        [_closeButton setBackgroundImage:closeImage forState:UIControlStateNormal];
        
        [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        CGRect frame = CGRectMake(0, 0, 300, 20);
        _contentLabel = [[UILabel alloc] initWithFrame:frame];
        _contentLabel.center = (CGPoint){self.center.x - 10, 40};
        _contentLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
        _contentLabel.textColor = RGBCOLOR(155, 155, 155);
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.text = @"Choose your identity into the Disrupt";
        _contentLabel.backgroundColor = [UIColor clearColor];
    }
    return _contentLabel;
}


#pragma mark - actions

- (void)closeAction:(UIButton *)button{
    [self removeFromSuperview];
}


- (void)clickMenuButton:(UIButton *)button{
    
    if (_lastButton != button) {
        _lastButton.selected = NO;
    }
    
    if (!button.selected) {
        
        button.selected = YES;
    }
    else {
        button.selected = NO;
    }
    
    _lastButton= button;
    button.selected = YES;
    
    [self removeFromSuperview];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
