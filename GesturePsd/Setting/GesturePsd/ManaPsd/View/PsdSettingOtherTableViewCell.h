//
//  PsdSettingOtherTableViewCell.h
//  PocketNoteBook
//
//  Created by 乔杰 on 2018/2/5.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"

@interface PsdSettingOtherTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *selectedImageView;

+ (id)cellWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

- (void)setData:(NSInteger)row;


@end
