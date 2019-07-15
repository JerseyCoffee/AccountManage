//
//  JSDHomeModel.h
//  AccountCheat
//
//  Created by Jersey on 2019/7/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *_Nonnull const kTypeFilePathName;

NS_ASSUME_NONNULL_BEGIN

@interface JSDHomeModel : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* image;

@end

@interface JSDHomeViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<JSDHomeModel *>* typeArray;
- (void)updateData;

@end

NS_ASSUME_NONNULL_END
