//
//  CLTaxonIcon.h
//  CatalogueLite
//
//  Created by Pavel on 28.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CLTaxonIcon : JSONModel

@property (strong, nonatomic) NSString *origin;
@property (strong, nonatomic) NSString *thumbs;

@end
