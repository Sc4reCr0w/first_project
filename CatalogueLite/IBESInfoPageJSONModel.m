//
//  IBESInfoPageJSONModel.m
//  CatalogueLite
//
//  Created by Pavel on 12.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESInfoPageJSONModel.h"

@implementation IBESInfoPageJSONModel

#pragma mark - Custom Key Mapper

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"banner" : @"banner", @"content" : @"content", @"dateUpdate" : @"date_update", @"ID" : @"id", @"isWanted" : @"is_wanted", @"name" : @"name", @"type" : @"type"}];
}

@end
