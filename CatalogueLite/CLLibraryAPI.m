//
//  CLLibraryAPI.m
//  CatalogueLite
//
//  Created by Pavel on 15.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "CLLibraryAPI.h"
#import "CLLibraryAPIConfiguration.h"

// Cache
#import "CLCacheController.h"
// URL Controller
#import "CLURLController.h"
// HTTP Controller
#import "CLHTTPController.h"
// JSON Controller
#import "CLJSONController.h"

#import "CLConfiguration.h"

// BannersList JSON Model
#import "CLBannersListModel.h"

@interface CLLibraryAPI ()
{
    CLConfiguration *configuration;
}
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

#pragma Mark - Class public methods

- (void)downloadToCacheJSONObjectForAPICallKey:(NSString *)callKey
{
    if([self checkCacheForObjectWithKey:callKey])
        return;
    
    [self setupDownloadForKey:callKey];
}

#pragma Mark - Class private methods

- (BOOL)checkCacheForObjectWithKey:(NSString *)key
{
    if([[self cacheController] getDataForKey:key])
        return YES;
    
    return NO;
}

- (void)setupDownloadForKey:(NSString *)key
{
    NSURL *URLToJSONObject = [self getURLForKey:key];
    
    [[self HTTPController] downloadDataForURL:URLToJSONObject withCallback:^(NSData *data, NSURLResponse *response, NSError *error){
        
        if (!error)
        {
            CLBannersListModel *bannersList = (CLBannersListModel *)[[self JSONController] JSONModelForObjectClass:[CLBannersListModel class] withData:data];
            [bannersList removeInactiveBannersFromList];
            
            [self cacheData:bannersList forKeyString:[response URL].absoluteString];
        }
        else
        {
            // notify view controller about error by notification
        }
    }];
}

- (NSURL *)getURLForKey:(NSString *)key
{
    [self updateConfiguration];
    
    NSString *URLTailString = [[configuration serverAPI] objectForKey:key];
    return [[self URLController] makeURLForTailString:URLTailString relativeToBaseURL:[configuration serverAddress]];
}

- (void)updateConfiguration
{
    [[self delegate] serverAddressForCLLibraryAPI:self];
    [[self delegate] serverAPICallsForCLLibraryAPI:self];
    
    configuration = [[CLConfiguration alloc] initWithServerAddress:[self serversHTTPAddress] andServerAPICallsDictionary:[self serversAPICalls]];
}

- (void)cacheData:(id)data forKeyString:(NSString *)keyString
{
    NSData *dataJSON = [[self JSONController] getDataFromJSONModelObject:data];
    if(!dataJSON)
        return;
    
    [[self cacheController] storeData:dataJSON forKey:keyString];
}

#pragma Mark - Private methods helpers

@end
