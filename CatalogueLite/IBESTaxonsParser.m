//
//  IBESTaxonsParser.m
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESTaxonsParser.h"
// TaxonList Model
#import "IBESTaxonsListJSONModel.h"

@interface IBESTaxonsParser ()

@property (nonatomic) id json;
@property (nonatomic) NSError *parserError;
@property (nonatomic, readwrite) IBESTaxonsListJSONModel *taxonsList;

@end

@implementation IBESTaxonsParser

#pragma mark - Get InfoPages Array

- (NSArray *)taxonsFromJSON:(id)json
{
    self.json = json;
    
    if(self.taxonsList)
    {
        return [[self taxonsList] taxonsAsDictionaries];
    }
    
    return nil;
}

#pragma mark - Taxons' List Number Of Pages

- (NSInteger)numberOfPagesInTaxonsList
{
    return [[self taxonsList] pages];
}

#pragma mark - Get Parser Error

- (NSError *)getParserError
{
    return self.parserError;
}

#pragma mark - Lazy Allocation

- (IBESTaxonsListJSONModel *)taxonsList
{
    NSError *error = nil;
    if(!_taxonsList)
    {
        _taxonsList = [[IBESTaxonsListJSONModel alloc] initWithJSON:self.json error:&error];
        self.parserError = error;
    }
    
    return _taxonsList;
}

@end
