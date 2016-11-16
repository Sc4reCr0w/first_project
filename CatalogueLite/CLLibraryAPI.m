//
//  CLLibraryAPI.m
//  CatalogueLite
//
//  Created by Pavel on 15.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "CLLibraryAPI.h"

// Cache
#import "IBESCache.h"
// BlockOperation
#import "IBESBlockOperationWithProgress.h"

// Banners Service
#import "IBESBannersService.h"
// InfoPage Service
#import "IBESInfoPageService.h"
// BaseInfo Service
#import "IBESBaseInfoService.h"
// Taxons Service
#import "IBESTaxonsService.h"

@interface CLLibraryAPI ()

@property (nonatomic) IBESCache *cache;
@property (nonatomic) IBESBlockOperationWithProgress *operation;

@property (nonatomic) IBESBannersService *bannersService;
@property (nonatomic) IBESInfoPageService *infoPageService;
@property (nonatomic) IBESTaxonsService *taxonsService;
@property (nonatomic) IBESBaseInfoService *baseInfoService;

@end

@implementation CLLibraryAPI

#pragma Mark - Class public methods

- (void)bannersArrayWithSuccessBlock:(IBESAPISuccess)success failureBlock:(IBESAPIFailure)failure
{
    NSArray *banners = [self.cache objectForKey:@"banners"];
    
    if ( [banners count] )
    {
        if (success)
        {
            success(banners);
        }
    }
    else
    {
        [self.bannersService bannersWithSuccessBlock:^(NSArray *banners)
        {
            [self.cache setObject:banners forKey:@"banners"];
            if (success)
            {
                success(banners);
            }
        } failureBlock:failure];
    }
}

- (void)infoPagesArrayWithSuccessBlock:(IBESAPISuccess)success failureBlock:(IBESAPIFailure)failure
{
    NSArray *infoPages = [self.cache objectForKey:@"infoPages"];
    
    if ( [infoPages count] )
    {
        if (success)
        {
            success(infoPages);
        }
    }
    else
    {
        [self.infoPageService infoPagesWithSuccessBlock:^(NSArray *infoPages)
        {
             [self.cache setObject:infoPages forKey:@"infoPage"];
             if (success)
             {
                 success(infoPages);
             }
         } failureBlock:failure];
    }
}

- (void)taxonsArrayWithSuccessBlock:(IBESAPISuccess)success failureBlock:(IBESAPIFailure)failure
{
    NSArray *taxons = [self.cache objectForKey:@"taxons"];
    
    if ( [taxons count] )
    {
        if (success)
        {
            success(taxons);
        }
    }
    else
    {
        [self.taxonsService taxonsWithSuccessBlock:^(NSArray *taxons)
         {
             [self.cache setObject:taxons forKey:@"taxons"];
             if (success)
             {
                 success(taxons);
             }
         } failureBlock:failure];
    }
}

- (void)baseInfoArrayWithSuccessBlock:(IBESAPISuccess)success failureBlock:(IBESAPIFailure)failure
{
    NSArray *baseInfo = [self.cache objectForKey:@"baseInfo"];
    
    if ( [baseInfo count] )
    {
        if (success)
        {
            success(baseInfo);
        }
    }
    else
    {
        [self.baseInfoService baseInfoWithSuccessBlock:^(NSArray *baseInfo)
         {
             [self.cache setObject:baseInfo forKey:@"baseInfo"];
             if (success)
             {
                 success(baseInfo);
             }
         } failureBlock:failure];
    }
}

- (void)getMenuContent:(void (^)(void))success failureBlock:(void (^)(void))failure
{
    [self.operation addExecutionBlocksFromArray:[self downloadTasks:success failureBlock:failure]];
    
    [self.operation executeOperation];
}

#pragma Mark - Helper method

- (NSArray<void (^)(void)> *)downloadTasks:(void (^)(void))success failureBlock:(void (^)(void))failure
{
    NSMutableArray<void (^)(void)> *tasksArray = [NSMutableArray new];
    
    [tasksArray addObject:^{
        [self bannersArrayWithSuccessBlock:
         ^(NSArray *banners)
         {
             [self.operation advanceProgress];
             
             if ( [self.operation isCompleted] )
             {
                 if (success)
                 {
                     success();
                 }
             }
         }
                              failureBlock:
         ^(NSError *error)
         {
             [self.operation cancelOperation];
             
             if (failure)
             {
                 failure();
             }
         }];
    }];
    
    [tasksArray addObject:^{
        [self infoPagesArrayWithSuccessBlock:
         ^(NSArray *infoPages)
         {
             [self.operation advanceProgress];
             
             if ( [self.operation isCompleted] )
             {
                 if (success)
                 {
                     success();
                 }
             }
         }
                                failureBlock:
         ^(NSError *error)
         {
             [self.operation cancelOperation];
             
             if (failure)
             {
                 failure();
             }
         }];
    }];
    
    [tasksArray addObject:^{
        [self taxonsArrayWithSuccessBlock:
         ^(NSArray *taxons)
         {
             [self.operation advanceProgress];
             
             if ( [self.operation isCompleted] )
             {
                 if (success)
                 {
                     success();
                 }
             }
         }
                             failureBlock:
         ^(NSError *error)
         {
             [self.operation cancelOperation];
             
             if (failure)
             {
                 failure();
             }
         }];
    }];
    
    [tasksArray addObject:^{
        [self baseInfoArrayWithSuccessBlock:
         ^(NSArray *baseInfo)
         {
             [self.operation advanceProgress];
             
             if ( [self.operation isCompleted] )
             {
                 if (success)
                 {
                     success();
                 }
             }
         }
                               failureBlock:
         ^(NSError *error)
         {
             [self.operation cancelOperation];
             
             if (failure)
             {
                 failure();
             }
         }];
    }];
    
    return [tasksArray copy];
}

#pragma Mark - Singleton initialisation

+ (instancetype)sharedInstance
{
    static CLLibraryAPI *sharedInstance_ = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance_ = [[CLLibraryAPI alloc] init];
    });
    
    return sharedInstance_;
}

#pragma Mark - Lazy initialisation of instance variables

- (IBESCache *)cache
{
    if(!_cache)
    {
        _cache = [[IBESCache alloc] init];
    }
    
    return _cache;
}

- (IBESBlockOperationWithProgress *)operation
{
    if (!_operation)
    {
        _operation = [IBESBlockOperationWithProgress new];
    }
    
    return _operation;
}

- (IBESBannersService *)bannersService
{
    if(!_bannersService)
    {
        _bannersService = [[IBESBannersService alloc] init];
    }
    
    return _bannersService;
}

- (IBESInfoPageService *)infoPageService
{
    if(!_infoPageService)
    {
        _infoPageService = [[IBESInfoPageService alloc] init];
    }
    
    return _infoPageService;
}

- (IBESBaseInfoService *)baseInfoService
{
    if(!_baseInfoService)
    {
        _baseInfoService = [[IBESBaseInfoService alloc] init];
    }
    
    return _baseInfoService;
}

- (IBESTaxonsService *)taxonsService
{
    if(!_taxonsService)
    {
        _taxonsService = [[IBESTaxonsService alloc] init];
    }
    
    return _taxonsService;
}

@end
