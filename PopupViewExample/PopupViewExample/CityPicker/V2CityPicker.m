//
//  V2CityPicker.m
//  PopupViewExample
//
//  Created by Vols on 2015/12/8.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "V2CityPicker.h"

#import "VProvinceModel.h"
#import "VCityToolBar.h"
#import "Masonry.h"

#define kSCREEN_SIZE        [UIScreen mainScreen].bounds.size

@interface V2CityPicker ()

@property (nonatomic, strong) VCityToolBar  * toolBar;
@property (nonatomic, strong) UIPickerView  * pickerView;

@property (nonatomic, strong) NSMutableArray *cities;   //数据源
@property (nonatomic, strong) VProvinceModel* selectedProvince;
@property (nonatomic, strong) NSString      * theResult;

@end

@implementation V2CityPicker

- (id)init {
    if (self = [super init]) {
        [self configureViews];
    }
    return self;
}

- (void)configureViews {
    self.backgroundColor = [UIColor purpleColor];
    [self addSubview:self.toolBar];
    [self addSubview:self.pickerView];
    
    __weak typeof(self) weakself = self;
    
    _toolBar.cancelHandler = ^(){
        [weakself hide];
    };
    _toolBar.okHandler = ^(){
        [weakself hide];
        if (weakself.selectedHandler)   weakself.selectedHandler(weakself.theResult);
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

#pragma mark - Properties

- (NSMutableArray *)cities{
    if (_cities == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"]];
        NSMutableArray *nmArray = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dic in array) {
            [nmArray addObject:[VProvinceModel citiesWithDic:dic]];
        }
        _cities = nmArray;
    }
    return _cities;
}

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
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.cities.count;
    }else{
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
        VProvinceModel * selectedProvince = self.cities[selectedRow];
        self.selectedProvince = selectedProvince;
        return selectedProvince.cities.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        VProvinceModel * province = self.cities[row];
        return province.name;
    }else{
        return self.selectedProvince.cities[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) [pickerView reloadComponent:1];
    
    NSInteger selectedCityIndex = [pickerView selectedRowInComponent:1];
    NSString * cityString = self.selectedProvince.cities[selectedCityIndex];
    self.theResult = [NSString stringWithFormat:@"%@ %@",self.selectedProvince.name,cityString];
}

@end
