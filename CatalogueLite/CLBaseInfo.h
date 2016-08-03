//
//  CLBaseInfo.h
//  CatalogueLite
//
//  Created by Pavel on 28.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CLBaseInfo : JSONModel

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *default_image;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *f_address;
@property (strong, nonatomic) NSString *i_address;
@property (strong, nonatomic) NSString *logo;
@property (strong, nonatomic) NSString *o_address;
@property (strong, nonatomic) NSString *phone;
@property BOOL short_footer;
@property (strong, nonatomic) NSString *show_logo;
@property (strong, nonatomic) NSString *speech;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *t_address;
@property (strong, nonatomic) NSDate *updated_at;
@property (strong, nonatomic) NSString *vk_address;

@end
