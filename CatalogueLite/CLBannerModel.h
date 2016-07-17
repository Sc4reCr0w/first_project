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
@property (strong, nonatomic) NSString<Ignore> *description;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *date_update;
@property (assign, nonatomic) intptr_t link_type;
@property (assign, nonatomic) intptr_t link_id;
@property (strong, nonatomic) NSString<Optional> *link;
@property (assign, nonatomic) BOOL active;

@end
