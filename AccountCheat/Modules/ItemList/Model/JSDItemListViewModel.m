//
//  JSDItemListViewModel.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDItemListViewModel.h"

NSString* const kItemListFilePathName = @"itemList.json";

@implementation JSDItemListViewModel

- (NSMutableArray<JSDItemListModel *> *)itemList {
    
    if (!_itemList) {
        NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@/%@", _type, kItemListFilePathName]];
        NSData* data = [NSData dataWithContentsOfFile:path];
        if (data) {
            NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (array.count) {
                _itemList = [JSDItemListModel mj_objectArrayWithKeyValuesArray:array];
            } else {
              _itemList = [[NSMutableArray alloc] init];
            }
        } else {
            NSFileManager* fileManager = [NSFileManager defaultManager];
            NSString* fileName = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@", _type]];
            if (![fileManager fileExistsAtPath:fileName]) {
                NSError* error;
                [fileManager createDirectoryAtPath:fileName withIntermediateDirectories:NO attributes:nil error:&error];
                //TODO: 文件创建失败处理;
                if (error) {
                    NSLog(@"%@",error);
                }
            }
            _itemList = [[NSMutableArray alloc] init];
        }
    }
    return _itemList;
}

- (void)updata {
    
    _itemList = nil;
}

- (void)addItemModel:(JSDItemListModel *)model complectionBlock:(nonnull void (^)(void))complectionBlock {
    
    [self.itemList addObject:model];
    
    [self saveItemListWithcomplectionBlock:complectionBlock];
}

- (void)removeItemModel:(JSDItemListModel *)model complectionBlock:(void (^)(void))complectionBlock {
    
    [self.itemList removeObject:model];
    
    [self saveItemListWithcomplectionBlock:complectionBlock];
}

- (void)saveItemListWithcomplectionBlock:(void (^)(void))complectionBlock {
    
    NSArray* dataArray = [JSDItemListModel mj_keyValuesArrayWithObjectArray:self.itemList];
    NSData* data = dataArray.mj_JSONData;
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@/%@", _type, kItemListFilePathName]];
    [data writeToFile:path atomically:YES];
    
    complectionBlock ? complectionBlock () : NULL;
}

@end

@implementation JSDItemListModel


@end
