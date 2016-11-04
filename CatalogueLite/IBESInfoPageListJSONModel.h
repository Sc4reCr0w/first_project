//
//  IBESInfoPageListJSONModel.h
//  CatalogueLite
//
//  Created by Pavel on 12.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol IBESInfoPageJSONModel;

@interface IBESInfoPageListJSONModel : JSONModel

@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSInteger currentPage;
@property (nonatomic) NSArray<IBESInfoPageJSONModel> *infoPages;
@property (assign, nonatomic) NSInteger pages;
@property (assign, nonatomic) NSInteger perPage;
@property (assign, nonatomic) NSInteger totalCount;

- (instancetype)initWithJSON:(id)json error:(NSError **)error NS_DESIGNATED_INITIALIZER;

- (NSArray *)infoPagesAsDictionaries;

@end
