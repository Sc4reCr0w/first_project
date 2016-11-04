//
//  IBESBaseInfoService.h
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESService.h"

typedef void (^IBESBaseInfoSuccess)(NSArray *);

@interface IBESBaseInfoService : IBESService

- (void)baseInfoWithSuccessBlock:(IBESBaseInfoSuccess)success failureBlock:(IBESServiceFailure)failure;

@end
