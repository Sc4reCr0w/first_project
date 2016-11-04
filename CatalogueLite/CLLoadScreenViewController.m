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
// LibraryAPI class
#import "CLLibraryAPI.h"
// Menu View Controller
#import "IBESMenuViewController.h"

@interface CLLoadScreenViewController ()

@property (nonatomic) UIImageView *logoImageView;
@property (nonatomic) UIActivityIndicatorView *downloadIndicatorView;

@property (nonatomic) IBESMenuViewController *testController;

@end

@implementation CLLoadScreenViewController

#pragma mark - View controller lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
    [self addViews];
    [self setupConstraints];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self downloadMenuContent];
}

#pragma Mark - Setup view

- (void)setupView
{
    // sets background of controllers view
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // hides navigation bar of navigation controller
    if ( ![self.navigationController isNavigationBarHidden] )
    {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}

#pragma mark - Add subviews

- (void)addViews
{
    // logoImageView
    UIImage *image = [UIImage imageNamed:@"Logo"/*@"Image"*/];
    [self.logoImageView setImage:image];
    [self.logoImageView setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:self.logoImageView];
    
    // downloadIndicatorView
    [self.downloadIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.downloadIndicatorView setColor:[UIColor redColor]];
        // Set colour for test perpose
    [self.downloadIndicatorView setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:self.downloadIndicatorView];
}

#pragma mark - Setup constraints

- (void)setupConstraints
{
    [self.downloadIndicatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.logoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // CONSTRAINTS FOR BOTH OREINTATIONS
    // ActivityIndicatorView constraints
    NSLayoutConstraint *downloadIndicatorCenterX = [self.downloadIndicatorView.centerXAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.centerXAnchor];
    
    NSLayoutConstraint *downloadIndicatorTop = [self.downloadIndicatorView.topAnchor constraintEqualToAnchor:self.logoImageView.bottomAnchor constant:10];
    
    // ImageView constraints
    NSLayoutConstraint *logoImageCenterY = [self.logoImageView.centerYAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.centerYAnchor];
    
    NSLayoutConstraint *logoImageLeading = [self.logoImageView.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor];
    NSLayoutConstraint *logoImageTrailing = [self.logoImageView.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor];
    
    // Activates constraints
    [NSLayoutConstraint activateConstraints:@[downloadIndicatorCenterX, downloadIndicatorTop,logoImageCenterY, logoImageLeading, logoImageTrailing]];
    
    [self.logoImageView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    [self.logoImageView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    
    // CONSTRAINTS FOR PORTRAIT OREINTATION

    [[self.logoImageView.heightAnchor constraintEqualToAnchor:self.logoImageView.widthAnchor multiplier:self.logoImageView.image.size.height / self.logoImageView.image.size.width] setActive:YES];

    // CONSTRAINTS FOR LANDSCAPE OREINTATION
    /*
    // ActivityIndicatorView
    [[self.downloadIndicatorView.bottomAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.bottomAnchor] setActive:YES];
    
    // ImageView
    [[self.logoImageView.centerXAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.centerXAnchor] setActive:YES];
    */
}

#pragma mark - Download content for next view controller

- (void)downloadMenuContent
{
    [[CLLibraryAPI sharedInstance] getMenuContent:[self successForAPICall] failureBlock:[self failureForAPICall]];
    
    [[self downloadIndicatorView] startAnimating];
}

#pragma mark - Success block for menu content download

- (void (^)(void))successForAPICall
{
    return ^{
        [self performSegueProgrammatycally];
    };
}

#pragma mark - Failure block for menu content download

- (void (^)(void))failureForAPICall
{
    return ^
    {
        NSLog(@"Download have been stoped due to error.");

        UIAlertController *alert = [self alertControllerWithHandler:[self alertControllerActionHandler]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:alert animated:YES completion:^{
                [[self downloadIndicatorView] setHidesWhenStopped:NO];
                [[self downloadIndicatorView] stopAnimating];
            }];
        });
    };
}

#pragma mark - Alert controller for content download

- (UIAlertController *)alertControllerWithHandler:(void(^)(UIAlertAction *))handler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error!" message:@"Content download for menu have failed.\nCheck your connection to Internet and restart the application." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:handler];
    
    [alert addAction:action];
    [alert setPreferredAction:action];
    
    return alert;
}

#pragma mark - Action for alert controller

- (void (^)(UIAlertAction *))alertControllerActionHandler
{
    return ^(UIAlertAction *action)
    {
        if( [action isEnabled] )
        {
            [[self downloadIndicatorView] setHidesWhenStopped:NO];
            [[self downloadIndicatorView] stopAnimating];
        }
    };
}

#pragma Mark - Lazy initialisation of instance variables

/*- (CLLoadScreen *)loadScreen
{
    if (!_loadScreen) {
        _loadScreen = [[CLLoadScreen alloc] init];
    }
    
    return _loadScreen;
}*/

- (IBESMenuViewController *)testController
{
    if (!_testController)
    {
        _testController = [[IBESMenuViewController alloc] init];
    }
    
    return _testController;
}

- (UIImageView *)logoImageView
{
    if (!_logoImageView)
    {
        _logoImageView = [UIImageView new];
    }
    
    return _logoImageView;
}

- (UIActivityIndicatorView *)downloadIndicatorView
{
    if (!_downloadIndicatorView)
    {
        _downloadIndicatorView = [UIActivityIndicatorView new];
    }
    
    return _downloadIndicatorView;
}

#pragma mark - Navigation

- (void)performSegueProgrammatycally
{
    [self.navigationController setViewControllers:@[self.testController] animated:YES];
}

/*
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
*/

@end
