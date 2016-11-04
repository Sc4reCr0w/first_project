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

- (id)getDataForKey:(NSString *)keyString;
- (void)storeObject:(id)object forKey:(NSString *)keyString;

@end
