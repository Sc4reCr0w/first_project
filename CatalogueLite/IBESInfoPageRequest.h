//
//  IBESInfoPageRequest.h
//  CatalogueLite
//
//  Created by Pavel on 12.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESRequest.h"

@interface IBESInfoPageRequest : IBESRequest

- (NSURLSessionDataTask *)requestInfoPages:(IBESRequestSuccess)success failure:(IBESRequestFailure)failure;

@end
