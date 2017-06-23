//
//  BasePopupView.h
//  PopupViewExample
//
//  Created by Vols on 2015/11/1.
//  Copyright © 2015年 hibor. All rights reserved.
//

/***********************************
 *  BasePopupView，处理与具体视图不相关的操作，比如弹出消失动画。只需要继承后关注自身的元素。
 *  
 *  使用masonry约束
 *
 ***********************************/


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PopAnimationType) {
    PopTransitionTypeNone,
    PopTransitionTypeZoom,
    PopTransitionStyleSheet,
    PopTransitionStyleLine,
    PopTransitionStyleFade,
    PopTransitionStyleTopDown,
    PopTransitionStyleBottomUp,
};


@class BasePopupView;

typedef void(^PopupBlock)(BasePopupView *);
typedef void(^PopupCompletionBlock)(BasePopupView *, BOOL);

@interface BasePopupView : UIView

@property (nonatomic, strong) UIView    *attachedView;
@property (nonatomic, assign) BOOL      isHideOverLay;              // 是否隐藏遮罩层，默认为NO
@property (nonatomic, assign) BOOL      isHideWhenTouchOverLay;     // 点击遮罩层隐藏
@property (nonatomic, assign) PopAnimationType      animationType;  // 出现消失动画类型
@property (nonatomic,   copy) PopupCompletionBlock  showCompleteHandler;
@property (nonatomic,   copy) PopupCompletionBlock  dismissCompleteHandler;


- (void) show;
- (void) showWithCompletion:(PopupCompletionBlock)block;


- (void) dismiss;
- (void) dismissWithCompletion:(PopupCompletionBlock)block;


/*
 *  子类中可重写动画，会覆盖掉BasePopupView动画
 */
- (void)showAnimation;
- (void)dismissAnimation;

@end
