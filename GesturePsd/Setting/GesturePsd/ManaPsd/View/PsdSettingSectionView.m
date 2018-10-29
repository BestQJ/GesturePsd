
//
//  PsdSettingSectionView.m
//  PocketNoteBook
//
//  Created by 乔杰 on 2018/2/5.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "PsdSettingSectionView.h"
#import "BiometryAuthManager.h"
#import "AAAlertMannager.h"
@interface PsdSettingSectionView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *lineView1;

@end

@implementation PsdSettingSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame: frame];
    
    if (self) {
        
        [self setUpSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setUpSubViews {
 
    [self addSubview: self.titleLabel];
    [self addSubview: self.switchButtoon];
    [self addSubview: self.arrowImageView];
    [self addSubview: self.lineView];
    [self addSubview: self.lineView1];
}

- (void)setData:(NSInteger)section isSupportBiometry:(BOOL)isSupportBiometry {
    
    self.arrowImageView.hidden = YES;
    self.switchButtoon.hidden = NO;
    
    if (section == 0) {
        self.titleLabel.text = @"开启密码锁定";
        self.switchButtoon.tag = 100;
        [self.switchButtoon setOn: Gesture_open_statu animated: NO];
    }else if (section == 2) {
        if (isSupportBiometry) {
            self.titleLabel.text = @"开启Touch ID或Face ID解锁";
            self.switchButtoon.tag = 102;
            [self.switchButtoon setOn: Touch_id_open_statu animated: NO];
        }else {
            self.titleLabel.text = @"重置手势密码";
            self.arrowImageView.hidden = NO;
            self.switchButtoon.hidden = YES;
        }
    }else if (section == 3) {
        self.titleLabel.text = @"重置手势密码";
        self.arrowImageView.hidden = NO;
        self.switchButtoon.hidden = YES;
    }
}


- (void)changePsdStatu:(JTMaterialSwitch *)swicth {

    if (swicth.tag == 100) {
        if (self.switchButtonClickBlock) {
            [kUserDefaults setObject: swicth.isOn ? @"1" : @"0" forKey: Gesture_open_statu_key];
            [kUserDefaults synchronize];
            self.switchButtonClickBlock(swicth.tag - 100);
        }
    }else {
        [[BiometryAuthManager shareMannager] judgeTouchAuth:^(BOOL success, NSString * _Nonnull errorDecription) {
            if (success) {
                [kUserDefaults setObject: swicth.isOn ? @"0" : @"1" forKey: Touch_id_open_statu_key];
                [kUserDefaults synchronize];
                if (self.switchButtonClickBlock) {
                    self.switchButtonClickBlock(swicth.tag - 100);
                }
            }else {
                [AAAlertMannager showAlertWithMessage: errorDecription];
            }
        }];
    }
}

#pragma mark - Getter

- (JTMaterialSwitch *)switchButtoon {
    if (!_switchButtoon) {
        _switchButtoon = [[JTMaterialSwitch alloc] init];
        _switchButtoon.thumbOnTintColor = Main_color;
        _switchButtoon.thumbOffTintColor = [UIColor whiteColor];
        _switchButtoon.trackOnTintColor = Main_color;
        _switchButtoon.trackOffTintColor = backGroundColor;
        _switchButtoon.rippleFillColor = Main_color;
        [_switchButtoon addTarget: self action: @selector(changePsdStatu:) forControlEvents: UIControlEventValueChanged];
        _switchButtoon.frame = CGRectMake(ScreenWidth - 50, 7.5, 50, 40);
    }
    return _switchButtoon;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = Main_text_color;
       _titleLabel.font = [UIFont systemFontOfSize: 16];
        _titleLabel.frame = CGRectMake(10, 10, CGRectGetMinX(self.switchButtoon.frame) - 10, 30);
    }
    return _titleLabel;
}

- (UIImageView *)arrowImageView {
    
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"psd_manager_arrow"]];
        _arrowImageView.hidden = YES;
        _arrowImageView.frame = CGRectMake(ScreenWidth - 20, 17.5, 15, 15);
    }
    return _arrowImageView;
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
        _lineView1.backgroundColor = Seperator_line_color;
        _lineView1.frame = CGRectMake(0, 49.5, ScreenWidth, 0.5);
    }
    return _lineView1;
}

@end
