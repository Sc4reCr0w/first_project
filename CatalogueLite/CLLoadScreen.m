//
//  CLLoadScreen.m
//  CatalogueLite
//
//  Created by Pavel on 11.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "CLLoadScreen.h"

// Subviews helper
#import "CLLoadScreen+Subviews.h"

@implementation CLLoadScreen
/*{
    UIImageView *_logoImageView;
    UIActivityIndicatorView *_downloadActivityIndicatorView;
}

@synthesize logoImageView = _logoImageView;
@synthesize downloadActivityIndicatorView = _downloadActivityIndicatorView;*/

- (UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [self addImageViewWithImageNamed:@"Logo"];
        [_logoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    return _logoImageView;
}

- (UIActivityIndicatorView *)downloadActivityIndicatorView
{
    if (!_downloadActivityIndicatorView) {
        _downloadActivityIndicatorView = [self addDownloadActivityIndicator];
        [_downloadActivityIndicatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    return _downloadActivityIndicatorView;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:[self logoImageView]];
        [self addSubview:[self downloadActivityIndicatorView]];
        
        [self setupCenterPointYConstraintWithItem:self toItem:[self logoImageView] withConstant:0.0f];
        
        const float downlaodActivityIndicatorViewCenterYShift = -([[self logoImageView] frame].size.height / 2 + [[self downloadActivityIndicatorView] frame].size.height);
        
        [self setupCenterPointYConstraintWithItem:self toItem:[self downloadActivityIndicatorView] withConstant:downlaodActivityIndicatorViewCenterYShift];
    }
    
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
}

- (void)setupCenterPointYConstraintWithItem:(UIView *)view1 toItem:(UIView *)view2 withConstant:(float)constant
{
    // Center X
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:view1
                                                      attribute:NSLayoutAttributeCenterX
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view2
                                                      attribute:NSLayoutAttributeCenterX
                                                     multiplier:1.0f
                                                       constant:0.0f
                          ]
     ];
    
    // Center Y
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:view1
                                                      attribute:NSLayoutAttributeCenterY
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view2
                                                      attribute:NSLayoutAttributeCenterY
                                                     multiplier:1.0f
                                                       constant:constant
                          ]
     ];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
