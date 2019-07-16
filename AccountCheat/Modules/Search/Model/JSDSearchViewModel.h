//
//  JSDSearchViewModel.h
//  AccountCheat
//
//  Created by Jersey on 2019/7/16.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSDItemListViewModel.h"

@interface JSDSearchViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<JSDItemListModel* >* listArray; //当前列表
@property (nonatomic, strong) NSMutableArray<JSDItemListModel* >* resultArray; //搜索结果
@property (nonatomic, copy) NSString* type; // searchType
@property (nonatomic, copy) NSString* searchText; // searchText;

- (void)executeSearchWithText:(NSString *)text type:(NSString *)type complection:(void (^)(void))complection;

@end

