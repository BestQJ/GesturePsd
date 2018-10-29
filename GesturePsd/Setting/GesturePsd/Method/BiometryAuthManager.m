//
//  BiometryAuthManager.m
//  TestAPI
//
//  Created by 乔杰 on 2018/10/29.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import "BiometryAuthManager.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation BiometryAuthManager

static BiometryAuthManager *shareManager = nil;

+ (BiometryAuthManager *)shareMannager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shareManager = [[BiometryAuthManager alloc] init];
    });
    return shareManager;
}


#pragma mark - 开启生物识别
- (void)judgeTouchAuth:(void(^)(BOOL success, NSString *errorDecription))confirmHandler {
    LAPolicy policy;
    if (@available(iOS 9.0, *)) {
        policy = LAPolicyDeviceOwnerAuthentication;
    }else {
        policy = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
    }
    if ([self isSupportBiometry]) {
        
        [self startAuthWithPolicy: policy confirmHandler: confirmHandler];
    }else {
        if (confirmHandler) {
            confirmHandler(NO, @"设备不支持指纹识别或人脸识别");
        }
    }
}

- (void)startAuthWithPolicy:(LAPolicy)policy confirmHandler:(void(^)(BOOL success, NSString *errorDecription))confirmHandler {
    
    LAContext *myContext = [[LAContext alloc] init];
    myContext.localizedFallbackTitle = @"输入密码";

    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"请验证已有指纹或Face ID";
    if ([myContext canEvaluatePolicy:policy error: &authError]) {
        
        [myContext evaluatePolicy: policy localizedReason: myLocalizedReasonString reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                // 指纹识别成功，回主线程更新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (confirmHandler) {
                        confirmHandler(success, @"指纹或Face ID识别成功");
                    }
                });
            }else {
                //指纹识别失败，回主线程更新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    //失败操作
                    LAError errorCode = error.code;
                    NSString *errorDecription = @"";
                    if (@available(iOS 9.0, *)) {
                        switch (errorCode) {
                            case LAErrorAuthenticationFailed:
                                errorDecription = @"授权失败";
                                break;
                            case LAErrorUserCancel:
                                errorDecription = @"用户取消验证Touch ID或Face ID";
                                break;
                            case LAErrorUserFallback:
                                errorDecription = @"用户选择输入密码，切换主线程处理";
                                break;
                            case LAErrorSystemCancel:
                                errorDecription = @"取消授权，如其他应用切入";
                                break;
                            case LAErrorPasscodeNotSet:
                                errorDecription = @"设备系统未设置密码";
                                break;
                            case LAErrorBiometryNotAvailable:
                                errorDecription = @"设备未设置Touch ID或Face ID";
                                break;
                            case LAErrorBiometryNotEnrolled:
                                errorDecription = @"用户未录入指纹或人脸信息";
                                break;
                            case LAErrorBiometryLockout:
                                errorDecription = @"Touch ID或Face ID被锁，需要用户输入密码解锁";
                                break;
                            case LAErrorAppCancel:
                                errorDecription = @"用户不能控制情况下APP被挂起";
                                break;
                            case LAErrorInvalidContext:
                                errorDecription = @"LAContext传递给这个调用之前已经失效";
                                break;
                            case LAErrorNotInteractive:
                                break;
                        }
                    }
                    if (confirmHandler) {
                        confirmHandler(success, errorDecription);
                    }
                });
            }
        }];
    }
}

#pragma mark - 是否支持Touch ID或Face ID
- (BOOL)isSupportBiometry {
    LAContext *context = [[LAContext alloc] init];
    BOOL isSupportBiometry = NO;
    isSupportBiometry = [context canEvaluatePolicy: LAPolicyDeviceOwnerAuthenticationWithBiometrics error: nil];
    return isSupportBiometry;
}



@end
