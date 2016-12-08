//
//  VProvinceModel.m
//  PopupViewExample
//
//  Created by Vols on 2015/12/8.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "VProvinceModel.h"

@implementation VProvinceModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)citiesWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
