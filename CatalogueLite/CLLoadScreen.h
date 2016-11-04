//
//  CLLoadScreen.h
//  CatalogueLite
//
//  Created by Pavel on 11.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CLLoadScreen : UIView

@property (nonatomic, readonly) UIImageView *logoImage;
@property (nonatomic, readonly) UIActivityIndicatorView *downloadIndicator;

@end
