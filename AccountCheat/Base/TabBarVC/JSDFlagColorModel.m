//
//  JSDFlagColorModel.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/17.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDFlagColorModel.h"

@implementation JSDFlagColorModel

- (NSArray *)colorArray {
    
    if (!_colorArray) {
        _colorArray = @[@"#FF0000", @"#FFC0CB", @"#800080", @"#0000FF", @"#FFA500",@"#FFFF00",@"#A52A2A", @"#FF4500", @"#008000"
        ];
    }
    return _colorArray;
}

- (NSArray *)colorNameArray {
    
    if (!_colorNameArray) {
        _colorNameArray = @[@"红色", @"粉色",@"紫色", @"蓝色", @"橙色", @"黄色",@"褐色",@"绿色"];
    }
    return _colorNameArray;
}

@end
