//
//  IBESRequest.m
//  CatalogueLite
//
//  Created by Pavel on 08.09.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESRequest.h"

#define SERVER_ADDR @"http://136.243.226.243:8081"

static NSString *const IBESRequestErrorDomain = @"IBESRequestErrorDomain";
static NSString *const IBESRequestBaseURL = SERVER_ADDR;

static NSInteger const IBESRequestErrorUnknown = 0;

@implementation IBESRequest

#pragma mark - Initialization

- (instancetype)init
{
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", IBESRequestBaseURL]];
    self = [self initWithBaseURL:URL];
    
    if(self)
    {
        self.completionQueue = dispatch_queue_create("IBESRequest completion queue", DISPATCH_QUEUE_CONCURRENT);
    }
    
    return self;
}

#pragma mark - Requests

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(IBESRequestSuccess)success
                       failure:(IBESRequestFailure)failure
{
    
    return [super POST:[NSString stringWithFormat:@"%@", URLString]
            parameters:parameters
              progress:nil
               success:[self requestSuccessForSuccessBlock:success failureBlock:failure]
               failure:failure];
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(IBESRequestSuccess)success
                      failure:(IBESRequestFailure)failure
{
    return [super GET:[NSString stringWithFormat:@"%@", URLString]
           parameters:parameters
             progress:nil
              success:[self requestSuccessForSuccessBlock:success failureBlock:failure]
              failure:failure];
}

#pragma mark - Response Work

- (BOOL)isResponseHasFailedStatus:(id)response
{
    // Legacy Code
    //NSDictionary *json = response;
    //return [json[ISRequestStatusKey] isEqualToString:ISRequestStatusFailed];
    
    if(!response)
    {
        return YES;
    }
    
    return NO;
}

- (NSString *)messageFromResponse:(id)response
{
    // Legacy Code
    //NSDictionary *json = response;
    //return json[ISRequestMessageKey];
    return @"";
}

#pragma mark - Error Creation

// Override this method to create custom errors
- (NSError *)errorWithMessage:(NSString *)message
{
    return [self errorWithDomain:IBESRequestErrorDomain code:IBESRequestErrorUnknown description:NSLocalizedString(@"Request failed", nil) reason:message];
}

- (NSError *)errorWithDomain:(NSString *)domain
                        code:(NSInteger)code
                 description:(NSString *)description
                      reason:(NSString *)reason
{
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: description,
                               NSLocalizedFailureReasonErrorKey: reason ? reason : @""
                               };
    
    NSError *error = [NSError errorWithDomain:domain code:code userInfo:userInfo];
    return error;
}

#pragma mark - Helpers

- (void (^)(NSURLSessionDataTask *, id))requestSuccessForSuccessBlock:(IBESRequestSuccess)success failureBlock:(IBESRequestFailure)failure
{
    return ^(NSURLSessionDataTask *task, id responseObject)
            {
                if( [self isResponseHasFailedStatus:responseObject] )
                {
                    if(failure)
                    {
                        NSLog(@"%@", task.taskDescription);
                        NSString *errorMessage = [self messageFromResponse:responseObject];
                        NSError *error = [self errorWithMessage:errorMessage];
                        failure(task, error);
                    }
                    
                    return ;
                }
                
                if(success)
                {
                    success(task, responseObject);
                }
            };
}

@end
