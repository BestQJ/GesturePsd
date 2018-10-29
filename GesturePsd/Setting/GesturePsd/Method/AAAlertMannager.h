//
//  AAAlertMannager.h
//  ArticleAssem
//
//  Created by 乔杰 on 2018/10/20.
//  Copyright © 2018 乔杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAAlertMannager : NSObject

#pragma mark - 中间弹窗
/**
 * @param message   弹窗提示信息
 */
+ (void)showAlertWithMessage:(NSString *)message;


/**
 * @param title 弹窗标题
 * @param message   弹窗提示信息
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;


/**
 * @param title 弹窗标题
 * @param message   弹窗提示信息
 * @param cancelButtonTitle 取消按钮标题
 * @param cancelHandelBlock 取消按钮响应事件
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelHandelBlock:(void(^)(void))cancelHandelBlock;


/**
 * @param title 弹窗标题
 * @param message   弹窗提示信息
 * @param cancelButtonTitle 取消按钮标题
 * @param cancelHandelBlock 取消按钮响应事件
 * @param confirmButtonTitle    确认按钮
 * @param confirmHandelBlock    确认按钮响应事件
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelHandelBlock:(void(^)(void))cancelHandelBlock confirmButtonTitle:(NSString *)confirmButtonTitle confirmHandelBlock:(void(^)(void))confirmHandelBlock;



#pragma mark - 底部弹窗
/**
 * @param title 弹窗标题
 * @param message   弹窗提示信息
 */
+ (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message;


/**
 * @param title 弹窗标题
 * @param message   弹窗提示信息
 * @param cancelButtonTitle 取消按钮标题
 * @param cancelHandelBlock 取消按钮响应事件
 * @param otherButtonTitles 其他按钮
 * @param otherHandelBlock  其他按钮响应事件
 */
+ (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelHandelBlock:(void(^)(void))cancelHandelBlock otherButtonTitles:(NSArray *)otherButtonTitles otherHandelBlock:(void(^)(NSInteger index))otherHandelBlock;



#pragma mark - 通用弹窗
/**
 * @param type  弹窗类型 UIAlertControllerStyleActionSheet UIAlertControllerStyleAlert
 * @param title 弹窗标题
 * @param message   弹窗提示信息
 * @param cancelButtonTitle 取消按钮标题
 * @param cancelHandelBlock 取消按钮响应事件
 * @param confirmButtonTitle    确认按钮
 * @param confirmHandelBlock    确认按钮响应事件
 * @param destructiveButtonTitle    标红按钮
 * @param destructiveHandelBlock    标红按钮响应事件
 * @param otherButtonTitles 其他按钮
 * @param otherHandelBlock  其他按钮响应事件
 */
+ (void)showAlertWithType:(UIAlertControllerStyle)type title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelHandelBlock:(void(^)(void))cancelHandelBlock confirmButtonTitle:(NSString *)confirmButtonTitle confirmHandelBlock:(void(^)(void))confirmHandelBlock destructiveButtonTitle:(NSString *)destructiveButtonTitle destructiveHandelBlock:(void(^)(void))destructiveHandelBlock   otherButtonTitles:(NSArray *)otherButtonTitles otherHandelBlock:(void(^)(NSInteger index))otherHandelBlock;

@end

NS_ASSUME_NONNULL_END
