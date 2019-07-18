//
//  JSMyCenterViewModel.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/18.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDMyCenterViewModel.h"

@implementation JSDMyCenterModel



@end

@implementation JSDMyCenterViewModel

- (NSArray<JSDMyCenterModel *> *)array {
    
    if (!_array) {
//        _array = [JSDMyCenterModel mj_keyValuesArrayWithObjectArray: [self defaultArray]];
        _array = [JSDMyCenterModel mj_objectArrayWithKeyValuesArray: [self defaultArray]];
    }
    return _array;
}

- (NSArray* )defaultArray {
    
    return @[@{@"title": @"修改密码",
               @"image": @"mac_note",
               @"router": @"",
              },
             @{@"title": @"密码保护",
               @"image": @"mac_note",
               @"router": @"",
             },
             @{@"title": @"安全相关",
               @"image": @"password4",
               @"router": @"",
             },
             @{@"title": @"添加分类",
               @"image": @"mac_note",
               @"router": @"",
             },
             @{@"title": @"意见反馈",
               @"image": @"mac_note",
               @"router": @"",
             },
             @{@"title": @"关于我们",
               @"image": @"mac_note",
               @"router": @"JSDAboutWeVC",
             },];
}

@end
