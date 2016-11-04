//
//  IBESBannerJSONModel.m
//  CatalogueLite
//
//  Created by Pavel on 08.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESBannerJSONModel.h"

@implementation IBESBannerJSONModel

#pragma mark - Custom Key Mapper

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"active" : @"active", @"dateUpdate" : @"date_update", @"Description" : @"description", @"ID" : @"id", @"link" : @"link", @"linkID" : @"link_id", @"linkType" : @"link_type", @"title" : @"title", @"url" : @"url"}];
}

@end
