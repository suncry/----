//
//  KK_JsonValueTransformed.h
//  iwtsa
//
//  Created by Kratos on 14-1-10.
//  Copyright (c) 2014年 ipointek. All rights reserved.
//  NSDiction,NSArray 与 Json 互转

#import <Foundation/Foundation.h>

@interface KK_JsonValueTransformed : NSObject

+ (KK_JsonValueTransformed *)sharedJsonValueTransformed;
// 将字典或者数组转化为JSON串
- (NSData *)toJSONData:(id)theData;
- (NSString *)toJSONString:(id)theData;

// 将JSON串转化为字典或者数组
- (id)fromJSONDataToArrayOrNSDictionary:(NSData *)jsonData;
- (id)fromJSONStringTArrayOrNSDictionary:(NSString *)jsonString;
@end
