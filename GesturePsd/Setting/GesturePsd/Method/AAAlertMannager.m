//
//  AAAlertMannager.m
//  ArticleAssem
//
//  Created by 乔杰 on 2018/10/20.
//  Copyright © 2018 乔杰. All rights reserved.
//

#import "AAAlertMannager.h"
#import <objc/runtime.h>

@interface AAAlertMannager ()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation AAAlertMannager

static AAAlertMannager *shareManager = nil;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"

+ (instancetype)shareManager {
    
    if (!shareManager) {
        
        shareManager = [[AAAlertMannager alloc] init];
    }
    return shareManager;
}

#pragma mark - 中间弹窗
/**
 * @param message   弹窗提示信息
 */
+ (void)showAlertWithMessage:(NSString *)message {
    
    [self showAlertWithType: UIAlertControllerStyleAlert title: nil message: message cancelButtonTitle: @"确定" cancelHandelBlock: nil confirmButtonTitle: nil confirmHandelBlock: nil destructiveButtonTitle: nil destructiveHandelBlock: nil otherButtonTitles:nil otherHandelBlock: nil];
}


/**
 * @param title 弹窗标题
 * @param message   弹窗提示信息
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    [self showAlertWithType: UIAlertControllerStyleAlert title: title message: message cancelButtonTitle: @"确定" cancelHandelBlock: nil confirmButtonTitle: nil confirmHandelBlock: nil destructiveButtonTitle: nil destructiveHandelBlock: nil otherButtonTitles:nil otherHandelBlock: nil];
}


/**
 * @param title 弹窗标题
 * @param message   弹窗提示信息
 * @param cancelButtonTitle 取消按钮标题
 * @param cancelHandelBlock 取消按钮响应事件
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelHandelBlock:(void(^)(void))cancelHandelBlock {
    
    [self showAlertWithType: UIAlertControllerStyleAlert title: title message: message cancelButtonTitle:  cancelButtonTitle cancelHandelBlock: cancelHandelBlock confirmButtonTitle: nil confirmHandelBlock: nil destructiveButtonTitle: nil destructiveHandelBlock: nil otherButtonTitles:nil otherHandelBlock: nil];
}


/**
 * @param title 弹窗标题
 * @param message   弹窗提示信息
 * @param cancelButtonTitle 取消按钮标题
 * @param cancelHandelBlock 取消按钮响应事件
 * @param confirmButtonTitle    确认按钮
 * @param confirmHandelBlock    确认按钮响应事件
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelHandelBlock:(void(^)(void))cancelHandelBlock confirmButtonTitle:(NSString *)confirmButtonTitle confirmHandelBlock:(void(^)(void))confirmHandelBlock {
    
    [self showAlertWithType: UIAlertControllerStyleAlert title: title message: message cancelButtonTitle:  cancelButtonTitle cancelHandelBlock: cancelHandelBlock confirmButtonTitle: confirmButtonTitle confirmHandelBlock: confirmHandelBlock destructiveButtonTitle: nil destructiveHandelBlock: nil otherButtonTitles:nil otherHandelBlock: nil];
}

#pragma mark - 底部弹窗
/**
 * @param title 弹窗标题
 * @param message   弹窗提示信息
 */
+ (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message {
    
    [self showAlertWithType: UIAlertControllerStyleActionSheet title: title message: message cancelButtonTitle: @"取消" cancelHandelBlock: nil confirmButtonTitle: nil confirmHandelBlock: nil destructiveButtonTitle: nil destructiveHandelBlock: nil otherButtonTitles:nil otherHandelBlock: nil];
}


/**
 * @param title 弹窗标题
 * @param message   弹窗提示信息
 * @param cancelButtonTitle 取消按钮标题
 * @param cancelHandelBlock 取消按钮响应事件
 * @param otherButtonTitles 其他按钮
 * @param otherHandelBlock  其他按钮响应事件
 */
+ (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelHandelBlock:(void(^)(void))cancelHandelBlock otherButtonTitles:(NSArray *)otherButtonTitles otherHandelBlock:(void(^)(NSInteger index))otherHandelBlock {
    
    [self showAlertWithType: UIAlertControllerStyleActionSheet title: title message: message cancelButtonTitle: cancelButtonTitle cancelHandelBlock: cancelHandelBlock confirmButtonTitle: nil confirmHandelBlock: nil destructiveButtonTitle: nil destructiveHandelBlock: nil otherButtonTitles: otherButtonTitles otherHandelBlock: otherHandelBlock];
}

#pragma clang diagnostic pop

#pragma mark - 通用方法
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
+ (void)showAlertWithType:(UIAlertControllerStyle)type title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelHandelBlock:(void(^)(void))cancelHandelBlock confirmButtonTitle:(NSString *)confirmButtonTitle confirmHandelBlock:(void(^)(void))confirmHandelBlock destructiveButtonTitle:(NSString *)destructiveButtonTitle destructiveHandelBlock:(void(^)(void))destructiveHandelBlock   otherButtonTitles:(NSArray *)otherButtonTitles otherHandelBlock:(void(^)(NSInteger index))otherHandelBlock {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: [self transform: title] message: [self transform: message] != nil ? [NSString stringWithFormat: @"\n%@", [self transform: message]] : [self transform: message]  preferredStyle: type];
    
    NSInteger index = 0;
    if ([self transform: cancelButtonTitle]) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle: cancelButtonTitle style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelHandelBlock) cancelHandelBlock();
            if (shareManager.timer) shareManager.timer = nil;
        }];
        [alertController addAction: cancelAction];
    }
    
    if ([self transform: confirmButtonTitle]) {
        index += 1;
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle: confirmButtonTitle style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmHandelBlock) confirmHandelBlock();
            if (shareManager.timer) shareManager.timer = nil;
        }];
        [alertController addAction: confirmAction];
    }
    
    if ([self transform: destructiveButtonTitle]) {
        index += 1;
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle: destructiveButtonTitle style: UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (destructiveHandelBlock) destructiveHandelBlock();
            if (shareManager.timer) shareManager.timer = nil;
        }];
        [alertController addAction: destructiveAction];
    }
    
    for (NSString *otherButtonTitle in otherButtonTitles) {
        if ([self transform: otherButtonTitle]) {
            index += 1;
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle: otherButtonTitle style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (otherHandelBlock) otherHandelBlock(index);
                if (shareManager.timer) shareManager.timer = nil;
            }];
            [alertController addAction: otherAction];
        }
    }
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController: alertController animated: YES completion: nil];
}




#pragma mark - 字符串转换  当字符串为nil或者长度为0时 返回nil
+ (id)transform:(NSString *)string {
    
    if (string == nil) return string;
    
    NSString *object = [NSString stringWithFormat: @"%@", string];
    
    if (object.length == 0) {
        
        return nil;
    }
    return object;
}

#pragma mark - 按钮添加倒计时
+ (void)addTimer:(UIAlertAction *)action {
    shareManager = [self shareManager];
    if (!shareManager.timer) {
        // 倒计时时间
        __block int timeout = 60;
        if (timeout != 0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            shareManager.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(shareManager.timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(shareManager.timer, ^{
                if (timeout<=0) {
                    dispatch_source_cancel(shareManager.timer);
                    shareManager.timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [action setValue:[NSString stringWithFormat:@"%@(%02d)", action.title, 0] forKey: @"title"];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [action setValue: [NSString stringWithFormat: @"%@(%02d)", action.title, timeout] forKey: @"title"];
                    });
                    timeout --;
                }
            });
            dispatch_resume(shareManager.timer);
        }
    }
}

@end
