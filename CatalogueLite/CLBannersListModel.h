//
//  CLBannersListModel.h
//  CatalogueLite
//
//  Created by Pavel on 17.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol CLBannerModel;

@interface CLBannersListModel : JSONModel

@property (assign, nonatomic) intptr_t count;
@property (assign, nonatomic) intptr_t total_count;
@property (assign, nonatomic) intptr_t current_page;
@property (assign, nonatomic) intptr_t per_page;
@property (assign, nonatomic) intptr_t pages;
@property (strong, nonatomic) NSMutableArray<CLBannerModel> *banners;

- (void)removeInactiveBannersFromList;

@end
