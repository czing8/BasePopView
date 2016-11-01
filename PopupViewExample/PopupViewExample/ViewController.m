//
//  ViewController.m
//  PopupViewExample
//
//  Created by Vols on 2015/11/1.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "ViewController.h"
#import "TestPopupView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)clickAction:(id)sender {
    
    TestPopupView * popView = [[TestPopupView alloc] init];
    [popView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
