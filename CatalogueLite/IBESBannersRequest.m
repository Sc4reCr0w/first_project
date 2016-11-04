//
//  IBESBannersRequest.m
//  CatalogueLite
//
//  Created by Pavel on 28.09.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESBannersRequest.h"

@implementation IBESBannersRequest

- (NSURLSessionDataTask *)requestBanners:(IBESRequestSuccess)success failure:(IBESRequestFailure)failure
{
    NSString *path = @"/api/banners";
    
    return [self GET:path parameters:nil success:success failure:failure];
}

@end
