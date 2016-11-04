//
//  CLCacheController.m
//  CatalogueLite
//
//  Created by Pavel on 15.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "CLCacheController.h"

@interface CLCacheController ()
{
    NSCache *_cache;
}

@end

@implementation CLCacheController

#pragma Mark - Designatade initializer

- (instancetype)init
{
    if (self = [super init])
    {
        _cache = [NSCache new];
        
        _cache.countLimit = 100;
        _cache.totalCostLimit = 20 * 1024 * 1024;
    }
    
    return self;
}

#pragma Mark - Public methods

- (id)getDataForKey:(NSString *)keyString
{
    return [_cache objectForKey:keyString];
}

- (void)storeObject:(id)object forKey:(NSString *)keyString
{
    if(object)
    {
        if([self getDataForKey:keyString])
        {
            [_cache removeObjectForKey:keyString];
        }
        
        [_cache setObject:object forKey:keyString];
    }
}

@end
