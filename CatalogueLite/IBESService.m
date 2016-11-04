//
//  IBESService.m
//  CatalogueLite
//
//  Created by Pavel on 15.09.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESService.h"

@implementation IBESService

#pragma mark Error Handler

- (void (^)(NSURLSessionDataTask *, NSError *))failureWithBlock:(IBESServiceFailure)failureBlock
{
    void (^failure)(NSURLSessionDataTask *, NSError *) =
    ^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Request failed: %@", error);
        
         if(failureBlock)
         {
             void (^dyspatchBlock)() = ^{ failureBlock(error); };
             dispatch_async(dispatch_get_main_queue(), dyspatchBlock);
         }
     };
    
    return failure;
}

@end