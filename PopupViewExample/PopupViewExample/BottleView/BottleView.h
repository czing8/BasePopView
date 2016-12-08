//
//  BottleView.h
//  BottleView
//
//  Created by Vols on 15/12/3.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ThrowBottleClickBlock) (NSString * bottleText);
typedef void(^MyBottlesClickBlock) ();

@interface BottleView : UIView

@property (nonatomic, copy) ThrowBottleClickBlock throwBottleClick;
@property (nonatomic, copy) MyBottlesClickBlock myBottlesClick;

- (void)showView;

- (void)dismissView;

@end
