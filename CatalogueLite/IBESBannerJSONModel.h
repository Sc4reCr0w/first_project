//
//  IBESBannerJSONModel.h
//  CatalogueLite
//
//  Created by Pavel on 08.10.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol IBESBannerJSONModel <NSObject>
@end

@interface IBESBannerJSONModel : JSONModel

@property (nonatomic) NSString<Optional> *active;
@property (nonatomic) NSDate *dateUpdate;
@property (nonatomic) NSString<Optional> *Description;
@property (assign, nonatomic) NSInteger ID;
@property (nonatomic) NSString<Optional> *link;
@property (assign, nonatomic) NSString<Optional> *linkID;
@property (assign, nonatomic) NSString<Optional> *linkType;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *url;

@end
