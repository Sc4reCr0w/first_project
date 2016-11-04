//
//  IBESInfoPageListJSONModel.m
//  CatalogueLite
//
//  Created by Pavel on 12.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESInfoPageListJSONModel.h"
// InfoPage parser
#import "IBESInfoPageJSONModel.h"

@implementation IBESInfoPageListJSONModel

#pragma mark - Initialization

- (instancetype)initWithJSON:(id)json error:(NSError **)error
{
    NSError *error_l;
    if( [json isKindOfClass:[NSDictionary class]] )
    {
        self = [super initWithDictionary:json error:&error_l];
    }
    
    else if( [json isKindOfClass:[NSString class]] )
    {
        self = [super initWithString:json error:&error_l];
    }
    
    else if( [json isKindOfClass:[NSData class]] )
    {
        self = [super initWithData:json error:&error_l];
    }
    
    else
    {
        self = [super init];
    }
    
    *error = error_l;
    
    return self;
}

#pragma mark - Get Array of InfoPages As Dictionaries

- (NSArray *)infoPagesAsDictionaries
{
    NSMutableArray *infoPages = [NSMutableArray arrayWithCapacity:[[self infoPages] count]];
    
    for (IBESInfoPageJSONModel *infoPage in [self infoPages])
    {
        [infoPages addObject:[infoPage toDictionary]];
    }
    
    return [infoPages copy];
    
}

#pragma mark - Custom Key Mapper

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"count" : @"count", @"currentPage" : @"current_page", @"infoPages" : @"info_pages", @"pages" : @"pages", @"perPage" : @"per_page", @"totalCount" : @"total_count"}];
}

@end
