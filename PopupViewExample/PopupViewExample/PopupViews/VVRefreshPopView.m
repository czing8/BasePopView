//
//  VVRefreshPopView.m
//  PopupViewExample
//
//  Created by Vols on 2017/6/23.
//  Copyright © 2017年 vols. All rights reserved.
//

#import "VVRefreshPopView.h"


#define kVVRefreshCellIdentifier     @"kVVRefreshCellIdentifier"

@interface VVRefreshCell : UITableViewCell

@property(nonatomic,strong) UIImageView * selectIView;
@property(nonatomic,strong) UILabel     * titleLabel;

@end

@implementation VVRefreshCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        self.contentView.backgroundColor = kRGB(250, 251, 252);
        [self.contentView addSubview:self.selectIView];
        [self.contentView addSubview:self.titleLabel];
        
        [_selectIView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(8);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_selectIView.mas_right).offset(8);
            make.top.bottom.right.equalTo(self.contentView);
        }];
    }
    
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    return self;
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}

- (UIImageView *)selectIView {
    if (_selectIView == nil) {
        _selectIView = [[UIImageView alloc] init];
        _selectIView.backgroundColor = [UIColor clearColor];
        _selectIView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _selectIView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end



@interface VVRefreshPopView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel       * titleLabel;

@property (nonatomic, strong) UITableView   * tableView;
@property (nonatomic, strong) NSArray       * menuTitles;

@end


@implementation VVRefreshPopView

#pragma mark - Public

+ (VVRefreshPopView *)showWithSettings:(void (^) (VVRefreshPopView * popupView))otherSetting {
    VVRefreshPopView *popupMenu = [[VVRefreshPopView alloc] init];
    if (otherSetting)  otherSetting(popupMenu);
    [popupMenu show];
    
    return popupMenu;
}

#pragma mark - Lifecycle

- (id)init{
    self = [super init];
    if (self) {
        
        [self configureViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = 6;

}

- (void)configureViews{
    
    //    self.isHideOverLay = YES;
    
    self.layer.masksToBounds = YES;

    _menuTitles = @[@"5秒自动刷新", @"10秒自动刷新", @"30秒自动刷新", @"60秒自动刷新", @"不自动刷新"];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.superview);
        make.centerY.equalTo(self.superview);
        make.size.mas_equalTo(CGSizeMake(180, 236));
    }];
    
    [self addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(36);
    }];

    [self addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.top.equalTo(_titleLabel.mas_bottom);
    }];
    
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Properties

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[VVRefreshCell class] forCellReuseIdentifier:kVVRefreshCellIdentifier];
        _tableView.estimatedRowHeight = 40;      //预估行高 可以提高性能
        _tableView.bounces = NO;
        _tableView.clipsToBounds = YES;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);

    }
    return _tableView;
}


- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"刷新设置";
        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.clipsToBounds=YES;

    }
    return _titleLabel;
}


#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuTitles.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VVRefreshCell * cell = [tableView dequeueReusableCellWithIdentifier:kVVRefreshCellIdentifier];
    
//    VVRefreshCell *cell = [self dequeueReusableCellWithIdentifier:kVVRefreshCellIdentifier forIndexPath:indexPath];
    
    //  if (cell == nil) {
    //      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    //  }
    
    //    for(UIView * view in cell.contentView.subviews){
    //        [view removeFromSuperview];
    //    }
    // [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.titleLabel.textColor = [UIColor colorWithWhite:0.293 alpha:1.000];
    cell.titleLabel.font = [UIFont systemFontOfSize:15];
    cell.titleLabel.text = _menuTitles[indexPath.row];
    cell.selectIView.backgroundColor = [UIColor purpleColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.clickHandler) {
        self.clickHandler(indexPath.row);
    }
    
    [self dismiss];
}

@end
