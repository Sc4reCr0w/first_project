//
//  CLJSONController.m
//  CatalogueLite
//
//  Created by Pavel on 25.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "CLJSONController.h"

// BannersList JSON Model
#import "CLBannersListModel.h"

@implementation CLJSONController

- (instancetype)JSONModelForObjectClass:(Class)classType withData:(NSData *)data
{
    JSONModelError *errJSON = nil;
    NSString *stringJSON = [NSString stringWithUTF8String:[data bytes]];
    
    return [[classType alloc] initWithString:stringJSON error:&errJSON];
}

- (NSData *)getDataFromJSONModelObject:(id)modelObject
{
    NSString *stringJSON = [modelObject toJSONString];
    NSData *result = [stringJSON dataUsingEncoding:NSUTF8StringEncoding];
    
    return result;
}

@end
