//
//  JSDUserDataManage.h
//  AccountCheat
//
//  Created by ada on 2019/7/18.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString* _Nonnull const kJSDAppPasswrod;

@interface JSDUserPasswordModel : NSObject <NSSecureCoding>

@property (copy, nonatomic) NSString *passwrod;
@property (copy, nonatomic) NSString *passwordKey; //密保
@property (assign, nonatomic) BOOL usePassword;
@property (assign, nonatomic) BOOL useFingerprint;

@end

@interface JSDUserDataManage : NSObject

@property (strong, nonatomic) JSDUserPasswordModel *passwordModel;

+ (instancetype)sharedInstance;

- (void)savePassData;
- (void)readPassData;

@end

NS_ASSUME_NONNULL_END
