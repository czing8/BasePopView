//
//  VVDropMenu.h
//  PopupViewExample
//
//  Created by Vols on 2017/6/22.
//  Copyright © 2017年 vols. All rights reserved.
//

#import "BasePopupView.h"

@class VVDropMenu;

@protocol VVDropMenuDelegate <NSObject>

@optional
- (void)dropMenu:(VVDropMenu *)dropMenu didSelectAtIndex:(NSInteger)index;

@end


@interface VVDropMenu : BasePopupView

@property (nonatomic, strong) NSArray   * menuTitles;


+ (VVDropMenu *)showWithMenuTitles:(NSArray *)menuTitles
                     otherSettings:(void (^) (VVDropMenu * dropMenu))otherSetting;


+ (VVDropMenu *)showAtPoint:(UIView *)point
                 menuTitles:(NSArray *)menuTitles
              otherSettings:(void (^) (VVDropMenu * dropMenu))otherSetting;


+ (VVDropMenu *)showRelyOnView:(UIView *)attachedView
                    menuTitles:(NSArray *)menuTitles
                 otherSettings:(void (^) (VVDropMenu * dropMenu))otherSetting;


@end
