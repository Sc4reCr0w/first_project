//
//  CLBannersListModel.m
//  CatalogueLite
//
//  Created by Pavel on 17.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "CLBannersListModel.h"

#import "CLBannerModel.h"

@implementation CLBannersListModel

- (void)removeInactiveBannersFromList
{
    for (intptr_t i = 0; i < [[self banners] count]; ++i)
    {
        BOOL active = [[[self banners][i] active]boolValue];
        if (!active)
        {
            [[self banners] removeObjectAtIndex:i];
        }
    }
}

@end
