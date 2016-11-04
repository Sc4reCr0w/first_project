//
//  IBESBannersService.h
//  CatalogueLite
//
//  Created by Pavel on 10.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESService.h"

typedef void (^IBESBannersSuccess)(NSArray *);

@interface IBESBannersService : IBESService

- (void)bannersWithSuccessBlock:(IBESBannersSuccess)success failureBlock:(IBESServiceFailure)failure;

@end
