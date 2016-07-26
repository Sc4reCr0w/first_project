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

- (NSData *)getDataForKey:(NSString *)keyString
{
    return [_cache objectForKey:keyString];
}

- (void)storeData:(NSData *)data forKey:(NSString *)keyString
{
    NSData *cachedData = [_cache objectForKey:keyString];
    
    if (cachedData)
    {
        [_cache removeObjectForKey:keyString];
    }
    
    [_cache setObject:data forKey:keyString cost:[data length]];
}

@end
