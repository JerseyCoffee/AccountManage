//
//  UIImage+Tool.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/17.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)

+ (instancetype)jsd_imageName:(NSString *)name {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    
    return image;
}

@end
