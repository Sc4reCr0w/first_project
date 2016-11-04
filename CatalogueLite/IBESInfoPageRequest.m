//
//  IBESInfoPageRequest.m
//  CatalogueLite
//
//  Created by Pavel on 12.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESInfoPageRequest.h"

@implementation IBESInfoPageRequest

- (NSURLSessionDataTask *)requestInfoPages:(IBESRequestSuccess)success failure:(IBESRequestFailure)failure
{
    NSString *path = @"/api/infopage";
    
    return [self GET:path parameters:nil success:success failure:failure];
}

@end
