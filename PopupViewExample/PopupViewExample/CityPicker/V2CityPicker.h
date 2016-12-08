//
//  V2CityPicker.h
//  PopupViewExample
//
//  Created by Vols on 2015/12/8.
//  Copyright © 2015年 vols. All rights reserved.
//  省市二级

#import "BasePopupView.h"

@interface V2CityPicker : BasePopupView <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, copy) void(^selectedHandler)(NSString *cityString);

@end
