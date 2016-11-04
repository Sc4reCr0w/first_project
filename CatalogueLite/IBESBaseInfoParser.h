//
//  IBESBaseInfoParser.h
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESParser.h"

@interface IBESBaseInfoParser : IBESParser

- (NSArray *)baseInfoFromJSON:(id)json;

@end
