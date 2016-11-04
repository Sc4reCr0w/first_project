//
//  IBESService.h
//  CatalogueLite
//
//  Created by Pavel on 15.09.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IBESServiceSuccess)(void);
typedef void (^IBESServiceFailure)(NSError *);

@interface IBESService : NSObject

@property (nonatomic) NSURLSessionDataTask *currentTask;

- (void (^)(NSURLSessionDataTask *, NSError *))failureWithBlock:(IBESServiceFailure)failureBlock;

@end
