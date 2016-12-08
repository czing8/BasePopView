//
//  VCityToolBar.h
//  PopupViewExample
//
//  Created by Vols on 2015/12/8.
//  Copyright © 2015年 vols. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^VPickerNoParamsBlock)();

@interface VCityToolBar : UIView

@property (nonatomic, copy) VPickerNoParamsBlock cancelHandler;
@property (nonatomic, copy) VPickerNoParamsBlock okHandler;

@end
