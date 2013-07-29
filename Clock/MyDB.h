//
//  MyDB.h
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"

@interface MyDB : NSObject
{
    FMDatabase *_db;

}
- (void)openDB;
//clock 表 的操作
- (NSString *)isON:(int)day;
- (void)setON:(NSString *)yesOrNo
          day:(int)day;

- (int)hour:(int)day;
- (void)setHour:(int)hour
            day:(int)day;

- (int)minute:(int)day;
- (void)setMinute:(int)minute
            day:(int)day;
//setting 表 的操作
- (int)color;
- (void)setColor:(int)color;

- (int)year;
- (void)setYear:(int)year;

- (int)month;
- (void)setMonth:(int)month;

- (int)day;
- (void)setDay:(int)day;
@end
