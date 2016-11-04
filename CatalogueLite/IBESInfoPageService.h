//
//  IBESInfoPageService.h
//  CatalogueLite
//
//  Created by Pavel on 12.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESService.h"

typedef void (^IBESInfoPageSuccess)(NSArray *);

@interface IBESInfoPageService : IBESService

- (void)infoPagesWithSuccessBlock:(IBESInfoPageSuccess)success failureBlock:(IBESServiceFailure)failure;

@end
