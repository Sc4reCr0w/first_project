//
//  IBESBannersListJSONModel.m
//  CatalogueLite
//
//  Created by Pavel on 08.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESBannersListJSONModel.h"
// Banners property parser
#import "IBESBannerJSONModel.h"

@implementation IBESBannersListJSONModel

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
    
    *error = error_l/*[NSError errorWithDomain:error_l.domain code:error_l.code userInfo:error_l.userInfo]*/;
    
    return self;
}

#pragma mark - Get Array of InfoPages As Dictionaries

- (NSArray *)bannersAsDictionaries
{
    [self removeInactiveBanners];
    
    NSMutableArray *banners = [NSMutableArray arrayWithCapacity:[[self banners] count]];
    
    for (IBESBannerJSONModel *banner in [self banners])
    {
        [banners addObject:[banner toDictionary]];
    }
    
    return [banners copy];
    
}

#pragma mark - Remove inactive banners

- (void)removeInactiveBanners
{
    NSMutableArray *banners = [NSMutableArray arrayWithArray:[self banners]];
    
    for (IBESBannerJSONModel *banner in banners)
    {
        if ( ![banner.active boolValue] )
        {
            [[self banners] removeObject:banner];
        }
    }
}

#pragma mark - Custom Key Mapper

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"banners" : @"banners", @"count" : @"count", @"currentPage" : @"current_page", @"pages" : @"pages", @"perPage" : @"per_page", @"totalCount" : @"total_count"}];
}

@end
