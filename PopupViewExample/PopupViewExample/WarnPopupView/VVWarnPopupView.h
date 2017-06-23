//
//  VVWarnPopupView.h
//  PopupViewExample
//
//  Created by Vols on 2017/6/22.
//  Copyright © 2017年 vols. All rights reserved.
//

#import "BasePopupView.h"

@interface VVWarnPopupView : BasePopupView

+ (VVWarnPopupView *)showWithSettings:(void (^) (VVWarnPopupView * dropMenu))otherSetting;


@end
