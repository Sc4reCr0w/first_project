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

@interface CLLoadScreen ()

@property (nonatomic, readwrite) UIImageView *logoImage;
@property (nonatomic, readwrite) UIActivityIndicatorView *downloadIndicator;

@end

@implementation CLLoadScreen

#pragma mark - Initialisation

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if( self = [super initWithFrame:frame] )
    {
        
        [self addSubview:[self logoImage]];
        [self addSubview:[self downloadIndicator]];
        
        [self setupCenterPointYConstraintWithItem:self toItem:[self logoImage] withConstant:0.0f];
        
        const float downlaodActivityIndicatorViewCenterYShift = -([[self logoImage] frame].size.height / 2 + [[self downloadIndicator] frame].size.height);
        
        [self setupCenterPointYConstraintWithItem:self toItem:[self downloadIndicator] withConstant:downlaodActivityIndicatorViewCenterYShift];
    }
    
    return self;
}

#pragma mark - View life cycle

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self setup];
}

- (void)setup
{
    
}

#pragma Mark - Lazy initialisation of instance variables

- (UIImageView *)logoImage
{
    if(!_logoImage)
    {
        _logoImage = [self addImageViewWithImageNamed:@"Logo"];
        [_logoImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    return _logoImage;
}

- (UIActivityIndicatorView *)downloadIndicator
{
    if(!_downloadIndicator)
    {
        _downloadIndicator = [self addDownloadActivityIndicator];
        [_downloadIndicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    return _downloadIndicator;
}

#pragma mark -

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
                                                       constant:0.0f]];
    
    // Center Y
    [view1 addConstraint:[NSLayoutConstraint constraintWithItem:view1
                                                      attribute:NSLayoutAttributeCenterY
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:view2
                                                      attribute:NSLayoutAttributeCenterY
                                                     multiplier:1.0f
                                                       constant:constant]];
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
