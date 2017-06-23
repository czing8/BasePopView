//
//  VVRefreshPopView.h
//  PopupViewExample
//
//  Created by Vols on 2017/6/23.
//  Copyright © 2017年 vols. All rights reserved.
//

#import "BasePopupView.h"

typedef void(^ClickHandlerBlock) (NSUInteger selectedIndex);

@interface VVRefreshPopView : BasePopupView

@property (nonatomic, copy) ClickHandlerBlock clickHandler;

+ (VVRefreshPopView *)showWithSettings:(void (^) (VVRefreshPopView * popupView))otherSetting;

@end
