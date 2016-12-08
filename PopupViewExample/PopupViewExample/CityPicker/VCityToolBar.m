//
//  VCityToolBar.m
//  PopupViewExample
//
//  Created by Vols on 2015/12/8.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "VCityToolBar.h"

@implementation VCityToolBar

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = kRGBHex(0xF2F2F2);
        [self configureViews];
    }
    return self;
}

- (void)configureViews {
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:kRGBHex(0x666666) forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:kRGBHex(0x666666) forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [self addSubview:cancelBtn];
    [self addSubview:okBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(17);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-17);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    [cancelBtn addTarget:self action:@selector(clickCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [okBtn addTarget:self action:@selector(clickEnsureAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickCancelAction:(UIButton *)sender{
    if (self.cancelHandler) self.cancelHandler();
}

- (void)clickEnsureAction:(UIButton *)sender{
    if (self.okHandler) self.okHandler();
}

@end
