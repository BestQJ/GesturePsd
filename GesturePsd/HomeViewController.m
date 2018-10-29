//
//  HomeViewController.m
//  GesturePsd
//
//  Created by 乔杰 on 2018/10/29.
//  Copyright © 2018 乔杰. All rights reserved.
//

#import "HomeViewController.h"
#import "PsdSettingViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    PsdSettingViewController *vc = [[PsdSettingViewController alloc] init];
    
    [self.navigationController pushViewController: vc animated: YES];
}

@end
