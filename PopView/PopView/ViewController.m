//
//  ViewController.m
//  PopView
//
//  Created by Vols on 14-8-28.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import "ViewController.h"
#import "PopView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}
- (IBAction)clickAction:(id)sender {
    PopView * popView = [[PopView alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:popView];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
