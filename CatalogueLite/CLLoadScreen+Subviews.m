//
//  CLLoadScreen+Subviews.m
//  CatalogueLite
//
//  Created by Pavel on 11.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "CLLoadScreen+Subviews.h"

@implementation CLLoadScreen (Subviews)

- (UIImageView *)addImageViewWithImageNamed:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.frame = CGRectMake(0.0, 0.0, [image size].width, [image size].height);
    [imageView sizeToFit];
    
    return imageView;
}

- (UIActivityIndicatorView *)addDownloadActivityIndicator
{
    UIActivityIndicatorView *downloadActivityIndicator =
    [[UIActivityIndicatorView alloc]
     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [downloadActivityIndicator sizeToFit];
    
    return downloadActivityIndicator;
}

@end
