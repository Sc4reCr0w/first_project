//
//  IBESTaxonsService.h
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESService.h"

typedef void (^IBESTaxonsSuccess)(NSArray *);

@interface IBESTaxonsService : IBESService

- (void)taxonsWithSuccessBlock:(IBESTaxonsSuccess)success failureBlock:(IBESServiceFailure)failure;

@end
