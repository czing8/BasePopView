//
//  VImagePopupView.h
//  PopupViewExample
//
//  Created by Vols on 2017/6/22.
//  Copyright © 2017年 vols. All rights reserved.
//

#import "BasePopupView.h"

@interface VVImagePopupView : BasePopupView

@property (nonatomic, strong) NSString * imageString;

+ (VVImagePopupView *)showWithImage:(NSString *)imageString otherSettings:(void (^) (VVImagePopupView * popupView))otherSetting;

@end
