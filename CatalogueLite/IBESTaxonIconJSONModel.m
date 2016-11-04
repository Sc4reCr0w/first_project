//
//  IBESTaxonIconJSONModel.m
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESTaxonIconJSONModel.h"

@implementation IBESTaxonIconJSONModel

#pragma mark - Custom Key Mapper

+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"origin" : @"origin", @"thumbs" : @"thumbs"}];
}

@end
