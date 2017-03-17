//
//  ContainerViewController.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/17/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "ContainerViewController.h"
#import "SideMenuViewController.h"

@interface ContainerViewController ()
@property (strong, nonatomic) UIButton *overlayButton;
@property (strong, nonatomic) SideMenuViewController *sideMenuViewController;
@end

@implementation ContainerViewController

#pragma mark - Actions

- (void)overlayButtonTapped {
    [[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_SIDE_MENU_NOTIFICATION object:nil];
    
}

#pragma mark - Private API

- (void)configureSideMenuViewController {
    UIViewController *viewController = [Helpers initViewControllerFrom:@"SideMenuViewController"];
    
    // View controller containment.
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    
    // Hide menu.
    CGRect frame = viewController.view.frame;
    frame.origin.x = -self.view.frame.size.width;
    viewController.view.frame = frame;
    
    self.sideMenuViewController = (SideMenuViewController *)viewController;
}

- (void)configureHomeViewController {
    UIViewController *viewController = [Helpers initViewControllerFrom:@"HomeViewController"];
    
    // View controller containment.
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

- (void)configureOverlayButton {
    UIButton *overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    overlayButton.frame = self.view.frame;
    overlayButton.alpha = 0.0f;
    [overlayButton addTarget:self action:@selector(overlayButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:overlayButton];
    
    self.overlayButton = overlayButton;
}

- (void)registerForNotification {
    [[NSNotificationCenter defaultCenter] addObserverForName:OPEN_SIDE_MENU_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.overlayButton.alpha = 0.3f;
        } completion:^(BOOL finished) {
           [UIView animateWithDuration:kAnimationDuration animations:^{
               CGRect frame = self.sideMenuViewController.view.frame;
               frame.origin.x = 50.0f;
               self.sideMenuViewController.view.frame = frame;
           }];
        }];
        
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:CLOSE_SIDE_MENU_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        [UIView animateWithDuration:kAnimationDuration animations:^{
            CGRect frame = self.sideMenuViewController.view.frame;
            frame.origin.x = -self.view.frame.size.width;
            self.sideMenuViewController.view.frame = frame;
            } completion:^(BOOL finished) {
            [UIView animateWithDuration:kAnimationDuration animations:^{
                self.overlayButton.alpha = 0.0f;

            }];
        }];
    }];
}


#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureHomeViewController];
    [self configureSideMenuViewController];
    [self configureOverlayButton];
}

@end
