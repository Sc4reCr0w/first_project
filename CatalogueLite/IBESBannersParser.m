//
//  IBESBannersParser.m
//  CatalogueLite
//
//  Created by Pavel on 08.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESBannersParser.h"
// BannersList parser
#import "IBESBannersListJSONModel.h"

@interface IBESBannersParser ()

@property (nonatomic) id json;
@property (nonatomic) NSError *parserError;
@property (nonatomic) IBESBannersListJSONModel *bannersList;

@end

@implementation IBESBannersParser

#pragma mark - Get Banners Array As Dictionaries

- (NSArray *)bannersFromJSON:(id)json
{
    self.json = json;
    
    if(self.bannersList)
    {
        return [[self bannersList] bannersAsDictionaries];
    }
    
    return nil;
}

#pragma mark - Get Parser Error

- (NSError *)getParserError
{
    return self.parserError;
}

#pragma mark - Lazy Allocation

- (IBESBannersListJSONModel *)bannersList
{
    NSError *error = nil;
    if(!_bannersList)
    {
        _bannersList = [[IBESBannersListJSONModel alloc] initWithJSON:self.json error:&error];
        self.parserError = error;
    }
    
    return _bannersList;
}

@end
