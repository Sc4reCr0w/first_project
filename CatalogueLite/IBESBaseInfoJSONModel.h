//
//  IBESBaseInfoJSONModel.h
//  CatalogueLite
//
//  Created by Pavel on 13.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface IBESBaseInfoJSONModel : JSONModel

@property (nonatomic) NSString *address;
@property (nonatomic) NSString *defaultImage;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *fAddress;
@property (nonatomic) NSString *iAddress;
@property (nonatomic) NSString *logo;
@property (nonatomic) NSString *oAddress;
@property (nonatomic) NSString *phone;
@property BOOL shortFooter;
@property (nonatomic) NSString<Optional> *showLogo;
@property (nonatomic) NSString *speech;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *tAddress;
@property (nonatomic) NSDate *updated_at;
@property (nonatomic) NSString *vkAddress;

- (instancetype)initWithJSON:(id)json error:(NSError **)error NS_DESIGNATED_INITIALIZER;

- (NSArray *)baseInfoAsDictionary;

@end
