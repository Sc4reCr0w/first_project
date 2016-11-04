//
//  IBESBlockOperationWithProgress.h
//  CatalogueLite
//
//  Created by Pavel on 20.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBESBlockOperationWithProgress : NSBlockOperation

- (void)executeOperation;

- (void)cancelOperation;

- (void)addExecutionBlocksFromArray:(NSArray <void (^)(void)> *)blocksArray;

- (void)advanceProgress;

- (BOOL)isCompleted;

@end
