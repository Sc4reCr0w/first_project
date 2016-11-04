//
//  IBESInfoPageJSONModel.h
//  CatalogueLite
//
//  Created by Pavel on 12.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface IBESInfoPageJSONModel : JSONModel

@property (nonatomic) NSString *banner;
@property (nonatomic) NSString *content;
@property (nonatomic) NSDate *dateUpdate;
@property (assign, nonatomic) NSInteger ID;
@property BOOL isWanted;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *type;

@end

@protocol IBESInfoPageJSONModel;