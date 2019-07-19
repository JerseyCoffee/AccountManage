//
//  JSDUserDataManage.m
//  AccountCheat
//
//  Created by ada on 2019/7/18.
//  Copyright © 2019 Jersey. All rights reserved.
//

#import "JSDUserDataManage.h"

NSString *const kJSDAppPasswrod = @"jersey";
static NSString* const kPassword = @"password";
static NSString* const kPasswordKey = @"passwordKey";
static NSString* const kUsePassword = @"usePassword";
static NSString* const kUseFingerprint = @"useFingerprint";
@implementation JSDUserPasswordModel

+ (BOOL)supportsSecureCoding {
    
    return YES;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
    if (JSDIsString(self.passwrod)) {
        [aCoder encodeObject:self.passwrod forKey: kPassword];
    }
    if (JSDIsString(self.passwordKey)) {
        [aCoder encodeObject:self.passwrod forKey: kPasswordKey];
    }
    
    [aCoder encodeBool:self.usePassword forKey: kUsePassword];
    [aCoder encodeBool:self.useFingerprint forKey: kUseFingerprint];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        _passwrod = [aDecoder decodeObjectForKey: kPassword];
        _passwordKey = [aDecoder decodeObjectForKey: kPasswordKey];
        _usePassword = [aDecoder decodeBoolForKey: kUsePassword];
        _useFingerprint = [aDecoder decodeBoolForKey: kUseFingerprint];
    }
    return self;
}

@end

static NSString* const kJSDUserFiledPath = @"userDoc";
static id instance;

@interface JSDUserDataManage ()

@property (copy, nonatomic) NSString *passFilePath;

@end

@implementation JSDUserDataManage

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JSDUserDataManage alloc] init];
    });
    return instance;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self readPassData];
    }
    return self;
}

- (void)readPassData {
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.passFilePath])
    {
        id object = [NSKeyedUnarchiver unarchiveObjectWithFile:self.passFilePath];
        _passwordModel = [object isKindOfClass:[JSDUserPasswordModel class]] ? object : [[JSDUserPasswordModel alloc] init];
    } else {
        _passwordModel = [[JSDUserPasswordModel alloc] init];
    }
}

- (void)savePassData {
    
    NSData* data = [NSData data];
    if (_passwordModel) {
        if (@available(iOS 11.0, *)) {
            NSError* error;
            data = [NSKeyedArchiver archivedDataWithRootObject:_passwordModel requiringSecureCoding:YES error: &error];
            if (error) {
                NSLog(@"%@", error);
            }
        } else {
            data = [NSKeyedArchiver archivedDataWithRootObject:_passwordModel];
        }
    }
    if (data) {
        [data writeToFile:self.passFilePath atomically:YES];
    }
    
}

- (NSString *)passFilePath {
    
    if (!_passFilePath) {
        static NSString *appDocumentPath = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSString *appKey = @"jersey";
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            appDocumentPath= [[NSString alloc]initWithFormat:@"%@/%@/",[paths objectAtIndex:0],appKey];
            if (![[NSFileManager defaultManager] fileExistsAtPath:appDocumentPath])
            {
                [[NSFileManager defaultManager] createDirectoryAtPath:appDocumentPath
                                          withIntermediateDirectories:NO
                                                           attributes:nil
                                                                error:nil];
            }
//            [NIMKitFileLocationHelper addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:appDocumentPath]];
        });
       _passFilePath =  [appDocumentPath stringByAppendingPathComponent:kJSDUserFiledPath];
    }
    return _passFilePath;
}

@end
