//
//  CLTaxon.h
//  CatalogueLite
//
//  Created by Pavel on 28.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol CLTaxon <NSObject>
@end

@class CLTaxonIcon;

@interface CLTaxon : JSONModel

@property (strong, nonatomic) NSDate *date_update;
@property (strong, nonatomic) CLTaxonIcon *icon;
@property (assign, nonatomic) NSInteger id;
@property (assign, nonatomic) NSInteger lft;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger parent_id;
@property (assign, nonatomic) NSInteger rgt;
@property (assign, nonatomic) NSInteger taxonomi_id;

@end
