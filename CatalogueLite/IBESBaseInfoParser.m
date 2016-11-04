//
//  IBESBaseInfoParser.m
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESBaseInfoParser.h"
// BaseInfo Model
#import "IBESBaseInfoJSONModel.h"

@interface IBESBaseInfoParser ()

@property (nonatomic) id json;
@property (nonatomic) NSError *parserError;
@property (nonatomic) IBESBaseInfoJSONModel *baseIfo;

@end

@implementation IBESBaseInfoParser

#pragma mark - Get Baseinfo Array

- (NSArray *)baseInfoFromJSON:(id)json
{
    self.json = json;
    
    if (self.baseIfo)
    {
        return [[self baseIfo] baseInfoAsDictionary];
    }
    
    return nil;
}

#pragma mark - Get Parser Error

- (NSError *)getParserError
{
    return self.parserError;
}

#pragma mark - Lazy Allocation

- (IBESBaseInfoJSONModel *)baseIfo
{
    NSError *error = nil;
    if (!_baseIfo)
    {
        _baseIfo = [[IBESBaseInfoJSONModel alloc] initWithJSON:self.json error:&error];
        self.parserError = error;
    }
    
    return _baseIfo;
}

@end
