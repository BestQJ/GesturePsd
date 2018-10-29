//
//  BiometryAuthManager.h
//  TestAPI
//
//  Created by 乔杰 on 2018/10/29.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BiometryAuthManager : NSObject

+ (BiometryAuthManager *)shareMannager;

- (void)judgeTouchAuth:(void(^)(BOOL success, NSString *errorDecription))confirmHandler;

- (BOOL)isSupportBiometry;

@end

NS_ASSUME_NONNULL_END
