
//
//  GesturePsdCheckViewController.m
//  PocketNoteBook
//
//  Created by 乔杰 on 2018/2/2.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "GesturePsdCheckViewController.h"
#import "PasswordView.h"
#import "BiometryAuthManager.h"
#import "AppDelegate.h"

@interface GesturePsdCheckViewController ()

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) PasswordView *psdView;

@property (nonatomic, assign) NSInteger wrongCount;

@end

@implementation GesturePsdCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (Touch_id_open_statu) {
        [[BiometryAuthManager shareMannager] judgeTouchAuth:^(BOOL success, NSString *errorDecription) {
            if (success) {
                [kAppDelegate showRootViewController];
            }else if (Gesture_open_statu)  {
                [self setUpSubViews];
            }else {
                [self exitApplication];
            }
        }];
    }else if (Gesture_open_statu)  {
        [self setUpSubViews];
    }else {
        [kAppDelegate showRootViewController];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear: animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
}


- (void)exitApplication {
    UIWindow *window = kAppDelegate.window;
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

#pragma mark - 设置
- (void)setUpSubViews {
    float startY = (ScreenHeight - cycle_width - (cycle_width + cycle_raw) * 2 - 50)/2.0;
    //屏幕解锁 启动应用  连续输错五次 退出登录 且删除缓存的本地密码
    self.tipLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, startY, ScreenWidth, 30)];
    self.tipLabel.text = @"绘制解锁图案";
    self.tipLabel.textColor = Main_color;
    self.tipLabel.font = [UIFont systemFontOfSize: 15];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: self.tipLabel];
    
    self.psdView = [[PasswordView alloc] initWithFrame: CGRectMake(0, startY + 50, [UIScreen mainScreen].bounds.size.width, cycle_width + (cycle_width + cycle_raw) * 2)];
    __block GesturePsdCheckViewController *weakSelf = self;
    self.psdView.refreshPageDataBlock = ^{
        if ([[(NSArray *)Gesture_password componentsJoinedByString: @","] isEqualToString: [weakSelf.psdView.passwordIndexArr componentsJoinedByString: @","]]) {
            [kAppDelegate showRootViewController];
        }else {
            weakSelf.wrongCount ++;
            weakSelf.tipLabel.text = [NSString stringWithFormat: @"密码错误,还可以输错%ld次",  5 - weakSelf.wrongCount];
            if (weakSelf.wrongCount >= 5) {
                [weakSelf exitApplication];
            }
        }
    };
    [self.view addSubview: self.psdView];
}


@end
