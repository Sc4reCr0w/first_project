//
//  CLLibraryAPIConfiguration.h
//  CatalogueLite
//
//  Created by Pavel on 03.08.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLibraryAPI;

@protocol CLLibraryAPIConfiguration <NSObject>

@required
- (void)serverAddressForCLLibraryAPI:(CLLibraryAPI *)librariAPI;
- (void)serverAPICallsForCLLibraryAPI:(CLLibraryAPI *)librariAPI;

@end
