//
//  IBESMenuViewController.m
//  CatalogueLite
//
//  Created by Pavel on 02.11.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESMenuViewController.h"
// LibraryAPI class
#import "CLLibraryAPI.h"
// Image Pager View
#import "KASlideShow.h"

@interface IBESMenuViewController () <KASlideShowDataSource, KASlideShowDelegate>

@property (nonatomic) UIButton *catalogueButton;
@property (nonatomic) UIButton *companyInfoButton;
@property (nonatomic) KASlideShow *bannersPager;

@property (nonatomic) NSArray *dataSource;

@end

@implementation IBESMenuViewController

#pragma Mark - View controller`s lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self shouldHideNavigationBar:animated];
    
    [[CLLibraryAPI sharedInstance] bannersArrayWithSuccessBlock:^(NSArray *banners)
     {
         if (banners)
         {
             NSMutableArray *dataSource_ = [NSMutableArray arrayWithCapacity:[banners count]];
             
             for (NSDictionary *banner in banners)
             {
                 [dataSource_ addObject:banner[@"url"]];
             }
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self setDataSource:[dataSource_ copy]];
                 [self.bannersPager start];
             });
         }
     }
                                                   failureBlock:nil];

}

#pragma Mark - Setup views

- (void)setupSubviews
{
    // CatalogueButton
    [self.catalogueButton setBackgroundColor:[UIColor blueColor]];
    [self.catalogueButton setTitle:@"Каталог" forState:UIControlStateNormal];
    [self.catalogueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // CompanyInfoButton
    [self.companyInfoButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.companyInfoButton setTitle:@"Информация" forState:UIControlStateNormal];
    [self.companyInfoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // BannersPager
    //[self.view addSubview:self.bannersPager];
    [self.bannersPager setDatasource:self];
    [self.bannersPager setDelegate:self];
    // Delay between transitions
    [self.bannersPager setDelay:1];
    // Transition duration
    [self.bannersPager setTransitionDuration:.5];
    // Choose a transition type (fade or slide)
    [self.bannersPager setTransitionType:KASlideShowTransitionFade];
    // Choose a content mode for images to display
    [self.bannersPager setImagesContentMode:UIViewContentModeScaleAspectFill];
    // Gesture to go previous/next directly on the image
    [self.bannersPager addGesture:KASlideShowGestureTap];
    
    [self setSubviews:@[self.catalogueButton, self.companyInfoButton, self.bannersPager]];
}

#pragma Mark - Setup constraints

- (void)setupConstraints
{
    //[self.catalogueButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    //[self.companyInfoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    //[self.bannersPager setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // CatalogueButton
    NSLayoutConstraint *catalogueButtonCenterY = [self.catalogueButton.centerYAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.centerYAnchor];
    NSLayoutConstraint *catalogueButtonTop = [self.catalogueButton.topAnchor constraintEqualToAnchor:self.bannersPager.bottomAnchor constant:10.0f];
    
    NSLayoutConstraint *catalogueButtonLeading = [self.catalogueButton.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor];
    NSLayoutConstraint *catalogueButtonTrailing = [self.catalogueButton.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor];
    
    // CompanyInfoButton
    NSLayoutConstraint *companyInfoButtonTop = [self.companyInfoButton.topAnchor constraintEqualToAnchor:self.catalogueButton.layoutMarginsGuide.bottomAnchor constant:20.0f];
    
    NSLayoutConstraint *companyInfoButtonLeading = [self.companyInfoButton.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor];
    NSLayoutConstraint *companyInfoButtonTrailing = [self.companyInfoButton.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor];
    
    // BannersPages
    NSLayoutConstraint *bannersPageTop = [self.bannersPager.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:10.0f];
    
    NSLayoutConstraint *bannersPageLeading = [self.bannersPager.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor];
    NSLayoutConstraint *bannersPageTrailing = [self.bannersPager.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor];
    
    [self.bannersPager setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    [self.bannersPager setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    
    [self setConstraints:@[catalogueButtonCenterY, catalogueButtonTop, catalogueButtonLeading, catalogueButtonTrailing, companyInfoButtonTop, companyInfoButtonLeading, companyInfoButtonTrailing, bannersPageTop, bannersPageLeading, bannersPageTrailing]];
}

#pragma Mark - KASlideShow datasource

- (NSObject *)slideShow:(KASlideShow *)slideShow objectAtIndex:(NSUInteger)index
{
    return self.dataSource[index];
}

- (NSUInteger)slideShowImagesNumber:(KASlideShow *)slideShow
{
    return [self.dataSource count];
}

#pragma Mark - Lazy initialisation of instance variables

- (UIButton *)catalogueButton
{
    if (!_catalogueButton)
    {
        _catalogueButton = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    
    return _catalogueButton;
}

- (UIButton *)companyInfoButton
{
    if (!_companyInfoButton)
    {
        _companyInfoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    }
    
    return _companyInfoButton;
}

- (KASlideShow *)bannersPager
{
    if (!_bannersPager)
    {
        _bannersPager = [[KASlideShow alloc] initWithFrame:CGRectZero];
    }
    
    return _bannersPager;
}

#pragma Mark - Navigation

@end
