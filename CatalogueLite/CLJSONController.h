//
//  CLJSONController.h
//  CatalogueLite
//
//  Created by Pavel on 25.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLBannersListModel;

@interface CLJSONController : NSObject

- (instancetype)JSONModelForObjectClass:(Class)classType withData:(NSData *)data;
- (NSData *)getDataFromJSONModelObject:(id)modelObject;

@end
