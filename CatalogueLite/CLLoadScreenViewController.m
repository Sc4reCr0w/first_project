//
//  CLLoadScreenViewController.m
//  CatalogueLite
//
//  Created by Pavel on 11.07.16.
//  Copyright © 2016 IBES. All rights reserved.
//

// This
#import "CLLoadScreenViewController.h"
// View
#import "CLLoadScreen.h"
// BannersList JSON Model
#import "CLBannersListModel.h"
#import "CLBannerModel.h"

// LibraryAPI class
#import "CLLibraryAPI.h"

@interface CLLoadScreenViewController ()

@property (strong, nonatomic) CLLoadScreen *loadScreenView;
@property (strong, nonatomic) CLBannersListModel *bannersList;

@end

@implementation CLLoadScreenViewController

- (CLLoadScreen *)loadScreenView
{
    if (!_loadScreenView) {
        _loadScreenView = [[CLLoadScreen alloc] init];
    }
    
    return _loadScreenView;
}

#pragma mark - View Controller lifecycle

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)loadView
{
    [super loadView];
    self.view = [self loadScreenView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    
    [[CLLibraryAPI sharedInstance] getBannersListWithBlock:^(NSData *data){
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding];
        JSONModelError *error = nil;
        self.bannersList = [[CLBannersListModel alloc]initWithString:string error:&error];
        
    }];
    
    self.bannersList.banners;
    
}

- (void)setupUI
{
    [self setupView];
    [self setupActivityIndicatorView];
}

- (void)setupView
{
    if (![[self navigationController] isNavigationBarHidden])
    {
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
    }
    
    [self view].backgroundColor = [UIColor whiteColor];
}

- (void)setupActivityIndicatorView
{
    [[self loadScreenView] downloadActivityIndicatorView].hidesWhenStopped = NO;
    [[self loadScreenView] downloadActivityIndicatorView].color = [UIColor redColor];
    [[[self loadScreenView] downloadActivityIndicatorView] startAnimating];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
