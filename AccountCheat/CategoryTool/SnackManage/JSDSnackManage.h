//
//  JSDSnackManage.h
//  AccountCheat
//
//  Created by Jersey on 2019/7/18.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSDSnackManage : NSObject

+ (instancetype)sharedInstance;

- (void)showText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
