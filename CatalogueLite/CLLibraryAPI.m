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
// BannersList JSON Model
#import "CLBannersListModel.h"

NSString * const kServerAddress = @"server_address";

@interface CLLibraryAPI ()

@property (strong, nonatomic) CLCacheController *cacheController;
@property (strong, nonatomic) CLURLController *URLController;

@property (copy) BannersListCallback callback;

@end

@implementation CLLibraryAPI

+ (instancetype)sharedInstance
{
    static CLLibraryAPI *sharedInstance_ = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance_ = [[CLLibraryAPI alloc] init];
    });
    
    return sharedInstance_;
}

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


- (NSURL *)serverAddress
{
    if (!_serverAddress)
    {
        _serverAddress = [NSURL URLWithString:kServerAddress];
    }
    
    return _serverAddress;
}

- (CLBannersListModel *)getBannersList
{
    __block NSMutableData *bannersListDataJSON = [NSMutableData data];
    
    NSURL *URLToBannersList = [[self URLController] makeURLForKey:@"LOAD_BANNERS" relativeToBaseURL:[self serverAddress]];
    
    NSData *dataFromCache = [[self cacheController] getDataForKey:URLToBannersList];
    if (dataFromCache){
        bannersListDataJSON = [NSMutableData dataWithData:dataFromCache];
    } else {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:URLToBannersList completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
        {
            
            bannersListDataJSON = [NSMutableData dataWithData:data];
        }];
        [dataTask resume];
    }
    
    NSError *JSONModelError = nil;
    return [[CLBannersListModel alloc] initWithData:bannersListDataJSON error:&JSONModelError];
}

- (void)getBannersListWithBlock:(BannersListCallback)callback
{
    self.callback = callback;
    
    NSURL *URLToBannersList = [[self URLController] makeURLForKey:@"LOAD_BANNERS" relativeToBaseURL:[self serverAddress]];

    NSData *dataFromCache = [[self cacheController] getDataForKey:URLToBannersList];
    if (dataFromCache){
        self.callback(dataFromCache);
    } else {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:URLToBannersList completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
        {
            self.callback(data);
        }];
        [dataTask resume];
    }

}

@end
