//
//  ViewController.m
//  PopupViewExample
//
//  Created by Vols on 2015/11/1.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "ViewController.h"
#import "TestPopupView.h"

#import "VVDropMenu.h"
#import "VVWarnPopupView.h"
#import "VVImagePopupView.h"
#import "VVRefreshPopView.h"

#import "VCityPicker.h"
#import "V2CityPicker.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UISegmentedControl *sgType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _sgType.selectedSegmentIndex = 0;
    [self typeChange:nil];
}


- (IBAction)typeChange:(id)sender {
    
}

- (IBAction)clickAction:(id)sender {
    
    [TestPopupView showWithSettings:^(TestPopupView *popupView) {
        popupView.animationType = _sgType.selectedSegmentIndex + 1;
    }];
    
}

- (IBAction)popClickAction:(id)sender {

    
    [VVImagePopupView showWithImage:@"finish" otherSettings:^(VVImagePopupView *popupView) {
        
    }];
}

- (IBAction)clickAction2:(id)sender {

    [VVWarnPopupView showWithSettings:^(VVWarnPopupView *dropMenu) {
        
    }];
    
}

- (IBAction)dropMenuAction:(id)sender {
//    [VVDropMenu showWithMenuTitles:@[@"1", @"1", @"1", @"2", @"3"] otherSettings:^(VVDropMenu *dropMenu) {
//        
//    }];
    
   VVRefreshPopView * refreshMenu =  [VVRefreshPopView showWithSettings:^(VVRefreshPopView *popupView) {
        popupView.animationType = 1;

    }];

    refreshMenu.clickHandler = ^(NSUInteger selectedIndex) {
        NSLog(@"%ld", selectedIndex);
    };
}



- (IBAction)city1PickerAction:(id)sender {
    V2CityPicker * cityPicker = [[V2CityPicker alloc] init];
    cityPicker.selectedHandler = ^(NSString *cityString){
        [sender setTitle:cityString forState:UIControlStateNormal];
    };
    
    [cityPicker show];
}


- (IBAction)cityPickerAction:(UIButton *)sender {
    VCityPicker * cityPicker = [VCityPicker pickerWithResultHandler:^(VCityModel *model) {
        NSLog(@"%@", model.county);
        [sender setTitle:model.county forState:UIControlStateNormal];
    }];
    
    [cityPicker show];
}


#pragma mark - properties


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
