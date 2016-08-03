//
//  CLBannerModel.h
//  CatalogueLite
//
//  Created by Pavel on 17.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol CLBannerModel <NSObject>
@end

@interface CLBannerModel : JSONModel

@property (assign, nonatomic) intptr_t id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString<Optional> *description;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSDate *date_update;
@property (assign, nonatomic) NSString<Optional> *link_type;
@property (assign, nonatomic) NSString<Optional> *link_id;
@property (strong, nonatomic) NSString<Optional> *link;
@property (strong, nonatomic) NSString<Optional> *active;

@end
