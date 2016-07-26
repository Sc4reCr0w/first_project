//
//  CLHTTPController.m
//  CatalogueLite
//
//  Created by Pavel on 25.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "CLHTTPController.h"

@implementation CLHTTPController

#pragma Mark - Lazy initialization of instance variables

- (NSURLSessionConfiguration *)sessionConfig
{
    if (!_sessionConfig)
    {
        _sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    
    return _sessionConfig;
}

#pragma Mark - Public methods

- (void)downloadDataForURL:(NSURL *)addressURL withCallback:(void(^)(NSData *data, NSURLResponse *response, NSError *error))callback
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[self sessionConfig]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:addressURL completionHandler:callback];
    [dataTask resume];
}

@end
