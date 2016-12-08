//
//  BasePopupView.h
//  PopupViewExample
//
//  Created by Vols on 2015/11/1.
//  Copyright © 2015年 hibor. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PopAnimationType) {
    PopAnimationTypeNone,
    PopAnimationTypeFade,
};

@class BasePopupView;

typedef void(^PopupBlock)(BasePopupView *);
typedef void(^PopupCompletionBlock)(BasePopupView *, BOOL);

/*
 *  BasePopupView，处理与具体视图不相关的操作，比如弹出消失动画。只需要继承后关注自身的元素。
 */
@interface BasePopupView : UIView

@property (nonatomic, strong) UIView    *attachedView;
@property (nonatomic, assign) BOOL      isHideOverLay;  //是否隐藏遮罩层，默认为NO

@property (nonatomic, assign) PopAnimationType      animationType;  //是否隐藏遮罩层，默认为NO

@property (nonatomic,   copy) PopupCompletionBlock  showCompleteHandler;
@property (nonatomic,   copy) PopupCompletionBlock  hideCompleteHandler;


- (void) show;
- (void) showWithCompletion:(PopupCompletionBlock)block;


- (void) hide;
- (void) hideWithCompletion:(PopupCompletionBlock)block;


- (void)showAnimation;
- (void)hideAnimation;

@end
