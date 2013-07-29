//
//  MyDB.m
//  Clock
//
//  Created by Suncry on 13-6-24.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "MyDB.h"

@implementation MyDB
- (void)openDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.db"];
    _db = [FMDatabase databaseWithPath:dbPath];
    if (![_db open])
    {
        NSLog(@"could not open DB!!!");
        return;
    }
    if (![_db tableExists:@"clock"])//如果没有创建表 那么就创建并且初始化
    {
        [_db executeUpdate:@"create table clock (id integer,isON text,Hour integer,Minute integer)"];
        
        [_db executeUpdate:@"insert into clock (id,isON, Hour, Minute) values (?,?,?,?)",
         [NSNumber numberWithInt:1],
          @"NO",
         [NSNumber numberWithInt:8],
         [NSNumber numberWithInt:0]];
        [_db executeUpdate:@"insert into clock (id,isON, Hour, Minute) values (?,?,?,?)",
         [NSNumber numberWithInt:2],
          @"NO",
         [NSNumber numberWithInt:8],
         [NSNumber numberWithInt:0]];
        [_db executeUpdate:@"insert into clock (id,isON, Hour, Minute) values (?,?,?,?)",
         [NSNumber numberWithInt:3],
          @"NO",
         [NSNumber numberWithInt:8],
         [NSNumber numberWithInt:0]];
        [_db executeUpdate:@"insert into clock (id,isON, Hour, Minute) values (?,?,?,?)",
         [NSNumber numberWithInt:4],
          @"NO",
         [NSNumber numberWithInt:8],
         [NSNumber numberWithInt:0]];
        [_db executeUpdate:@"insert into clock (id,isON, Hour, Minute) values (?,?,?,?)",
         [NSNumber numberWithInt:5],
          @"NO",
         [NSNumber numberWithInt:8],
         [NSNumber numberWithInt:0]];
        [_db executeUpdate:@"insert into clock (id,isON, Hour, Minute) values (?,?,?,?)",
         [NSNumber numberWithInt:6],
          @"NO",
         [NSNumber numberWithInt:8],
         [NSNumber numberWithInt:0]];
        [_db executeUpdate:@"insert into clock (id,isON, Hour, Minute) values (?,?,?,?)",
         [NSNumber numberWithInt:7],
          @"NO",
         [NSNumber numberWithInt:8],
         [NSNumber numberWithInt:0]];
        
        NSLog(@"clock 表 创建语句执行了！！！！");

    }
    if (![_db tableExists:@"setting"])//如果没有创建表 那么就创建并且初始化
    {
        //获取当前年
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        //用于设定 年的初始值
        [formatter setDateFormat:@"YYYY"];
        
        [_db executeUpdate:@"create table setting (Color integer,Year integer,Month integer,Day integer)"];
        
        [_db executeUpdate:@"insert into setting (Color,Year, Month, Day) values (?,?,?,?)",
         [NSNumber numberWithInt:0],//范围0到4 代表 5种颜色主题
         [NSNumber numberWithInt:[[formatter stringFromDate:[NSDate date]]intValue] - 25],
         [NSNumber numberWithInt:6],
         [NSNumber numberWithInt:15]];
        NSLog(@"setting 表 创建语句执行了！！！！");
        NSLog(@"默认的 年 为 %d",[[formatter stringFromDate:[NSDate date]]intValue] - 25);
        
    }
}
- (NSString *)isON:(int)day
{
    [self openDB];
    NSString *queryString =[[NSString alloc]initWithFormat:@"select isON from clock where id = %d",day];
    return [_db stringForQuery:queryString];
}
- (void)setON:(NSString *)yesOrNo
          day:(int)day
{
    [self openDB];

    [_db executeUpdate:@"update clock set isON = ? where id = ?",yesOrNo,[NSNumber numberWithInt:day]];
}

- (int)hour:(int)day
{
    [self openDB];

    NSString *queryString =[[NSString alloc]initWithFormat:@"select Hour from clock where id = %d",day];
    return [_db intForQuery:queryString];
}
- (void)setHour:(int)hour
            day:(int)day
{
    [self openDB];

    [_db executeUpdate:@"update clock set Hour = ? where id = ?",[NSNumber numberWithInt:hour],[NSNumber numberWithInt:day]];

}

- (int)minute:(int)day
{
    [self openDB];

    NSString *queryString =[[NSString alloc]initWithFormat:@"select Minute from clock where id = %d",day];
    return [_db intForQuery:queryString];

}
- (void)setMinute:(int)minute
              day:(int)day
{
    [self openDB];

    [_db executeUpdate:@"update clock set Minute = ? where id = ?",[NSNumber numberWithInt:minute],[NSNumber numberWithInt:day]];
 
}

- (int)color
{
    [self openDB];
    NSString *queryString =[[NSString alloc]initWithFormat:@"select Color from setting"];
    return [_db intForQuery:queryString];
}
- (void)setColor:(int)color
{
    [self openDB];
    
    [_db executeUpdate:@"update setting set Color = ?",[NSNumber numberWithInt:color]];

}

- (int)year
{
    [self openDB];
    NSString *queryString =[[NSString alloc]initWithFormat:@"select Year from setting"];
    return [_db intForQuery:queryString];
}
- (void)setYear:(int)year
{
    [self openDB];
    
    [_db executeUpdate:@"update setting set Year = ?",[NSNumber numberWithInt:year]];
}

- (int)month
{
    [self openDB];
    NSString *queryString =[[NSString alloc]initWithFormat:@"select Month from setting"];
    return [_db intForQuery:queryString];
}
- (void)setMonth:(int)month
{
    [self openDB];
    
    [_db executeUpdate:@"update setting set Month = ?",[NSNumber numberWithInt:month]];
}

- (int)day
{
    [self openDB];
    NSString *queryString =[[NSString alloc]initWithFormat:@"select Day from setting"];
    return [_db intForQuery:queryString];
}
- (void)setDay:(int)day
{
    [self openDB];
    
    [_db executeUpdate:@"update setting set Day = ?",[NSNumber numberWithInt:day]];
}
@end
