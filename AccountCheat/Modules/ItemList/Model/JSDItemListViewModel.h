//
//  JSDItemListViewModel.h
//  AccountCheat
//
//  Created by Jersey on 2019/7/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *_Nonnull const kItemListFilePathName;
NS_ASSUME_NONNULL_BEGIN

@interface JSDItemListModel : NSObject

@property (nonatomic, copy) NSString* name;      //名称
@property (nonatomic, copy) NSString* account;   //账号
@property (nonatomic, copy) NSString* password;  //密码
@property (nonatomic, copy) NSString* type;      //分类
@property (nonatomic, copy) NSString* remark;    //备注

@end

@interface JSDItemListViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<JSDItemListModel* >* itemList;
@property (nonatomic, copy) NSString* type;

- (void)updata;
- (void)addItemModel:(JSDItemListModel *)model complectionBlock:(void(^)(void))complectionBlock;
- (void)removeItemModel:(JSDItemListModel *)model complectionBlock:(void(^)(void))complectionBlock;

@end



NS_ASSUME_NONNULL_END
