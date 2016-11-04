//
//  IBESTaxonJSONModel.h
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@class IBESTaxonIconJSONModel;

@interface IBESTaxonJSONModel : JSONModel

@property (nonatomic) NSDate *dateUpdate;
@property (nonatomic) IBESTaxonIconJSONModel *icon;
@property (assign, nonatomic) NSInteger ID;
@property (assign, nonatomic) NSInteger lft;
@property (nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger parentID;
@property (assign, nonatomic) NSInteger rgt;
@property (assign, nonatomic) NSInteger taxonomyID;

@end

@protocol IBESTaxonIconJSONModel;