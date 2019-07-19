//
//  JSDSecurityViewModel.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/19.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDSecurityViewModel.h"

#import "JSDUserDataManage.h"

@implementation JSDSecurityModel



@end

@implementation JSDSecurityViewModel

- (NSArray<NSArray<JSDSecurityModel *> *> *)array {
    
    JSDUserDataManage* dataManage = [JSDUserDataManage sharedInstance];
    BOOL openPassword = dataManage.passwordModel.usePassword;
    BOOL openFingerprint = dataManage.passwordModel.useFingerprint;
    NSString* passWrodtipTitle = dataManage.passwordModel.passwrod.length ? @"" : @"请先去设置密码";
    if (!_array) {
        NSArray* defaltArray = @[@[@{@"title": @"使用密码解锁",
                                   @"subTitle": @"",
                                   @"tipTitle": passWrodtipTitle,
                                   @"isOpen": @(openPassword),
                                     @"type": @"密码",
                                   },
                                 @{@"title": @"使用指纹解锁",
                                   @"subTitle": @"",
                                   @"tipTitle": @"",
                                   @"isOpen": @(openFingerprint),
                                   @"type": @"指纹",
                                 },],
//                                 @[@{@"title": @"使用密码解锁",
//                                     @"subTitle": @"",
//                                     @"tipTitle": passWrodtipTitle,
//                                     @"isOpen": @(openPassword),
//                                 },
//                                   @{@"title": @"使用指纹解锁",
//                                     @"subTitle": @"",
//                                     @"tipTitle": @"",
//                                     @"isOpen": @(openFingerprint),
//                                   }],
        ];
        _array = [JSDSecurityModel mj_objectArrayWithKeyValuesArray:defaltArray];
    }
    return _array;
}

@end
