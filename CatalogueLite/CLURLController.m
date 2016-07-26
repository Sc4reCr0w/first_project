//
//  CLURLController.m
//  CatalogueLite
//
//  Created by Pavel on 15.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "CLURLController.h"

@implementation CLURLController

- (NSURL *)makeURLForKey:(NSString *)key relativeToBaseURL:(NSURL *)baseURL
{
    NSString *URLTailString = [[self validURLTail] objectForKey:key];
    NSURL *result = [NSURL URLWithString:URLTailString relativeToURL:baseURL];
    
    return result;
}

- (NSURL *)addQueryParametersToURL:(NSURL *)URL fromDictionary:(NSDictionary *)dictionary
{
    NSURLComponents *urlComponets = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:NO];
    
    NSArray *dictionaryKeys = [dictionary allKeys];
    NSArray *dictionaryValues = [dictionary allValues];
    
    NSMutableArray *queryItemsArray = [NSMutableArray arrayWithCapacity:[dictionary count]];
    for (NSUInteger i = 0; i < [dictionary count]; ++i)
    {
        NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:dictionaryKeys[i] value:dictionaryValues[i]];
        [queryItemsArray addObject:queryItem];
    }
    
    urlComponets.queryItems = [queryItemsArray copy];
    
    return [urlComponets URL];
    
}

- (NSDictionary *)validURLTail
{
    return @{@"LOAD_BANNERS":@"api/banners",
             @"LOAD_INFO_PAGE":@"/api/infopage",
             @"LOAD_TAXON":@"/api/taxonss",
             @"LOAD_BASE_INFO":@"/api/base-info",
             @"LOAD_OPTION":@"/api/m_option_values"};
}

@end
