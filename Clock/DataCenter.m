//
//  DataCenter.m
//  PocketBook
//
//  Created by kratos on 13-2-25.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import "DataCenter.h"


@implementation DataCenter
@synthesize queue;

+(DataCenter *)sharedCenter
{
    static DataCenter *sharedCenter = nil;
    @synchronized(self){
        if(sharedCenter == nil){
            sharedCenter = [[DataCenter alloc] init];
            if (![sharedCenter queue]) {
                [sharedCenter setQueue:[[NSOperationQueue alloc] init]];
                [[sharedCenter queue] setMaxConcurrentOperationCount:4];
            }
        }
    }
    return sharedCenter;
}





- (id) copyWithZone:(NSZone*)zone
{
    return self;
}



-(void)commandWith:(NSURL*)url onCompletion:(JSONResponseBlock)completionBlock{
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    
    AFJSONRequestOperation *operation = [[AFJSONRequestOperation alloc] initWithRequest:urlRequest];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        //返回数据对象
        completionBlock(responseObject);
        [queue setMaxConcurrentOperationCount:[queue maxConcurrentOperationCount]-1];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //出错时提示错误
        completionBlock([NSDictionary dictionaryWithObject:[error localizedDescription] forKey:@"error"]);
        [queue setMaxConcurrentOperationCount:[queue maxConcurrentOperationCount]-1];
    }];
    [queue setMaxConcurrentOperationCount:[queue maxConcurrentOperationCount]+1];
    [queue addOperation:operation];
    
}


@end