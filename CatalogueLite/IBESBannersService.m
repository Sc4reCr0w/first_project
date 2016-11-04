//
//  IBESBannersService.m
//  CatalogueLite
//
//  Created by Pavel on 10.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESBannersService.h"
// Banners Request
#import "IBESBannersRequest.h"
// Banners Parser
#import "IBESBannersParser.h"

@interface IBESBannersService ()

@property (nonatomic) IBESBannersRequest *bannersRequest;
@property (nonatomic) IBESBannersParser *bannersParser;

@end

@implementation IBESBannersService

#pragma mark - Service

- (void)bannersWithSuccessBlock:(IBESBannersSuccess)success failureBlock:(IBESServiceFailure)failure
{
    self.currentTask = [self.bannersRequest requestBanners:
                        ^(NSURLSessionDataTask *task, id responseObject)
                        {
                            IBESBannersParser *parser = self.bannersParser;
                            NSArray *banners = [parser bannersFromJSON:responseObject];
                            
                            if(banners && success)
                            {
                                void (^dyspatchBlock)() = ^{ success(banners); };
                                dispatch_async(dispatch_get_main_queue(), dyspatchBlock);
                            }
                            
                            if(!banners && failure)
                            {
                                NSError *parserError = [parser getParserError];
                                void (^dyspatchBlock)() = ^{ failure(parserError); };
                                dispatch_async(dispatch_get_main_queue(), dyspatchBlock);
                            }
                        }
                                                   failure:
                        [self failureWithBlock:failure]];
}

#pragma - mark Error handler override

- (void (^)(NSURLSessionDataTask *, NSError *))failureWithBlock:(IBESServiceFailure)failureBlock
{
    void (^failure)(NSURLSessionDataTask *, NSError *) =
    ^(NSURLSessionDataTask *task, NSError *error)
    {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSLog(@"Request failed: %@", [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode]);
        
        if(failureBlock)
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

- (IBESBannersRequest *)bannersRequest
{
    if(!_bannersRequest)
    {
        _bannersRequest = [[IBESBannersRequest alloc] init];
    }
    
    return _bannersRequest;
}

- (IBESBannersParser *)bannersParser
{
    if(!_bannersParser)
    {
        _bannersParser = [[IBESBannersParser alloc] init];
    }
    
    return _bannersParser;
}

@end
