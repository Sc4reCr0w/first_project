//
//  IBESRequest.h
//  CatalogueLite
//
//  Created by Pavel on 08.09.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^IBESRequestSuccess) (NSURLSessionDataTask *, id);
typedef void (^IBESRequestFailure) (NSURLSessionDataTask *, NSError *);

@interface IBESRequest : AFHTTPSessionManager

- (instancetype)init;

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(IBESRequestSuccess)success
                       failure:(IBESRequestFailure)failure;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(IBESRequestSuccess)succes
                      failure:(IBESRequestFailure)failure;

@end
