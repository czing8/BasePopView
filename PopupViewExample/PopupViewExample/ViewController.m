//
//  ViewController.m
//  PopupViewExample
//
//  Created by Vols on 2015/11/1.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "ViewController.h"
#import "TestPopupView.h"
#import "PopView.h"

#import "BottleView.h"
#import "VCityPicker.h"
#import "V2CityPicker.h"

@interface ViewController ()
@property (nonatomic, strong) PopView * popView;

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
    
    TestPopupView * popView = [[TestPopupView alloc] init];
    popView.animationType = _sgType.selectedSegmentIndex + 1;
    [popView show];
}

- (IBAction)popClickAction:(id)sender {
    [self.view addSubview:self.popView];
    
    [_popView showPopView];
}

- (IBAction)clickAction2:(id)sender {

    BottleView * bottleView = [[BottleView alloc] init];
    
    __weak __typeof(bottleView)weakBottleView = bottleView;
    
    weakBottleView.throwBottleClick = ^(NSString * bottleText){
        NSLog(@"bottleText--> %@", bottleText);
    };
    
    weakBottleView.myBottlesClick = ^{
        NSLog(@"%s", __FUNCTION__);
    };
    
    [bottleView showView];
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
- (PopView *)popView{
    if (!_popView) {
        _popView = [[PopView alloc] init];
        _popView.image = [UIImage imageNamed:@"finish"];
    }
    return _popView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
