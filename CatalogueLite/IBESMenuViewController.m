//
//  IBESMenuViewController.m
//  CatalogueLite
//
//  Created by Pavel on 02.11.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "IBESMenuViewController.h"

@interface IBESMenuViewController ()

@property (nonatomic) UIButton *catalogueButton;
@property (nonatomic) UIButton *companyInfoButton;

@end

@implementation IBESMenuViewController

#pragma mark - View Controller's life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
    [self addSubViews];
    [self setupConstraints];
}

- (void)viewWillAppear:(BOOL)animated
{
    if ( [self.navigationController isNavigationBarHidden] )
    {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View setup methods

- (void)setupView
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)addSubViews
{
    // CatalogueButton
    [self.catalogueButton setBackgroundColor:[UIColor blueColor]];
    [self.catalogueButton setTitle:@"Каталог" forState:UIControlStateNormal];
    [self.catalogueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.catalogueButton];
    
    // CompanyInfoButton
    [self.companyInfoButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.companyInfoButton setTitle:@"Информация" forState:UIControlStateNormal];
    [self.companyInfoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.companyInfoButton];
}

- (void)setupConstraints
{
    [self.catalogueButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.companyInfoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // CatalogueButton
    [[self.catalogueButton.centerYAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.centerYAnchor] setActive:YES];
    
    [[self.catalogueButton.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor] setActive:YES];
    [[self.catalogueButton.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor] setActive:YES];

    // CompanyInfoButton
    [[self.companyInfoButton.topAnchor constraintEqualToAnchor:self.catalogueButton.layoutMarginsGuide.bottomAnchor constant:10] setActive:YES];
    
    [[self.companyInfoButton.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor] setActive:YES];
    [[self.companyInfoButton.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor] setActive:YES];
}

#pragma Mark - Lazy initialisation of instance variables

/*- (CLLoadScreen *)loadScreen
 {
 if (!_loadScreen) {
 _loadScreen = [[CLLoadScreen alloc] init];
 }
 
 return _loadScreen;
 }*/

- (UIButton *)catalogueButton
{
    if (!_catalogueButton)
    {
        _catalogueButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
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

/*
- (KASlideShow *)bannersSlideView
{
    if (!_bannersSlideView)
    {
        _bannersSlideView = [[KASlideShow alloc] initWithFrame:CGRectZero];
    }
    
    return _bannersSlideView;
}
*/

#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
