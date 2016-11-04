//
//  IBESBannersRequest.h
//  CatalogueLite
//
//  Created by Pavel on 28.09.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESRequest.h"

@interface IBESBannersRequest : IBESRequest

- (NSURLSessionDataTask *)requestBanners:(IBESRequestSuccess)success failure:(IBESRequestFailure)failure;

@end
