//
//  DataCenter.h
//  PocketBook
//
//  Created by kratos on 13-2-25.
//  Copyright (c) 2013年 ipointek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"
typedef void (^JSONResponseBlock)(NSDictionary* json);

@interface DataCenter : NSObject{
    //任务队列
    NSOperationQueue *queue;
    BOOL networkchecked;
}

@property (retain,strong) NSOperationQueue *queue;

+(DataCenter *)sharedCenter;

-(void)commandWith:(NSURL*)url onCompletion:(JSONResponseBlock)completionBlock;

@end
