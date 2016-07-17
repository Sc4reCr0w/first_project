//
//  CLLoadScreen+Subviews.h
//  CatalogueLite
//
//  Created by Pavel on 11.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "CLLoadScreen.h"

@interface CLLoadScreen (Subviews)

- (UIImageView *)addImageViewWithImageNamed:(NSString *)name;
- (UIActivityIndicatorView *)addDownloadActivityIndicator;

@end
