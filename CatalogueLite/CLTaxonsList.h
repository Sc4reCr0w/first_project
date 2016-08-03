//
//  CLTaxonsList.h
//  CatalogueLite
//
//  Created by Pavel on 28.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol CLTaxon;

@interface CLTaxonsList : JSONModel

@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSInteger current_page;
@property (assign, nonatomic) NSInteger pages;
@property (assign, nonatomic) NSInteger per_page;
@property (assign, nonatomic) NSArray<CLTaxon> *taxons;
@property (assign, nonatomic) NSInteger total_count;

@end

