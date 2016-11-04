//
//  IBESTaxonsRequest.h
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESRequest.h"

@interface IBESTaxonsRequest : IBESRequest

- (NSURLSessionDataTask *)requestTaxons:(NSDictionary *)parameters successBlock:(IBESRequestSuccess)success failureBlock:(IBESRequestFailure)failure;

@end
