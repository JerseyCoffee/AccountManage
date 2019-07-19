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
               @"image": @"setting_password",
               @"router": havaPassword ? @"JSDModifiPasswordVC": @"JSDSettingPasswordVC",
              },
             @{@"title": @"密码保护",
//               @"image": @"security_password",
               @"image": @"password3",
               @"router": @"JSDPasswordSecurityVC",
             }, // 暂时去掉密码保护功能
             @{@"title": @"安全相关",
               @"image": @"security_setting",
               @"router": @"JSDSecurityVC",
             },
             @{@"title": @"添加分类",
               @"image": @"add_type",
               @"router": @"JSDAddTypeVC",
             },
             @{@"title": @"意见反馈",
               @"image": @"feedback",
               @"router": @"JSDFeedbackVC",
             },
             @{@"title": @"关于我们",
               @"image": @"about_my",
               @"router": @"JSDAboutWeVC",
             },];
}

@end
