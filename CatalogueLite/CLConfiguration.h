//
//  CLConfiguration.h
//  CatalogueLite
//
//  Created by Pavel on 02.08.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLConfiguration : NSObject

@property (strong, readonly, nonatomic) NSURL *serverAddress;
@property (strong, readonly, nonatomic) NSDictionary *serverAPI;

- (instancetype)initWithServerAddress:(NSString *)address andServerAPICallsDictionary:(NSDictionary *)calls;

@end
