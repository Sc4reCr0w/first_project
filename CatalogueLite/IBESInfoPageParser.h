//
//  IBESInfoPageParser.h
//  CatalogueLite
//
//  Created by Pavel on 12.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESParser.h"

@interface IBESInfoPageParser : IBESParser

- (NSArray *)infoPagesFromJSON:(id)json;

@end
