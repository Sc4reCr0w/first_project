//
//  IBESInfoPageParser.m
//  CatalogueLite
//
//  Created by Pavel on 12.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESInfoPageParser.h"
// InfoPageList Model
#import "IBESInfoPageListJSONModel.h"

@interface IBESInfoPageParser ()

@property (nonatomic) id json;
@property (nonatomic) NSError *parserError;
@property (nonatomic) IBESInfoPageListJSONModel *infoPageList;

@end

@implementation IBESInfoPageParser

#pragma mark - Get InfoPages Array

- (NSArray *)infoPagesFromJSON:(id)json
{
    self.json = json;
    
    if(self.infoPageList)
    {
        return [[self infoPageList] infoPagesAsDictionaries];
    }
    
    return nil;
}

#pragma mark - Get Parser Error

- (NSError *)getParserError
{
    return self.parserError;
}

#pragma mark - Lazy Allocation

- (IBESInfoPageListJSONModel *)infoPageList
{
    NSError *error = nil;
    if(!_infoPageList)
    {
        _infoPageList = [[IBESInfoPageListJSONModel alloc] initWithJSON:self.json error:&error];
        self.parserError = error;
    }
    
    return _infoPageList;
}

@end
