//
//  JSDUserPasswordManage.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/19.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDUserPasswordCheckManage.h"

#import "JSDUserDataManage.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "JSDSnackManage.h"

static id instance;

@interface JSDUserPasswordCheckManage ()

@property (nonatomic, strong) JSDUserDataManage* userDataManage;
@property (nonatomic, strong) UIAlertController* alertController;

@end

@implementation JSDUserPasswordCheckManage

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JSDUserPasswordCheckManage alloc] init];
    });
    return instance;
}

- (void)checkPasswrod {
    
    JSDUserPasswordModel* passwordModel = self.userDataManage.passwordModel;
    if (passwordModel.useFingerprint) {
        if (passwordModel.usePassword) {
            if (JSDIsString(passwordModel.passwrod)) {
                //弹出指纹,并且点击取消时,是密码输入框
                //弹出密码输入框
                [self showPasswordCheck];
            }
        } else {
            //只谈指纹
//            [self showssss];
        }
    } else if (passwordModel.usePassword) {
        //弹出密码输入框
        [self showPasswordCheck];
    }
}

- (JSDUserDataManage *)userDataManage {
    
    if (!_userDataManage) {
        _userDataManage = [JSDUserDataManage sharedInstance];
    }
    return _userDataManage;
}

- (void)showFingerprintCheck {
    
    //只弹出指纹
    LAContext* context = [[LAContext alloc] init];
    NSError* error = nil;
    BOOL canUse = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if(canUse) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Jersey请您验证指纹" reply:^(BOOL success, NSError* error) {
            NSLog(@"evaluatePolicy Biometrics %@",error);
            if (success) {
                //注意我们在执行回调的时候必须使用异步、否则会卡顿。影响体验*
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"成功");
//                    [context invalidate];
                });
            } else {
                switch (error.code) {
                    case LAErrorTouchIDLockout:
                    {
                        NSLog(@"验证失败，由于认证次数超过指定次数。账户可能会被锁定");
                        // 我再这里调用封装好的方法，让用户先去验证一次手机密码，成功之后才能继续使用指纹验证。
//                        JSDUserPasswordModel* passwordModel = self.userDataManage.passwordModel;
                        
                    }
                        break;
                    case LAErrorUserCancel:
                    {
                        NSLog(@"验证失败，用户点击取消");
                    }
                        break;
                    default:
                    {
                    }
                        break;
                }
            }
        }];
    }
}

- (void)showPasswordCheck {
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"通过密码开启" message:@"请输入密码进行验证" preferredStyle:UIAlertControllerStyleAlert];
    JSDSnackManage* manage = [JSDSnackManage sharedInstance];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    @weakify(self)
    UIAlertAction* forgetAction = [UIAlertAction actionWithTitle:@"忘记密码" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self)
        [self showPasswordKeyCheck];
    }];
    
    UIAlertAction* checkAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self)
        if ([self.userDataManage.passwordModel.passwrod isEqualToString: alertController.textFields.firstObject.text]) {
            
            [manage showText:@"密码正确"];
        } else {
            [self showPasswordCheck];
            UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码错误, 请重新输入" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alerView show];
        }
    }];
    [alertController addAction:forgetAction];
    [alertController addAction:checkAction];
    
    [JSDAppWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)showPasswordKeyCheck {
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"校验密保" message:@"请输入密保进行验证" preferredStyle:UIAlertControllerStyleAlert];
    JSDSnackManage* manage = [JSDSnackManage sharedInstance];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    UIAlertAction* forgetAction = [UIAlertAction actionWithTitle:@"忘记密保" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请联系技术支持获取帮助Email: zexi0625@gmail.com" delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
        [alerView show];
    }];
    @weakify(self)
    UIAlertAction* checkAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        @strongify(self)
        if ([self.userDataManage.passwordModel.passwordKey isEqualToString: alertController.textFields.firstObject.text]) {
            
            [manage showText:@"密保正确"];
        } else {
            [self showPasswordKeyCheck];
            UIAlertView* alerView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密保错误, 请重新输入" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alerView show];
        }
    }];
    [alertController addAction:forgetAction];
    [alertController addAction:checkAction];
    
    [JSDAppWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}

@end
