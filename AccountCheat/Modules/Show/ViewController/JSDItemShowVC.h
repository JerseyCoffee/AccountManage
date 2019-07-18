//
//  JSDItemShowVC.h
//  AccountCheat
//
//  Created by Jersey on 2019/7/16.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDBaseCollectionController.h"

#import "JSDPublic.h"
NS_ASSUME_NONNULL_BEGIN
//TODO: 
@interface JSDItemShowVC : JSDBaseCollectionController

@property (nonatomic, strong) JSDItemListModel* model;
@property (nonatomic, copy) NSString* typeName;
@property (nonatomic, strong) JSDItemListViewModel* viewModel;

@end

NS_ASSUME_NONNULL_END
