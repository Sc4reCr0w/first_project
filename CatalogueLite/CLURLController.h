//
//  CLURLController.h
//  CatalogueLite
//
//  Created by Pavel on 15.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLURLController : NSObject

- (NSURL *)makeURLForKey:(NSString *)key relativeToBaseURL:(NSURL *)baseURL;

- (NSURL *)addQueryParametersToURL:(NSURL *)URL fromDictionary:(NSDictionary *)dictionary;

@end
