//
//  JSDSecurityViewModel.h
//  AccountCheat
//
//  Created by Jersey on 2019/7/19.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSDSecurityModel : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* subTitle;
@property (nonatomic, copy) NSString* tipTitle;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, copy) NSString* type; //标识

@end

@interface JSDSecurityViewModel : NSObject

@property (nonatomic, strong) NSArray<NSArray<JSDSecurityModel *> *>* array;

@end

NS_ASSUME_NONNULL_END
