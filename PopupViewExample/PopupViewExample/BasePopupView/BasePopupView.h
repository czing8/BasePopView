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

/*
 *  BasePopupView，处理与具体视图不相关的操作，比如弹出消失动画。只需要继承后关注自身的元素。
 */
@interface BasePopupView : UIView

@property (nonatomic, strong) UIView    *attachedView;

- (void) show;
- (void) showWithCompletion:(PopupCompletionBlock)block;


- (void) hide;
- (void) hideWithCompletion:(PopupCompletionBlock)block;

@end
