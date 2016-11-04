//
//  IBESTaxonsParser.h
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESParser.h"

@class IBESTaxonsListJSONModel;

@interface IBESTaxonsParser : IBESParser

- (NSArray *)taxonsFromJSON:(id)json;

- (NSInteger)numberOfPagesInTaxonsList;

@end
