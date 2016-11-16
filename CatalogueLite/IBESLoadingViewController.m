//
//  IBESLoadingViewController.m
//  
//
//  Created by Pavel on 02.11.16.
//
//

// This
#import "IBESLoadingViewController.h"
// LibraryAPI class
#import "CLLibraryAPI.h"
// Menu View Controller
#import "IBESMenuViewController.h"

@interface IBESLoadingViewController ()

@property (nonatomic) UIImageView *logoImageView;
@property (nonatomic) UIActivityIndicatorView *downloadIndicatorView;

@property (nonatomic) IBESMenuViewController *menuController;

@end

@implementation IBESLoadingViewController

#pragma Mark - View controller`s lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // hides navigation bar of navigation controller
    [self shouldHideNavigationBar:!animated];
    
    [self downloadMenuContent];

}

#pragma Mark - Setup views

- (void)setupSubviews
{
    // logoImageView
    UIImage *image = [UIImage imageNamed:@"Logo"];
    [self.logoImageView setImage:image];
    [self.logoImageView setContentMode:UIViewContentModeScaleToFill];
    //[self.view addSubview:self.logoImageView];
    
    // downloadIndicatorView
    [self.downloadIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.downloadIndicatorView setColor:[UIColor redColor]];
    [self.downloadIndicatorView setContentMode:UIViewContentModeCenter];
    //[self.view addSubview:self.downloadIndicatorView];
    
    [self setSubviews:@[self.logoImageView, self.downloadIndicatorView]];

}

#pragma Mark - Setup constraints

- (void)setupConstraints
{
    //[self.downloadIndicatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
    //[self.logoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // CONSTRAINTS FOR BOTH OREINTATIONS
    // ActivityIndicatorView constraints
    NSLayoutConstraint *downloadIndicatorCenterX = [self.downloadIndicatorView.centerXAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.centerXAnchor];
    
    NSLayoutConstraint *downloadIndicatorTop = [self.downloadIndicatorView.topAnchor constraintEqualToAnchor:self.logoImageView.bottomAnchor constant:10];
    
    // ImageView constraints
    NSLayoutConstraint *logoImageCenterY = [self.logoImageView.centerYAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.centerYAnchor];
    
    NSLayoutConstraint *logoImageLeading = [self.logoImageView.leadingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.leadingAnchor];
    NSLayoutConstraint *logoImageTrailing = [self.logoImageView.trailingAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.trailingAnchor];
    
    // CONSTRAINTS FOR PORTRAIT OREINTATION
    NSLayoutConstraint *logoImageHeight = [self.logoImageView.heightAnchor constraintEqualToAnchor:self.logoImageView.widthAnchor multiplier:self.logoImageView.image.size.height / self.logoImageView.image.size.width];
    
    // Activates constraints
    [self setConstraints:@[downloadIndicatorCenterX, downloadIndicatorTop,logoImageCenterY, logoImageLeading, logoImageTrailing, logoImageHeight]];
    
    [self.logoImageView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    [self.logoImageView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    
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
    [[self downloadIndicatorView] startAnimating];

    [[CLLibraryAPI sharedInstance] getMenuContent:[self successForAPICall] failureBlock:[self failureForAPICall]];
    
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
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            
            UIAlertController *alert = [self alertControllerWithHandler:[self alertControllerActionHandler]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:YES completion:^{
                    [[self downloadIndicatorView] setHidesWhenStopped:NO];
                    [[self downloadIndicatorView] stopAnimating];
                }];
            });
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

- (IBESMenuViewController *)menuController
{
    if (!_menuController)
    {
        _menuController = [[IBESMenuViewController alloc] init];
    }
    
    return _menuController;
}

#pragma mark - Navigation

- (void)performSegueProgrammatycally
{
    [self.navigationController setViewControllers:@[self.menuController] animated:YES];
}

@end
