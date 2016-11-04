//
//  IBESTaxonsService.m
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESTaxonsService.h"
// Parser
#import "IBESTaxonsParser.h"
// Request
#import "IBESTaxonsRequest.h"

@class IBESTaxonsListJSONModel;

@interface IBESTaxonsService ()

@property (nonatomic) IBESTaxonsRequest *taxonsRequest;
@property (nonatomic) IBESTaxonsParser *taxonsParser;
@property (nonatomic) NSMutableArray *taxonsArray;
@property (nonatomic) NSInteger numberOfPages;

@end

@implementation IBESTaxonsService

#pragma mark - Service

- (void)taxonsWithSuccessBlock:(IBESTaxonsSuccess)success failureBlock:(IBESServiceFailure)failure
{
    [self setNumberOfPages:[self numberOfPages] + 1];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInteger:[self numberOfPages]] forKey:@"page"];
    
    self.currentTask = [self.taxonsRequest requestTaxons:parameters successBlock:^(NSURLSessionDataTask *task, id responseObject)
    {
        IBESTaxonsParser *parser = [self taxonsParser];
        [[self taxonsArray] addObjectsFromArray:[parser taxonsFromJSON:responseObject]];
        
        if ( [[self taxonsArray] count] )
        {
            if ( [self numberOfPages] < [[self taxonsParser] numberOfPagesInTaxonsList] )
            {
                [self setTaxonsParser:nil];
                [self taxonsWithSuccessBlock:success failureBlock:failure];
            }
            else if (success)
            {
                NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"lft" ascending:YES];
                
                NSArray *sortedTaxons = [[self taxonsArray] sortedArrayUsingDescriptors:@[sortDescriptor]];
                [self setTaxonsArray:[sortedTaxons mutableCopy]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    success( [self taxonsArray] );
                });
            }
            
        }
        else if (failure)
        {
            NSError *parserError = [parser getParserError];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(parserError);
            });
        }
        /*if ( [self numberOfPages] < [[self taxonsParser] numberOfPagesInTaxonsList] )
        {
            [self setTaxonsParser:nil];
            [self taxonsWithSuccessBlock:success failureBlock:failure];
        }
        else
        {
            if ( [self taxonsArray] && success)
            {
                NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"lft" ascending:YES];
                
                NSArray *sortedTaxons = [[self taxonsArray] sortedArrayUsingDescriptors:@[sortDescriptor]];
                [self setTaxonsArray:[sortedTaxons mutableCopy]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    success( [self taxonsArray] );
                });
            }
            else if (![self taxonsArray] && failure)
            {
                NSError *parserError = [parser getParserError];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(parserError);
                });
            }
        }*/
    } failureBlock:[self failureWithBlock:failure]];
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

- (IBESTaxonsRequest *)taxonsRequest
{
    if(!_taxonsRequest)
    {
        _taxonsRequest = [[IBESTaxonsRequest alloc] init];
    }
    
    return _taxonsRequest;
}

- (IBESTaxonsParser *)taxonsParser
{
    if(!_taxonsParser)
    {
        _taxonsParser = [[IBESTaxonsParser alloc] init];
    }
    
    return _taxonsParser;
}

- (NSMutableArray *)taxonsArray
{
    if (!_taxonsArray)
        _taxonsArray = [NSMutableArray array];
    
    return _taxonsArray;
}

- (NSInteger)numberOfPages
{
    if (!_numberOfPages)
        _numberOfPages = 0;
    
    return _numberOfPages;
}

@end
