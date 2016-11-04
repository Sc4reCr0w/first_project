//
//  IBESBlockOperationWithProgress.m
//  CatalogueLite
//
//  Created by Pavel on 20.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESBlockOperationWithProgress.h"

@interface IBESBlockOperationWithProgress ()

@property (nonatomic) NSProgress *operationProgress;
@property (nonatomic) NSOperationQueue *operationQueue;

@end

@implementation IBESBlockOperationWithProgress

#pragma mark - Execute self

- (void)executeOperation
{
    [self setupProgress];
    
    [[self operationQueue] addOperation:self];
}

#pragma mark - Setup progress

- (void)setupProgress
{
    [[self operationProgress] becomeCurrentWithPendingUnitCount:[[self executionBlocks] count]];
    
    [[self operationProgress] setTotalUnitCount:[[self executionBlocks] count]];
}

#pragma mark - Cancel operation

- (void)cancelOperation
{
    [[self operationQueue] cancelAllOperations];
}

#pragma mark - Add execution block to self

- (void)addExecutionBlocksFromArray:(NSArray <void (^)(void)> *)blocksArray
{
    for (id exeBlock in blocksArray)
    {
        [self addExecutionBlock:exeBlock];
    }
}

#pragma mark - Increment progress units of complete

- (void)advanceProgress
{
    [self operationProgress].completedUnitCount++;
}

#pragma mark - Check progress completed

- (BOOL)isCompleted
{
    return [[self operationProgress] totalUnitCount] == [[self operationProgress] completedUnitCount] ? YES : NO;
}

#pragma mark - Lazy initialisation

- (NSProgress *)operationProgress
{
    if (!_operationProgress)
    {
        _operationProgress = [NSProgress progressWithTotalUnitCount:-1];
    }
    
    return _operationProgress;
}

- (NSOperationQueue *)operationQueue
{
    if (!_operationQueue)
    {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    
    return _operationQueue;
}

@end
