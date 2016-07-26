//
//  CLLibraryAPI.h
//  CatalogueLite
//
//  Created by Pavel on 15.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLibraryAPI : NSObject

@property (strong, nonatomic) NSURL *serverAddress;

+ (instancetype)sharedInstance;

- (void)downloadBannersList;

@end
