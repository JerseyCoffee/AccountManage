//
//  UIColor+JSDStyle.h
//  MaterialColor
//
//  Created by Jersey on 2019/7/9.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JSDStyle)

+ (UIColor *)jsd_colorWithHexString:(NSString *)color; //颜色字符串转换为颜色

+ (UIColor *)jsd_grayColor;
+ (UIColor *)jsd_tealcolor;
+ (UIColor *)jsd_skyBluecolor;




+ (CAGradientLayer *)jsd_setGradualChangeView:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;

@end

NS_ASSUME_NONNULL_END
