//
//  CLLibraryAPI.h
//  CatalogueLite
//
//  Created by Pavel on 15.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLConfiguration;

@protocol CLLibraryAPIConfiguration;

@interface CLLibraryAPI : NSObject

@property (weak, nonatomic) id<CLLibraryAPIConfiguration> delegate;

+ (instancetype)sharedInstance;

- (void)downloadToCacheJSONObjectForAPICallKey:(NSString *)callKey;

@end

@protocol CLLibraryAPIConfiguration <NSObject>
@required
- (CLConfiguration *)configurationForCLLibraryAPI;

@end