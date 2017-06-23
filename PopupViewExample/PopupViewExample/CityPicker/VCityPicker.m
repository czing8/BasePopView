//
//  VCityPicker.m
//  PopupViewExample
//
//  Created by Vols on 2015/11/30.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "VCityPicker.h"
#import "VCityToolBar.h"
#import "Masonry.h"

#define kSCREEN_SIZE        [UIScreen mainScreen].bounds.size

@interface VCityPicker ()

@property (nonatomic, copy) NSArray *provinceArr;
@property (nonatomic, copy) NSArray *cityArr;
@property (nonatomic, copy) NSArray *countyArr;

@property (nonatomic, copy )  NSDictionary * areaDict;
@property (nonatomic, strong) VCityToolBar * toolBar;
@property (nonatomic, strong) NSDictionary * selectedDict;
@property (nonatomic, strong) UIPickerView * pickerView;

@end

@implementation VCityPicker

+ (VCityPicker *)pickerWithResultHandler:(void(^)(VCityModel *model))handler {

    VCityPicker * picker = [[VCityPicker alloc] init];
    picker.animationType = PopTransitionStyleSheet;
    picker.backgroundColor = [UIColor purpleColor];

    return picker;
}

- (id)init {
    if (self = [super init]) {
        [self initData];
        [self configureViews];
    }
    return self;
}

- (void)initData {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"areas.json" ofType:nil];
    NSData   * data = [NSData dataWithContentsOfFile:path];
    self.areaDict   = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.provinceArr = [self.areaDict allKeys];
    NSString *provinceStr = [self.provinceArr objectAtIndex:0];
    self.selectedDict = [self.areaDict objectForKey:provinceStr];
    [self calculateCityData:0 row:0];
}

- (void)configureViews {
    [self addSubview:self.toolBar];
    [self addSubview:self.pickerView];

    __weak typeof(self) weakself = self;
    
    _toolBar.cancelHandler = ^(){
        [weakself dismiss];
    };
    _toolBar.okHandler = ^(){
        [weakself dismiss];
        
        VCityModel *model = [VCityModel new];
        model.province = weakself.provinceArr[[weakself.pickerView selectedRowInComponent:0]];
        model.city = weakself.cityArr[[weakself.pickerView selectedRowInComponent:1]];
        model.county = weakself.countyArr[[weakself.pickerView selectedRowInComponent:2]];
        
        if (weakself.selectedHandler)   weakself.selectedHandler(model);
    };
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakself.superview);
        make.height.mas_equalTo(216);
    }];
    
    [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(weakself);
        make.height.mas_equalTo(40);
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_toolBar.mas_bottom);
        make.left.bottom.right.equalTo(weakself);
    }];
}

#pragma mark - Helpers
// 更新数据
- (void)calculateCityData:(NSInteger )section row:(NSInteger )row {
    if (section == 0) {
        if (self.provinceArr.count > row) {
            NSString *provinceStr = [self.provinceArr objectAtIndex:row];
            self.selectedDict = [self.areaDict objectForKey:provinceStr];
            self.cityArr = [self.selectedDict allKeys];
            NSString *countyStr = [self.cityArr firstObject];
            self.countyArr = [self.selectedDict objectForKey:countyStr];
        }
    }else if(section == 1) {
        if (self.cityArr.count>row) {
            NSString *countyStr = self.cityArr[row];
            self.countyArr = [self.selectedDict objectForKey:countyStr];
        }
    }
}


#pragma mark - Properties
- (VCityToolBar *)toolBar {
    if (_toolBar == nil) {
        _toolBar = [[VCityToolBar alloc] init];
    }
    return _toolBar;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [UIPickerView new];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
}


#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0)         return self.provinceArr.count;
    else if (component == 1)    return self.cityArr.count;
    else                        return self.countyArr.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    //    lable.font=[UIFont systemFontOfSize:13];
    if (component == 0) {
        label.text = [self.provinceArr objectAtIndex:row];
    } else if (component == 1) {
        label.text = [self.cityArr objectAtIndex:row];
    } else if(component == 2) {
        if (self.countyArr.count > row) {
            label.text = [self.countyArr objectAtIndex:row];
        }
    }
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return kSCREEN_SIZE.width/3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 41;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self calculateCityData:component row:row]; // 实时更新数据
    if (component == 0) {
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    
    if (component == 1) {
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
}

@end
