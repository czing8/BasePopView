//
//  TestPopupView.h
//  PopupViewExample
//
//  Created by Vols on 2016/11/1.
//  Copyright © 2016年 hibor. All rights reserved.
//

#import "BasePopupView.h"

/*
 *  继承自BasePopupView，只需要关注自身的视图元素。
 */
@interface TestPopupView : BasePopupView

+ (TestPopupView *)showWithSettings:(void (^) (TestPopupView * popupView))otherSetting;


@end
