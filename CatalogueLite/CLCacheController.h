//
//  CLCacheController.h
//  CatalogueLite
//
//  Created by Pavel on 15.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLCacheController : NSObject

- (instancetype)init;

- (NSData *)getDataForKey:(NSURL *)keyURL;
- (void)storeData:(NSData *)data forKey:(NSURL *)keyURL;

@end
