//
//  PasswordView.h
//  NewTest
//
//  Created by 乔杰 on 2018/1/22.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"

#define cycle_width             60
#define cycle_raw               20

@interface PasswordView : UIView

@property (nonatomic, assign) BOOL isTracking;

@property (nonatomic, assign) CGPoint currentFingerPoint;

@property (nonatomic, strong) NSMutableArray *passwordIndexArr;

@property (nonatomic, copy) void(^refreshPageDataBlock)(void);

@end
