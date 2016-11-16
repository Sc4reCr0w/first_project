//
//  IBESViewController.m
//  CatalogueLite
//
//  Created by Pavel on 10.11.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import "IBESViewController.h"

@interface IBESViewController ()

@property (nonatomic, getter=isNavigationBarHidden) BOOL navigationBarHidden;

@end

@implementation IBESViewController

@synthesize navigationBarHidden = _navigationBarHidden;

#pragma Mark - Subviews

- (void)setupSubviews
{
    ;
}

- (void)addSubviews
{
    if ( [self.subviews count] )
    {
        for (UIView *subview in self.subviews)
        {
            [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self.view addSubview:subview];
        }
    }
    
}

#pragma Mark - Constraints

- (void)setupConstraints
{
    ;
}

- (void)activateConstraints
{
    if ( [self.constraints count] )
    {
        [NSLayoutConstraint activateConstraints:[self.constraints copy]];
    }
}

#pragma Mark - Setter/getter of navigationBarHidden

- (void)setNavigationBarHidden:(BOOL)hidden
{
    [self.navigationController setNavigationBarHidden:hidden animated:YES];
}

- (BOOL)isNavigationBarHidden
{
    return [self.navigationController isNavigationBarHidden];
}

- (void)shouldHideNavigationBar:(BOOL)choice
{
    if (choice == self.isNavigationBarHidden)
    {
        return;
    }
    
    [self setNavigationBarHidden:choice];
}

#pragma Mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor darkGrayColor]];
    
    [self setupSubviews];
    [self addSubviews];
    
    [self setupConstraints];
    [self activateConstraints];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
