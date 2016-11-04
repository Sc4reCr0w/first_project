//
//  IBESTaxonIconJSONModel.h
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface IBESTaxonIconJSONModel : JSONModel

@property (nonatomic) NSString *origin;
@property (nonatomic) NSString *thumbs;

@end
