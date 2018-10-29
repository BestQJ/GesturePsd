//
//  LastGesturePsdView.m
//  PocketNoteBook
//
//  Created by 乔杰 on 2018/2/5.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "LastGesturePsdView.h"

@implementation LastGesturePsdView

- (instancetype)init {
    
    return [super initWithFrame: CGRectZero];
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame: frame];
    
    if (self) {
        
        [self setUpSubViews];
        
    }
    return self;
}

- (void)setUpSubViews {

    for (int i = 0; i < 9; i ++) {
        UIView *cycleView = [[UIView alloc] init];
        cycleView.frame = CGRectMake((self.frame.size.width/5.0 *2) * (i%3), (self.frame.size.height/5.0 *2) * (i/3), self.frame.size.width/5.0, self.frame.size.height/5.0);
        cycleView.layer.borderColor = Cycle_Line_color.CGColor;
        cycleView.layer.borderWidth = 1;
        cycleView.layer.cornerRadius = self.frame.size.height/5.0/2;
        cycleView.layer.masksToBounds = YES;
        cycleView.tag = i + 10;
        [self addSubview: cycleView];
    }
}


- (void)setPsdIndexArr:(NSMutableArray *)psdIndexArr {

    for (int i = 0; i < 9; i ++) {
        UIView *cycleView = [self viewWithTag: i + 10];
        cycleView.layer.borderColor = [UIColor darkTextColor].CGColor;
        cycleView.backgroundColor = [UIColor clearColor];
    }
    
    for (NSNumber *number in psdIndexArr) {
        UIView *cycleView = [self viewWithTag: [number intValue] + 10];
        cycleView.layer.borderColor = Main_color.CGColor;
        cycleView.backgroundColor = Main_color;
    }
}



@end
