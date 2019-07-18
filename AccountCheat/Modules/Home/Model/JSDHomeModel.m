//
//  JSDHomeModel.m
//  AccountCheat
//
//  Created by Jersey on 2019/7/15.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDHomeModel.h"

NSString* const kTypeFilePathName = @"typeData.json";

@implementation JSDHomeModel

@end

@implementation JSDHomeViewModel

- (NSMutableArray<JSDHomeModel *> *)typeArray {
    
    if (!_typeArray) {
        
        NSFileManager* fileManager = [NSFileManager defaultManager];
        //指向文件目录
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString* path = [NSString stringWithFormat:@"%@/%@", documentsDirectory, kTypeFilePathName];
        NSString* dataPath = path;
        if ([fileManager fileExistsAtPath:path]) {
        } else {
            dataPath = [[NSBundle mainBundle] pathForResource:@"typeData" ofType:@"json"];
        }
        NSData* data = [NSData dataWithContentsOfFile:dataPath];
        NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        _typeArray = [JSDHomeModel mj_objectArrayWithKeyValuesArray:array];
    }
    return _typeArray;
}

- (void)updateData {
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    //指向文件目录
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* path = [NSString stringWithFormat:@"%@/%@", documentsDirectory, kTypeFilePathName];
    NSString* dataPath = path;
    if ([fileManager fileExistsAtPath:path]) {
    } else {
        dataPath = [[NSBundle mainBundle] pathForResource:@"typeData" ofType:@"json"];
    }
    NSData* data = [NSData dataWithContentsOfFile:dataPath];
    NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    _typeArray = [JSDHomeModel mj_objectArrayWithKeyValuesArray:array];
}

@end
