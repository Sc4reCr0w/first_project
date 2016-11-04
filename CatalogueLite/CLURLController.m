//
//  CLURLController.m
//  CatalogueLite
//
//  Created by Pavel on 15.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "CLURLController.h"

@implementation CLURLController

- (NSURL *)makeURLForTailString:(NSString *)key relativeToBaseURL:(NSURL *)baseURL
{
    NSURL *result = [NSURL URLWithString:key relativeToURL:baseURL];
    return result;
}

- (NSURL *)addQueryParametersToURL:(NSURL *)URL fromDictionary:(NSDictionary *)dictionary
{
    NSURLComponents *urlComponets = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:NO];
    
    //NSArray *dictionaryKeys = [dictionary allKeys];
    //NSArray *dictionaryValues = [dictionary allValues];
    
    NSMutableArray *queryItemsArray = [NSMutableArray arrayWithCapacity:[dictionary count]];

    for(NSString *key in dictionary)
    {
        NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:key value:dictionary[key]];
        [queryItemsArray addObject:queryItem];
    }
    
    urlComponets.queryItems = [queryItemsArray copy];
    
    return [urlComponets URL];
    
}

@end
