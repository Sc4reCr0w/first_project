//
//  IBESInfoPageService.m
//  CatalogueLite
//
//  Created by Pavel on 12.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESInfoPageService.h"
// Request
#import "IBESInfoPageRequest.h"
// Parser
#import "IBESInfoPageParser.h"

@interface IBESInfoPageService ()

@property (nonatomic) IBESInfoPageRequest *infoPagesRequest;
@property (nonatomic) IBESInfoPageParser *infoPagesParser;

@end

@implementation IBESInfoPageService

#pragma mark - Service

- (void)infoPagesWithSuccessBlock:(IBESInfoPageSuccess)success failureBlock:(IBESServiceFailure)failure
{
    self.currentTask = [self.infoPagesRequest requestInfoPages:
                        ^(NSURLSessionDataTask *task, id responseObject)
                        {
                            IBESInfoPageParser *parser = self.infoPagesParser;
                            NSArray *infoPages = [parser infoPagesFromJSON:responseObject];
                            
                            if (infoPages && success)
                            {
                                void (^dyspatchBlock)() = ^{ success(infoPages); };
                                dispatch_async(dispatch_get_main_queue(), dyspatchBlock);
                            }
                            
                            else if (!infoPages && failure)
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

- (IBESInfoPageRequest *)infoPagesRequest
{
    if(!_infoPagesRequest)
    {
        _infoPagesRequest = [[IBESInfoPageRequest alloc] init];
    }
    
    return _infoPagesRequest;
}

- (IBESInfoPageParser *)infoPagesParser
{
    if(!_infoPagesParser)
    {
        _infoPagesParser = [[IBESInfoPageParser alloc] init];
    }
    
    return _infoPagesParser;
}

@end
