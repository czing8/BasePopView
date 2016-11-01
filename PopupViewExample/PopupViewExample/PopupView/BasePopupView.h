//
//  BasePopupView.h
//  PopupViewExample
//
//  Created by Vols on 2015/11/1.
//  Copyright © 2015年 hibor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BasePopupView;

typedef void(^PopupBlock)(BasePopupView *);
typedef void(^PopupCompletionBlock)(BasePopupView *, BOOL);

@interface BasePopupView : UIView

@property (nonatomic, strong) UIView         *attachedView;


- (void) show;
- (void) showWithCompletion:(PopupCompletionBlock)block;


- (void) hide;
- (void) hideWithCompletion:(PopupCompletionBlock)block;

@end
