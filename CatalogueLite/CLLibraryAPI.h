//
//  CLLibraryAPI.h
//  CatalogueLite
//
//  Created by Pavel on 15.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLLibraryAPIConfiguration;

@interface CLLibraryAPI : NSObject

@property (weak, nonatomic) id<CLLibraryAPIConfiguration> delegate;
@property (strong, nonatomic) NSString *serversHTTPAddress;
@property (strong, nonatomic) NSDictionary *serversAPICalls;

+ (instancetype)sharedInstance;

- (void)downloadToCacheJSONObjectForAPICallKey:(NSString *)callKey;

@end
