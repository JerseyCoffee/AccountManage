//
//  JSDHomeCollectionViewCell.h
//  AccountCheat
//
//  Created by Jersey on 2019/7/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "MDCCollectionViewCell.h"

#import "JSDHomeModel.h"
#import "JSDPublic.h"
NS_ASSUME_NONNULL_BEGIN

@interface JSDHomeCollectionViewCell : MDCCollectionViewTextCell

@property (nonatomic, strong) JSDHomeModel* model;

@end

NS_ASSUME_NONNULL_END
