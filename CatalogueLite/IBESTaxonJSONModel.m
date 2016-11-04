//
//  IBESTaxonJSONModel.m
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESTaxonJSONModel.h"
// TaxonIcon Model
#import "IBESTaxonIconJSONModel.h"

@implementation IBESTaxonJSONModel

#pragma mark - Make int variable optional

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    if ([propertyName isEqualToString:@"parentID"])
        return YES;
    
    return NO;
}

#pragma mark - Custom Key Mapper

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"dateUpdate" : @"date_update", @"icon" : @"icon", @"ID" : @"id", @"lft" : @"lft", @"name" : @"name", @"parentID" : @"parent_id", @"rgt" : @"rgt", @"taxonomyID" : @"taxonomy_id"}];
}

@end
