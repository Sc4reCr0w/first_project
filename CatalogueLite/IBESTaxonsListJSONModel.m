//
//  IBESTaxonsListJSONModel.m
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESTaxonsListJSONModel.h"
// Taxon Model
#import "IBESTaxonJSONModel.h"

@implementation IBESTaxonsListJSONModel

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

#pragma mark - Get Array of Taxons As Dictionaries

- (NSArray *)taxonsAsDictionaries
{
    NSMutableArray *taxons = [NSMutableArray arrayWithCapacity:[[self taxons] count]];
    
    for (IBESTaxonJSONModel *taxon in [self taxons])
    {
        [taxons addObject:[taxon toDictionary]];
    }
    
    return [taxons copy];
    
}

#pragma mark - Custom Key Mapper

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"count" : @"count", @"currentPage" : @"current_page", @"pages" : @"pages", @"perPage" : @"per_page", @"taxons" : @"taxons", @"totalCount" : @"total_count"}];
}

@end
