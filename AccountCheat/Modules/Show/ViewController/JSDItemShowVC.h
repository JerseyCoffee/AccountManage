//
//  JSDItemShowVC.h
//  AccountCheat
//
//  Created by Jersey on 2019/7/16.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "MDCCollectionViewController.h"

#import "JSDPublic.h"
NS_ASSUME_NONNULL_BEGIN

@interface JSDItemShowVC : MDCCollectionViewController

@property (nonatomic, strong) JSDItemListModel* model;
@property (nonatomic, copy) NSString* typeName;
@property (nonatomic, strong) JSDItemListViewModel* viewModel;

@end

NS_ASSUME_NONNULL_END
