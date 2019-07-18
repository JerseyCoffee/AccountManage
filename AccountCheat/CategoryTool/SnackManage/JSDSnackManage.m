//
//  JSDSnackManage.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/18.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDSnackManage.h"

#import <MaterialComponents/MaterialSnackbar.h>

static id instance;
@interface JSDSnackManage ()

@property (nonatomic, strong) MDCSnackbarManager* manage;
@property (nonatomic, strong) MDCSnackbarMessage* message;

@end

@implementation JSDSnackManage

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JSDSnackManage alloc] init];
    });
    return instance;
}

- (MDCSnackbarManager *)manage {
    
    if (!_manage) {
        _manage = [MDCSnackbarManager defaultManager];
    }
    return _manage;
}

- (MDCSnackbarMessage *)message {
    
    if (!_message) {
        _message = [MDCSnackbarMessage messageWithText: @"温馨提示"];
    }
    return _message;
}

- (void)showText:(NSString *)text {
    
    self.message.text = text;
    [self.manage showMessage:self.message];
}

@end
