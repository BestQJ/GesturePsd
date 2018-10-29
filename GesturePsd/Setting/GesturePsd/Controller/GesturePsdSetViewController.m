//
//  GesturePsdSetViewController.m
//  PocketNoteBook
//
//  Created by 乔杰 on 2018/2/2.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "GesturePsdSetViewController.h"

#import "PasswordView.h"

#import "LastGesturePsdView.h"

@interface GesturePsdSetViewController ()

@property (nonatomic, strong) PasswordView *psdView;

@property (nonatomic, strong) LastGesturePsdView *lastPsdView;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) NSMutableArray *lastPsdIndexArr;

@end

@implementation GesturePsdSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"手势密码";
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUpSubViews];
}

#pragma mark - 布局页面视图
- (void)setUpSubViews {
    
    CGFloat height = cycle_width + (cycle_width + cycle_raw) * 2;

    CGFloat orginY = (ScreenHeight - TabBarDif - StatusHeight - height - 120)/2.0;
    
    self.tipLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, orginY, ScreenWidth, 30)];
    self.tipLabel.text = @"绘制解锁图案";
    self.tipLabel.textColor = Main_color;
    self.tipLabel.font = [UIFont systemFontOfSize: 15];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: self.tipLabel];
    
    self.lastPsdView = [[LastGesturePsdView alloc] initWithFrame: CGRectMake((ScreenWidth - 40)/2.0, CGRectGetMaxY(self.tipLabel.frame) + 10, 40, 40)];
    [self.view addSubview: self.lastPsdView];
    
    self.psdView = [[PasswordView alloc] initWithFrame: CGRectMake(0, CGRectGetMaxY(self.lastPsdView.frame) + 40, ScreenWidth, height)];
    __block GesturePsdSetViewController *weakSelf = self;
    self.psdView.refreshPageDataBlock = ^{
        if (weakSelf.lastPsdIndexArr) {
            if ([[weakSelf.lastPsdIndexArr componentsJoinedByString: @","] isEqualToString: [weakSelf.psdView.passwordIndexArr componentsJoinedByString: @","]]) {
                [[NSUserDefaults standardUserDefaults] setObject: [weakSelf.psdView.passwordIndexArr copy] forKey: Gesture_password_key];
                [[NSUserDefaults standardUserDefaults] synchronize];
                weakSelf.tipLabel.text = @"密码设置成功";
                //密码设置成功
                [weakSelf performSelector: @selector(backToLastPage) withObject: nil afterDelay: 0.5];
            }else {
                weakSelf.lastPsdIndexArr = nil;
                weakSelf.tipLabel.text = @"两次手势密码不一致，请重新绘制解锁图案";
                weakSelf.lastPsdView.psdIndexArr = [[NSMutableArray alloc] init];
            }
        }else {
            weakSelf.lastPsdIndexArr = [weakSelf.psdView.passwordIndexArr mutableCopy];
            weakSelf.lastPsdView.psdIndexArr = weakSelf.lastPsdIndexArr;
            weakSelf.tipLabel.text = @"请再次绘制解锁图案";
        }
    };
    [self.view addSubview: self.psdView];
}


- (void)backToLastPage {
    
    [self.navigationController popViewControllerAnimated: YES];

}
 

@end
