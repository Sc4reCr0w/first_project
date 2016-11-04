//
//  IBESCache.m
//  CatalogueLite
//
//  Created by Pavel on 19.09.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESCache.h"

@implementation IBESCache

- (instancetype)init
{
    if(self = [super init])
    {
        self.countLimit = 100;
        self.totalCostLimit = 20 * 1024 * 1024;
    }
    
    return self;
}

@end
