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

@interface ViewController ()
@property (nonatomic, strong) PopView * popView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)clickAction:(id)sender {
    
    TestPopupView * popView = [[TestPopupView alloc] init];
    [popView show];
}

- (IBAction)popClickAction:(id)sender {
    [self.view addSubview:self.popView];
    
    [_popView showPopView];

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
