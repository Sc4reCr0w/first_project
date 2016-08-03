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

// LibraryAPI class
#import "CLLibraryAPI.h"
#import "CLLibraryAPIConfiguration.h"

NSString * const kServerAddress = @"http://136.243.226.243:8081/";

@interface CLLoadScreenViewController () <CLLibraryAPIConfiguration>

@property (strong, nonatomic) CLLoadScreen *loadScreenView;
///////
@property (strong, nonatomic) CLBannersListModel *bannersList;

@end

@implementation CLLoadScreenViewController

#pragma Mark - Lazy initialization of instance variables

- (CLLoadScreen *)loadScreenView
{
    if (!_loadScreenView) {
        _loadScreenView = [[CLLoadScreen alloc] init];
    }
    
    return _loadScreenView;
}

#pragma mark - View Controller lifecycle

- (void)loadView
{
    [super loadView];
    
    self.view = [self loadScreenView];
    [CLLibraryAPI sharedInstance].delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self downloadInitialContent];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma Mark - Private methods

- (void)setupUI
{
    [self view].backgroundColor = [UIColor whiteColor];
    [self setupNavigationControllerView];
    [self setupActivityIndicatorView];
}

- (void)setupNavigationControllerView
{
    if (![[self navigationController] isNavigationBarHidden])
    {
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
    }
}

- (void)setupActivityIndicatorView
{
    [[self loadScreenView] downloadActivityIndicatorView].hidesWhenStopped = YES;
    [[self loadScreenView] downloadActivityIndicatorView].color = [UIColor redColor];
}

- (void)downloadInitialContent
{
    [[[self loadScreenView] downloadActivityIndicatorView] startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[CLLibraryAPI sharedInstance] downloadToCacheJSONObjectForAPICallKey:@"LOAD_BANNERS"];
    });
}

- (NSDictionary *)createServerAPICallsDictionary
{
    return @{@"LOAD_BANNERS":@"api/banners",
             @"LOAD_INFO_PAGE":@"/api/infopage",
             @"LOAD_TAXON":@"/api/taxonss",
             @"LOAD_BASE_INFO":@"/api/base-info",
             @"LOAD_OPTION":@"/api/m_option_values"};
}

#pragma mark - Protocol

- (void)serverAddressForCLLibraryAPI:(CLLibraryAPI *)librariAPI
{
    [librariAPI setServersHTTPAddress:kServerAddress];
}

- (void)serverAPICallsForCLLibraryAPI:(CLLibraryAPI *)librariAPI
{
    [librariAPI setServersAPICalls:[self createServerAPICallsDictionary]];
}

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
