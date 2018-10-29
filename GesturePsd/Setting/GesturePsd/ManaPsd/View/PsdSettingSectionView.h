//
//  PsdSettingSectionView.h
//  PocketNoteBook
//
//  Created by 乔杰 on 2018/2/5.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "JTMaterialSwitch.h"

@interface PsdSettingSectionView : UIView

@property (nonatomic, copy) void(^switchButtonClickBlock)(NSInteger index);

@property (nonatomic, strong) JTMaterialSwitch *switchButtoon;

- (void)setData:(NSInteger)section isSupportBiometry:(BOOL)isSupportBiometry;

@end
