//
//  CLConfiguration.m
//  CatalogueLite
//
//  Created by Pavel on 02.08.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "CLConfiguration.h"

@interface CLConfiguration ()
{
    NSURL *serverAddress_;
    NSDictionary *serverAPI_;
}
@end

@implementation CLConfiguration

@synthesize serverAddress = serverAddress_;
@synthesize serverAPI = serverAPI_;

- (instancetype)initWithServerAddress:(NSString *)address andServerAPICallsDictionary:(NSDictionary *)calls
{
    if(self = [super init])
    {
        serverAddress_ = [NSURL URLWithString:address];
        serverAPI_ = calls;
        
    }
    
    return self;
}

@end
