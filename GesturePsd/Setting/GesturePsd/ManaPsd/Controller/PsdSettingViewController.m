
//
//  PsdSettingViewController.m
//  PocketNoteBook
//
//  Created by 乔杰 on 2018/2/2.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "PsdSettingViewController.h"
#import "PsdSettingSectionView.h"
#import "PsdSettingFooterView.h"
#import "PsdSettingOtherTableViewCell.h"
#import "GesturePsdSetViewController.h"
#import "BiometryAuthManager.h"

@interface PsdSettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mTableView;

@property (nonatomic, assign) BOOL isSupportGesture;

@property (nonatomic, assign) BOOL isSupportBiometry;

@property (nonatomic, assign) NSInteger selectedCellIndex;

@property (nonatomic, strong) PsdSettingOtherTableViewCell *lastCell;

@end

@implementation PsdSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手势、指纹管理";
    self.isSupportGesture = Gesture_open_statu;
    self.isSupportBiometry = [[BiometryAuthManager shareMannager] isSupportBiometry];
    [self setUpTableView];
}

#pragma mark - 布局页面视图
- (void)setUpTableView {
    self.mTableView = [[UITableView alloc] initWithFrame: CGRectMake(0, StaNavHeight, ScreenWidth, ScreenHeight - StaNavHeight - TabBarDif) style:UITableViewStyleGrouped];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    [self.view addSubview:self.mTableView];
    self.mTableView.showsVerticalScrollIndicator = NO;
    self.mTableView.showsHorizontalScrollIndicator = NO;
    self.mTableView.backgroundColor = backGroundColor;
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        self.mTableView.estimatedRowHeight = 0;
        self.mTableView.estimatedSectionFooterHeight = 0;
        self.mTableView.estimatedSectionHeaderHeight = 0;
    }
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isSupportGesture) return 3 + self.isSupportBiometry;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) return 2;
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) return 60.0f;
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 30.f;
    if (section == 1) return 20.f;
    return 50.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) return nil;
    PsdSettingSectionView *view = [[PsdSettingSectionView alloc] init];
    [view setData: section isSupportBiometry: self.isSupportBiometry];
    view.switchButtonClickBlock = ^(NSInteger index) {
        if (index == 0) {
            self.isSupportGesture = Gesture_open_statu;
            [self.mTableView reloadData];
        }else {
            [self.mTableView reloadData];
        }
    };
    if (section == 3) {
        [view addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(updateGesturePsd)]];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) return 50.0f;
    if (section == 1) return 20.f;
    if (self.isSupportBiometry) {
        if (section == 2) return 30.0f;
    }
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        PsdSettingSectionView *view = [[PsdSettingSectionView alloc] init];
        [view setData: section isSupportBiometry: self.isSupportBiometry];
        view.switchButtonClickBlock = ^(NSInteger index) {
            if (index == 0) {
                self.isSupportGesture = Gesture_open_statu;
                [self.mTableView reloadData];
            }else {
                [self.mTableView reloadData];
            }
        };
        return view;
    }else if (section == 2) {
        if (self.isSupportBiometry) {
            PsdSettingFooterView *view = [PsdSettingFooterView footerView: tableView];
            return view;
        }
    }
    return nil;
}

//单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        PsdSettingOtherTableViewCell *cell = [PsdSettingOtherTableViewCell cellWithTableView: tableView andIndexPath: indexPath];
        
        [cell setData: indexPath.row];
        if (indexPath.row == self.selectedCellIndex) {
            cell.selectedImageView.hidden = NO;
            self.lastCell = cell;
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (indexPath.section == 1) {
        
        self.lastCell.selectedImageView.hidden = YES;
        
        self.selectedCellIndex = indexPath.row;
        
        PsdSettingOtherTableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];
        
        cell.selectedImageView.hidden = NO;
        
        self.lastCell = cell;
    }
}

- (void)updateGesturePsd {
    GesturePsdSetViewController *vc = [[GesturePsdSetViewController alloc] init];
    [self.navigationController pushViewController: vc animated: YES];
}

@end
