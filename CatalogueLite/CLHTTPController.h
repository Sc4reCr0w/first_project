//
//  CLHTTPController.h
//  CatalogueLite
//
//  Created by Pavel on 25.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLHTTPController : NSObject

@property (strong, nonatomic) NSURLSessionConfiguration *sessionConfig;

- (void)downloadDataForURL:(NSURL *)addressURL withCallback:(void(^)(NSData *data, NSURLResponse *response, NSError *error))callback;

@end




