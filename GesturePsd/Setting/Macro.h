//
//  Macro.h
//  TestAPI
//
//  Created by 乔杰 on 2018/10/29.
//  Copyright © 2018年 乔杰. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#import <UIKit/UIKit.h>

/****************设备屏幕宽高相关****************/
#define ScreenWidth         [UIScreen mainScreen].bounds.size.width
#define ScreenHeight        [UIScreen mainScreen].bounds.size.height

/****************导航栏及标签栏高度设置****************/
#define NavHeight       44
#define StatusHeight    (ScreenHeight >= 812 ? 44: 20)
#define StatuDif        (ScreenHeight >= 812 ? 44: 0)
#define TabBarDif       (ScreenHeight >= 812 ? 34: 0)
#define StaNavHeight    (NavHeight + StatusHeight)


#define ColorWithHex(hex)           [UIColor colorWithRed: ((float)((hex & 0xFF0000) >> 16))/255.0 green: ((float)((hex & 0xFF00) >> 8))/255.0 blue: ((float)(hex & 0xFF))/255.0 alpha: 1.0]
#define Cycle_Line_color            ColorWithHex(0x909090)
#define Main_color                  ColorWithHex(0xF93750)
#define Main_text_color             ColorWithHex(0x404040)
#define Main_text_color_gray        ColorWithHex(0x808080)
#define Seperator_line_color        ColorWithHex(0xDCDCDC)
#define backGroundColor             [UIColor colorWithRed: 240.0/255.0 green:240.0/255.0 blue: 240.0/255.0 alpha: 1.0]


#define kUserDefaults               [NSUserDefaults standardUserDefaults]

#define Gesture_password_key        @"Gesture_password_key"
#define Gesture_password            [kUserDefaults objectForKey: Gesture_password_key] == nil ? @[] : ((NSArray *) [kUserDefaults objectForKey: Gesture_password_key])

#define Gesture_open_statu_key      @"Gesture_open_statu_key"
#define Gesture_open_statu          [[kUserDefaults objectForKey: Gesture_open_statu_key] isEqualToString: @"1"]

#define Touch_id_open_statu_key     @"Touch_id_open_statu"
#define Touch_id_open_statu         [[kUserDefaults objectForKey: Touch_id_open_statu_key] isEqualToString: @"1"]



#endif /* Macro_h */
