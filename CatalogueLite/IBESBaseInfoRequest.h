//
//  IBESBaseInfoRequest.h
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESRequest.h"

@interface IBESBaseInfoRequest : IBESRequest

- (NSURLSessionDataTask *)requestBaseInfo:(IBESRequestSuccess)success failure:(IBESRequestFailure)failure;

@end
