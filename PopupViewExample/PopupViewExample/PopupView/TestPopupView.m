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

- (id)init{
    self = [super init];
    if (self) {
        
        [self displayUI];
    }
    return self;
}


- (void)displayUI{
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview).with.insets(UIEdgeInsetsMake(100, 50, 100, 50));
    }];
    
    self.backgroundColor = [UIColor purpleColor];
}
@end
