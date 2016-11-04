//
//  CLLibraryAPI.h
//  CatalogueLite
//
//  Created by Pavel on 15.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IBESAPISuccess)(NSArray *array);
typedef void (^IBESAPIFailure)(NSError *error);

@interface CLLibraryAPI : NSObject

+ (instancetype)sharedInstance;

- (void)getMenuContent:(void (^)(void))success failureBlock:(void (^)(void))failure;

- (void)bannersArrayWithSuccessBlock:(IBESAPISuccess)success failureBlock:(IBESAPIFailure)failure;

- (void)infoPagesArrayWithSuccessBlock:(IBESAPISuccess)success failureBlock:(IBESAPIFailure)failure;

- (void)taxonsArrayWithSuccessBlock:(IBESAPISuccess)success failureBlock:(IBESAPIFailure)failure;

- (void)baseInfoArrayWithSuccessBlock:(IBESAPISuccess)success failureBlock:(IBESAPIFailure)failure;

@end
