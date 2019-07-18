//
//  JSMyCenterViewModel.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/18.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDMyCenterViewModel.h"

#import "JSDUserDataManage.h"

@implementation JSDMyCenterModel



@end

@implementation JSDMyCenterViewModel

- (NSArray<JSDMyCenterModel *> *)array {
    
    if (!_array) {
        _array = [JSDMyCenterModel mj_objectArrayWithKeyValuesArray: [self defaultArray]];
    }
    return _array;
}

- (NSArray* )defaultArray {
    
    JSDUserDataManage* userDataManage = [JSDUserDataManage sharedInstance];
    BOOL havaPassword = JSDIsString(userDataManage.passwordModel.passwrod) ? YES : NO;
    
    return @[@{@"title": havaPassword ? @"修改密码" : @"设置密码",
               @"image": @"mac_note",
               @"router": havaPassword ? @"JSDModifiPasswordVC": @"JSDSettingPasswordVC",
              },
             @{@"title": @"密码保护",
               @"image": @"mac_note",
               @"router": @"JSDPasswordSecurityVC",
             },
             @{@"title": @"安全相关",
               @"image": @"password4",
               @"router": @"JSDSecurityVC",
             },
             @{@"title": @"添加分类",
               @"image": @"mac_note",
               @"router": @"JSDAddTypeVC",
             },
             @{@"title": @"意见反馈",
               @"image": @"mac_note",
               @"router": @"JSDFeedbackVC",
             },
             @{@"title": @"关于我们",
               @"image": @"mac_note",
               @"router": @"JSDAboutWeVC",
             },];
}

@end
