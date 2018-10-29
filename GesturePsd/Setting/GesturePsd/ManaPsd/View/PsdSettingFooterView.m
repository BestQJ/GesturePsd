//
//  PsdSettingFooterView.m
//  PocketNoteBook
//
//  Created by 乔杰 on 2018/2/5.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "PsdSettingFooterView.h"

@interface PsdSettingFooterView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation PsdSettingFooterView

+ (NSString *)footerViewIdentifire{
    
    static NSString *footerId = @"PsdSettingFooterView";
    
    return footerId;
}

+ (instancetype)footerView:(UITableView *)tableView {
    
    PsdSettingFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier: [self footerViewIdentifire]];
    if (!view) {
        view = [[PsdSettingFooterView alloc] initWithReuseIdentifier: [self footerViewIdentifire]];
        [view setUpSubViews];
    }
    return view;
}

- (void)setUpSubViews {
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = Main_text_color_gray;
    self.titleLabel.font = [UIFont systemFontOfSize: 14];
    [self addSubview: self.titleLabel];
    self.titleLabel.text = @"开启后，可以使用Touch ID或Face ID解锁应用程序";
    self.titleLabel.frame = CGRectMake(10, 5, ScreenWidth - 10, 20);
}


@end
