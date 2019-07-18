//
//  JSDMyCenterVC.h
//  AccountCheat
//
//  Created by Jersey on 2019/7/18.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "MDCCollectionViewController.h"
#import "MDCFlexibleHeaderContainerViewController.h"
#import "JSDMyCenterContentVC.h"

NS_ASSUME_NONNULL_BEGIN

@class MDCCollectionViewCell;
@protocol MyCenterCollectionViewControllerDelegate <NSObject>

@optional

- (void)didSelectCell:(MDCCollectionViewCell *)cell
           completion:(void (^)(void))completionBlock;

@end

@interface JSDMyCenterVC : MDCCollectionViewController

@property(nonatomic) CGFloat scrollOffsetY;
@property(weak, nonatomic) id<MyCenterCollectionViewControllerDelegate> delegate;
@property(nonatomic) JSDMyCenterContentVC *flexHeaderContainerVC;
@end

NS_ASSUME_NONNULL_END
