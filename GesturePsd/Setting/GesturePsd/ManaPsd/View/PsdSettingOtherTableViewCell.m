
//
//  PsdSettingOtherTableViewCell.m
//  PocketNoteBook
//
//  Created by 乔杰 on 2018/2/5.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "PsdSettingOtherTableViewCell.h"

@interface PsdSettingOtherTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UIButton *detailButton;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *lineView1;

@end

@implementation PsdSettingOtherTableViewCell

+ (NSString *)cellIdentifier{
    
    static NSString *cellId = @"PsdSettingOtherTableViewCell";
    
    return cellId;
}

+ (id)cellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath {
    [tableView registerClass:[self class] forCellReuseIdentifier:[self cellIdentifier]];
    
    PsdSettingOtherTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:[PsdSettingOtherTableViewCell cellIdentifier] forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[PsdSettingOtherTableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellIdentifier]];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setUpSubViews];

    return cell;
}

- (void)setUpSubViews {
 
    [self addSubview: self.selectedImageView];
    [self addSubview: self.titleLabel];
    [self addSubview: self.descriptionLabel];
    [self addSubview: self.detailButton];
    [self addSubview: self.lineView];
    [self addSubview: self.lineView1];
}
 
- (void)setData:(NSInteger)row {
    switch (row) {
        case 0:
            self.titleLabel.text = @"自动锁屏";
            self.descriptionLabel.text = @"退出程序后自动锁屏";
            self.lineView.hidden = NO;
            self.lineView1.hidden = NO;
            self.lineView1.frame = CGRectMake(15, 59.5, ScreenWidth - 15, 0.5);
            self.detailButton.hidden = NO;
            break;
        case 1:
            self.titleLabel.text = @"手动锁屏";
            self.descriptionLabel.text = @"主界面上滑底部导航手动锁屏";
            self.lineView.hidden = YES;
            break;
        default:
            break;
    }
}

#pragma mark - Getter
- (UIImageView *)selectedImageView {
    
    if (!_selectedImageView) {
        _selectedImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"psd_setting_selected"]];
        _selectedImageView.hidden = YES;
        _selectedImageView.frame = CGRectMake(10, 20, 20, 20);
    }
    return _selectedImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = Main_text_color;
        _titleLabel.font = [UIFont systemFontOfSize: 16];
        _titleLabel.frame = CGRectMake(CGRectGetMaxX(self.selectedImageView.frame) + 5, 10, ScreenWidth - CGRectGetWidth(self.detailButton.frame) - 40, 22);
    }
    return _titleLabel;
}

- (UILabel *)descriptionLabel {
    
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.textColor = Main_text_color_gray;
        _descriptionLabel.font = [UIFont systemFontOfSize: 13];
        _descriptionLabel.frame = CGRectMake(CGRectGetMaxX(self.selectedImageView.frame) + 5, CGRectGetMaxY(self.titleLabel.frame) + 3, ScreenWidth - CGRectGetWidth(self.detailButton.frame) - 40, 20);
    }
    return _descriptionLabel;
}


- (UIButton *)detailButton {
    if (!_detailButton) {
        _detailButton = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
        _detailButton.hidden = YES;
        _detailButton.frame = CGRectMake(ScreenWidth - 35, CGRectGetMinY(self.selectedImageView.frame) - 2.5, 25, 25);
    }
    return _detailButton;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = Seperator_line_color;
        _lineView.frame = CGRectMake(0, 0, ScreenWidth, 0.5);
    }
    return _lineView;
}


- (UIView *)lineView1 {
    
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] init];
        _lineView1.hidden = YES;
        _lineView1.backgroundColor = Seperator_line_color;
        _lineView1.frame = CGRectMake(0, 59.5, ScreenWidth, 0.5);
    }
    return _lineView1;
}



@end
