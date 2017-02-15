//
//  VCityPicker.h
//  PopupViewExample
//
//  Created by Vols on 2015/11/30.
//  Copyright © 2015年 vols. All rights reserved.
//  省市县三级

#import "BasePopupView.h"
#import "VCityModel.h"

@interface VCityPicker : BasePopupView <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, copy) void(^selectedHandler)(VCityModel *model);

+ (VCityPicker *)pickerWithResultHandler:(void(^)(VCityModel *model))handler;

@end
