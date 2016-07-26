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
#import "CLCacheController.h"
// URL Controller
#import "CLURLController.h"
// HTTP Controller
#import "CLHTTPController.h"
// JSON Controller
#import "CLJSONController.h"

// BannersList JSON Model
#import "CLBannersListModel.h"

NSString * const kServerAddress = @"http://136.243.226.243:8081/";

@interface CLLibraryAPI ()

@property (strong, nonatomic) CLCacheController *cacheController;
@property (strong, nonatomic) CLURLController *URLController;
@property (strong, nonatomic) CLHTTPController *HTTPController;
@property (strong, nonatomic) CLJSONController *JSONController;

@property (strong, nonatomic) CLBannersListModel *bannersList;

@end

@implementation CLLibraryAPI

#pragma Mark - Singleton initialization

+ (instancetype)sharedInstance
{
    static CLLibraryAPI *sharedInstance_ = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance_ = [[CLLibraryAPI alloc] init];
    });
    
    return sharedInstance_;
}

#pragma Mark - Lazy initialization of instance variables

- (CLCacheController *)cacheController
{
    if (!_cacheController)
    {
        _cacheController = [[CLCacheController alloc] init];
    }
    
    return _cacheController;
}

- (CLURLController *)URLController
{
    if (!_URLController)
    {
        _URLController = [[CLURLController alloc] init];
    }
    
    return _URLController;
}

- (CLHTTPController *)HTTPController
{
    if (!_HTTPController)
    {
        _HTTPController = [[CLHTTPController alloc] init];
    }
    
    return _HTTPController;
}

- (CLJSONController *)JSONController
{
    if (!_JSONController)
    {
        _JSONController = [[CLJSONController alloc] init];
    }
    
    return _JSONController;
}

- (NSURL *)serverAddress
{
    if (!_serverAddress)
    {
        _serverAddress = [NSURL URLWithString:kServerAddress];
    }
    
    return _serverAddress;
}

#pragma Mark - Class public methods

- (void)downloadBannersList
{
    
    NSURL *bannersListURL = [self getURLForKey:@"LOAD_BANNERS"];
    
    if (!bannersListURL) return;
    
    [[self HTTPController] downloadDataForURL:bannersListURL withCallback:^(NSData *data, NSURLResponse *response, NSError *error){
        
        if (!error)
        {
            CLBannersListModel *bannersList = (CLBannersListModel *)[[self JSONController] JSONModelForObjectClass:[CLBannersListModel class] withData:data];
            [bannersList removeInactiveBannersFromList];
            NSData *dataJSON = [[self JSONController] getDataFromJSONModelObject:bannersList];
            
            [self fetchToCacheData:dataJSON forKeyString:[response URL].absoluteString];
        }
        else
        {
            // notify view controller about error by protocol method
        }
    }];
    
}

#pragma Mark - Class private methods

#pragma Mark - Private methods helpers

- (NSURL *)getURLForKey:(NSString *)key
{
   return [[self URLController] makeURLForKey:key relativeToBaseURL:[self serverAddress]];
}

- (void)fetchToCacheData:(NSData *)data forKeyString:(NSString *)keyString
{
    [[self cacheController] storeData:data forKey:keyString];
}

@end
