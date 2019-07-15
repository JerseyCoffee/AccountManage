//
//  JSDMacro.h
//  MaterialColor
//
//  Created by Jersey on 2019/7/8.
//  Copyright © 2019 Jersey. All rights reserved.
//

#ifndef JSDMacro_h
#define JSDMacro_h

#pragma mark -- NSLog
//只在Debug模式下执行NSLog
#ifndef __OPTIMIZE__
//#define NSLog(fmt, ...) NSLog((@"\n[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt"\n\n"), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
//#define NSLog(fmt, ...) NSLog((@"%s" fmt), __FUNCTION__, ##__VA_ARGS__)
//#define NSLog(...) {}
#else
#define NSLog(...) {}
#endif

#pragma mark -- IPHONE Device

//获得屏幕的宽高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
//iPhoneX / iPhoneXS
#define  IsIphoneX_XS     (ScreenWidth == 375.f && ScreenHeight == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define  IsIphoneXR_XSMax    (ScreenWidth == 414.f && ScreenHeight == 896.f ? YES : NO)
//异性全面屏
#define  IsFullScreen    (isIphoneX_XS || isIphoneXR_XSMax)

// Status bar height.
#define StatusBarHeight     (isFullScreen ? 44.f : 20.f)

// Navigation bar height.
#define NavigationBarHeight  (StatusBarAndNavigationBarHeight - StatusBarHeight)

// Tabbar height.
#define TabbarHeight         (isFullScreen ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define TabbarSafeBottomMargin         (isFullScreen ? 34.f : 0.f)

// Status bar & navigation bar height.
#define StatusBarAndNavigationBarHeight  (isFullScreen ? 88.f : 64.f)

#pragma mark -- UI

#define IOS11        ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11.0)
//屏幕属性宏
#define Screen_Width ([UIScreen mainScreen].bounds.size.width)
#define Screen_Height ([UIScreen mainScreen].bounds.size.height)
// Get the screen's bounds.
#define Screen_Bounds ([UIScreen mainScreen].bounds)
//self.view属性宏
#define View_Width (self.view.bounds.size.width)
#define View_Height (self.view.bounds.size.height)

//颜色
//格式 0xdae8a6, 0.5
#define ColorWithFROMRGB(rgbValue, al)                        \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
blue:((float)(rgbValue & 0xFF)) / 255.0             \
alpha:al]

//RGB颜色
#define ColorWithRGB(r,g,b) ([UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.f])
//RGBA
#define ColorRGBAWithRGBA(r, g, b, a) ([UIColor colorWithRed:(r) / 255.0  \
green:(g) / 255.0  \
blue :(b) / 255.0  \
alpha:(a)])

//weak对象，用于block，例：@weakify(self)
#ifndef    weakify
#if __has_feature(objc_arc)
#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")
#else
#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")
#endif
#endif
//strong对象，用于block，例：@strongify(self)
#ifndef    strongify
#if __has_feature(objc_arc)
#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")
#else
#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")
#endif
#endif
#endif /* JSDMacro_h */

