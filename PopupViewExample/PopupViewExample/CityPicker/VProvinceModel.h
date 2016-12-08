//
//  VProvinceModel.h
//  PopupViewExample
//
//  Created by Vols on 2015/12/8.
//  Copyright © 2015年 vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VProvinceModel : NSObject

@property (nonatomic, strong) NSArray   * cities;
@property (nonatomic, copy)   NSString  * name;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)citiesWithDic:(NSDictionary *)dic;

@end
