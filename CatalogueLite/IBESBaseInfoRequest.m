//
//  IBESBaseInfoRequest.m
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESBaseInfoRequest.h"

@implementation IBESBaseInfoRequest

- (NSURLSessionDataTask *)requestBaseInfo:(IBESRequestSuccess)success failure:(IBESRequestFailure)failure
{
    NSString *path = @"/api/base-info";
    
    return [self GET:path parameters:nil success:success failure:failure];
}

@end
