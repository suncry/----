//
//  KK_JsonValueTransformed.m
//  iwtsa
//
//  Created by Kratos on 14-1-10.
//  Copyright (c) 2014年 ipointek. All rights reserved.
//

#import "KK_JsonValueTransformed.h"

@implementation KK_JsonValueTransformed

+ (KK_JsonValueTransformed *)sharedJsonValueTransformed
{
    static KK_JsonValueTransformed *sharedJsonValueTransformedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedJsonValueTransformedInstance = [[self alloc] init];
    });
    return sharedJsonValueTransformedInstance;
}

// 将字典或者数组转化为JSON串
- (NSData *)toJSONData:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

- (NSString *)toJSONString:(id)theData
{
    NSData *jsonData = [self toJSONData:theData];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
}

// 将JSON串转化为字典或者数组
- (id)fromJSONDataToArrayOrNSDictionary:(NSData *)jsonData
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }

}

- (id)fromJSONStringTArrayOrNSDictionary:(NSString *)jsonString
{
   id jsonObject = [jsonString dataUsingEncoding:NSASCIIStringEncoding];
    return jsonObject;
}
@end
