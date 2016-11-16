//
//  IBESViewController.h
//  CatalogueLite
//
//  Created by Pavel on 10.11.16.
//  Copyright © 2016 IBES. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBESViewController : UIViewController

@property (nonatomic) NSArray<UIView *> *subviews;
@property (nonatomic) NSArray<NSLayoutConstraint *> *constraints;

- (void)setupConstraints;
- (void)activateConstraints;

- (void)setupSubviews;
- (void)addSubviews;

- (void)shouldHideNavigationBar:(BOOL)choice;

@end
