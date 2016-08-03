//
//  CLInfoPage.h
//  CatalogueLite
//
//  Created by Pavel on 28.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol CLInfoPage <NSObject>
@end

@interface CLInfoPage : JSONModel

@property (strong, nonatomic) NSString *banner;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSDate *date_update;
@property (assign, nonatomic) NSInteger id;
@property BOOL is_wanted;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *type;

@end
