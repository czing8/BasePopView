//
//  TestPopupView.m
//  PopupViewExample
//
//  Created by Vols on 2016/11/1.
//  Copyright © 2016年 hibor. All rights reserved.
//

#import "TestPopupView.h"
#import "Masonry.h"

@implementation TestPopupView

#pragma mark - Public

+ (TestPopupView *)showWithSettings:(void (^) (TestPopupView * popupView))otherSetting {
    TestPopupView *popupMenu = [[TestPopupView alloc] init];
    if (otherSetting)  otherSetting(popupMenu);
    [popupMenu show];

    return popupMenu;
}

#pragma mark - Lifecycle

- (id)init{
    self = [super init];
    if (self) {
        
        [self configureViews];
    }
    return self;
}


- (void)configureViews{
    
//    self.isHideOverLay = YES;
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview).with.insets(UIEdgeInsetsMake(100, 50, 100, 50));
    }];
//    [self.superview setNeedsLayout];

    self.backgroundColor = [UIColor purpleColor];
}




@end
