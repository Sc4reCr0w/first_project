//
//  IBESBaseInfoService.m
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESBaseInfoService.h"
// Request
#import "IBESBaseInfoRequest.h"
// Parser
#import "IBESBaseInfoParser.h"

@interface IBESBaseInfoService ()

@property (nonatomic) IBESBaseInfoRequest *baseInfoRequest;
@property (nonatomic) IBESBaseInfoParser *baseInfoParser;

@end

@implementation IBESBaseInfoService

#pragma mark - Service

- (void)baseInfoWithSuccessBlock:(IBESBaseInfoSuccess)success failureBlock:(IBESServiceFailure)failure
{
    self.currentTask = [self.baseInfoRequest requestBaseInfo:^(NSURLSessionDataTask *task, id responseObject)
    {
        IBESBaseInfoParser *parser = self.baseInfoParser;
        NSArray *baseInfo = [parser baseInfoFromJSON:responseObject];
        
        if (baseInfo && success)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(baseInfo);
            });
        }
        else if (!baseInfo && failure)
        {
            NSError *parserError = [parser getParserError];
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(parserError);
            });
        }
    } failure:[self failureWithBlock:failure]];
}

#pragma - mark Error handler override

- (void (^)(NSURLSessionDataTask *, NSError *))failureWithBlock:(IBESServiceFailure)failureBlock
{
    void (^failure)(NSURLSessionDataTask *, NSError *) =
    ^(NSURLSessionDataTask *task, NSError *error)
    {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"Request failed: %@", [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode]);
        
        if (failureBlock)
        {
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey:[error.userInfo objectForKey:@"NSLocalizedDescription"],
                                       NSLocalizedFailureReasonErrorKey:[error.userInfo objectForKey:@"NSErrorFailingURLKey"]
                                       };
            
            NSError *callbackError = [NSError errorWithDomain:error.domain code:error.code userInfo:userInfo];
            
            void (^dyspatchBlock)() = ^{ failureBlock(callbackError); };
            dispatch_async(dispatch_get_main_queue(), dyspatchBlock);
        }
    };
    
    return failure;
}

#pragma Mark - Lazy initialisation of instance variables

- (IBESBaseInfoRequest *)baseInfoRequest
{
    if (!_baseInfoRequest)
    {
        _baseInfoRequest = [[IBESBaseInfoRequest alloc] init];
    }
    
    return _baseInfoRequest;
}

- (IBESBaseInfoParser *)baseInfoParser
{
    if (!_baseInfoParser)
    {
        _baseInfoParser = [[IBESBaseInfoParser alloc] init];
    }
    
    return _baseInfoParser;
}

@end
