//
//  IBESBannersParser.h
//  CatalogueLite
//
//  Created by Pavel on 08.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESParser.h"

@interface IBESBannersParser : IBESParser

- (NSArray *)bannersFromJSON:(id)json;

@end
