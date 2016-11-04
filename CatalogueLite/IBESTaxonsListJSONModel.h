//
//  IBESTaxonsListJSONModel.h
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol IBESTaxonJSONModel;

@interface IBESTaxonsListJSONModel : JSONModel

@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger pages;
@property (assign, nonatomic) NSInteger perPage;
@property (nonatomic) NSArray<IBESTaxonJSONModel> *taxons;
@property (assign, nonatomic) NSInteger totalCount;

- (instancetype)initWithJSON:(id)json error:(NSError **)error NS_DESIGNATED_INITIALIZER;

- (NSArray *)taxonsAsDictionaries;

@end
