//
//  SunflowerCommon.h
//  Sunflower
//
//  Created by Connor Wood on 10/7/16.
//  Copyright © 2016 Connor Wood. All rights reserved.
//

/* Menu View */
#define PLAY_BUTTON_BOTTOM_HEIGHT (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  20 :  80
#define LEVEL_BUTTON_LEADING (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  200 :  60
#define LEVEL_BUTTON_TRAILING (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  200 :  60
#define LEVEL_BUTTON_TOP (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  70 :  100
#define LEVEL_BUTTON_BOTTOM (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  100 :  200
#define MAIN_MENU_SMALL_BUTTONS_LEADING_SPACE (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  50 :  20
#define USER_DATA_BAR_WIDTH (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  ([[UIScreen mainScreen] bounds].size.width - 190) :  ([[UIScreen mainScreen] bounds].size.width - 130)
/* Settings View */
#define SETTINGS_BUTTON_HEIGHT (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  40 :  80
#define SETTINGS_TBD_TOP (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  90 :  142
#define SETTINGS_GAME_SETTINGS_TOP (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  130 :  234
#define SETTINGS_MUTE_TOP (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  210 :  418
#define SETTINGS_QUIT_TOP (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  210 :  418
#define SETTINGS_SIGN_OUT_TOP (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  170 :  326
/* Profile View */
#define PROFILE_RIGHT_TOP1 (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  5 :  165
#define PROFILE_RIGHT_TOP2 (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  55 :  220
#define PROFILE_RIGHT_TOP3 (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  105 :  5
#define PROFILE_LEFT_LEADING (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  10 :  10
#define PROFILE_LEFT_TRAILING (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  250 :  10
#define PROFILE_RIGHT_LEADING (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  250 :  10
#define PROFILE_RIGHT_TRAILING (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  10 :  10
#define PROFILE_LEFT_TEXT_ORIENTATION (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  NSTextAlignmentLeft :  NSTextAlignmentCenter
#define PROFILE_RIGHT_TEXT_ORIENTATION (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ?  NSTextAlignmentRight :  NSTextAlignmentCenter


