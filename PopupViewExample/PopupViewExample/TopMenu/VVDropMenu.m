//
//  VVDropMenu.m
//  PopupViewExample
//
//  Created by Vols on 2017/6/22.
//  Copyright © 2017年 vols. All rights reserved.
//

#import "VVDropMenu.h"


@interface VVDropMenu () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation VVDropMenu

#pragma mark - Public

+ (VVDropMenu *)showWithMenuTitles:(NSArray *)menuTitles
                     otherSettings:(void (^) (VVDropMenu * dropMenu))otherSetting {
    VVDropMenu *dropMenu = [[VVDropMenu alloc] initWithMenuTitles:menuTitles];
    dropMenu.menuTitles = menuTitles;
    if (otherSetting)  otherSetting(dropMenu);
    [dropMenu show];
    
    return dropMenu;
}


+ (VVDropMenu *)showRelyOnView:(UIView *)attachedView
                    menuTitles:(NSArray *)menuTitles
                 otherSettings:(void (^) (VVDropMenu * dropMenu))otherSetting {
    VVDropMenu *dropMenu = [[VVDropMenu alloc] init];
    dropMenu.menuTitles = menuTitles;
    

    if (otherSetting)  otherSetting(dropMenu);
    [dropMenu show];
    
    return dropMenu;
}


#pragma mark - Lifecycle

- (instancetype)initWithMenuTitles:(NSArray *) titles {
    self = [super init];
    if (self) {
        _menuTitles = titles;
        [self configureViews];
    }
    return self;
}


- (void)configureViews {
    //    self.isHideOverLay = YES;
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview);
        make.left.right.equalTo(self.superview);
        make.height.mas_equalTo(0);
    }];
    //    [self.superview setNeedsLayout];
    
    [self addSubview:self.tableView];

    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
        
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(_menuTitles.count * 40);
    }];

    self.backgroundColor = [UIColor purpleColor];
}


- (void)setMenuTitles:(NSArray *)menuTitles {
    _menuTitles = menuTitles;
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuTitles.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * identifier = @"kCellIdentifier";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    //  if (cell == nil) {
    //      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    //  }
    
    //    for(UIView * view in cell.contentView.subviews){
    //        [view removeFromSuperview];
    //    }
    // [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.textColor = [UIColor colorWithWhite:0.293 alpha:1.000];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = _menuTitles[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:_cellImages[indexPath.section][indexPath.row]];
    
    return cell;
}



//重写showAnimation
- (void)showAnimation {
    double dDuration = 0.2;

    [UIView animateWithDuration:dDuration animations:^{
        CGRect _selfFrame = self.frame;
        _selfFrame.size.height = _menuTitles.count * 40;
        self.frame = _selfFrame;
        
    } completion:^(BOOL finished) {
        NSLog(@"%@", NSStringFromCGRect(_tableView.frame));
//        _tableView.frame = self.bounds;
        
        NSLog(@"%@", NSStringFromCGRect(self.frame));
    }];
}


//重写dismissAnimation
- (void)dismissAnimation {
    
    double dDuration = 0.2;

    [UIView animateWithDuration:dDuration animations:^{
        CGRect _selfFrame = self.frame;
        _selfFrame.size.height = 0;
        self.frame = _selfFrame;
        
    } completion:^(BOOL finished) {
        [self.superview removeFromSuperview];
    }];

}



#pragma mark - Properties

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"kCellIdentifier"];
        _tableView.estimatedRowHeight = 40;      //预估行高 可以提高性能
//        _tableView.
        _tableView.clipsToBounds=YES;

    }
    return _tableView;
}


@end
