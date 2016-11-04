//
//  IBESTaxonsRequest.m
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESTaxonsRequest.h"

@implementation IBESTaxonsRequest

- (NSURLSessionDataTask *)requestTaxons:(NSDictionary *)parameters successBlock:(IBESRequestSuccess)success failureBlock:(IBESRequestFailure)failure
{
    NSString *path = @"/api/taxonss";
    
    return [self GET:path parameters:parameters success:success failure:failure];
}

@end
