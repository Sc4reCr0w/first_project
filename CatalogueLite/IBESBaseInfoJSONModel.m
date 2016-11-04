//
//  IBESBaseInfoJSONModel.m
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESBaseInfoJSONModel.h"

@implementation IBESBaseInfoJSONModel

#pragma mark - Initialization

- (instancetype)initWithJSON:(id)json error:(NSError **)error
{
    NSError *error_l;
    if ( [json isKindOfClass:[NSDictionary class]] )
    {
        self = [super initWithDictionary:json error:&error_l];
    }
    
    else if ( [json isKindOfClass:[NSString class]] )
    {
        self = [super initWithString:json error:&error_l];
    }
    
    else if ( [json isKindOfClass:[NSData class]] )
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

#pragma mark - Get Array of BaseInfoes As Dictionaries

- (NSArray *)baseInfoAsDictionary
{
    return [NSMutableArray arrayWithObject:[self toDictionary]];
}

#pragma mark - Custom Key Mapper

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"address" : @"address", @"defaultImage" : @"default_image", @"email" : @"email", @"fAddress" : @"f_address", @"iAddress" : @"i_address", @"logo" : @"logo", @"oAddress" : @"o_address", @"phone" : @"phone", @"shortFooter" : @"short_footer", @"showLogo" : @"show_logo", @"speech" : @"speach", @"title" : @"title", @"tAddress" : @"t_address", @"updatedAt" : @"updated_at", @"vkAddress" : @"vk_address"}];
}

@end
