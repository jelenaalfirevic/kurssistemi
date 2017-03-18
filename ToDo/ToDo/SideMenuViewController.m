//
//  SideMenuViewController.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/17/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "SideMenuViewController.h"
#import "SideMenuTableViewCell.h"
#import "AppDelegate.h"

@interface SideMenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewLeadingConstraint;
@property (strong, nonatomic) NSArray *itemsArray;
@end

@implementation SideMenuViewController

#pragma mark - Actions

- (IBAction)closeButtonTapped:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_SIDE_MENU_NOTIFICATION object:nil];
}

#pragma mark - Private API

- (void)logout {
    // Remove entry from user defaults.
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_UD];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Show Login.
    UINavigationController *navigationController = (UINavigationController *)[Helpers initViewControllerFrom:@"LoginNavigationController"];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = navigationController;
    

}

#pragma mark - View lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemsArray = @[@"Home", @"Walkthrough", @"Statistics", @"Add Task", @"Log Out"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableViewLeadingConstraint.constant = kMenuOffset;
    [self.view layoutIfNeeded];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SideMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.subtitleLabel.hidden = (indexPath.row == 0) ? NO : YES;
    cell.subtitleLabel.text = [NSString stringWithFormat:@"%ld", [DATA_MANAGER numberOfTasksForToday]];
    cell.titleLabel.text = self.itemsArray[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *item = self.itemsArray[indexPath.row];
    if ([item isEqualToString:@"Walkthrough"]) {
        UIViewController *toViewController = [Helpers initViewControllerFrom:@"WalkthroughtViewController"];
        [self.containerViewController openViewController:toViewController];
    } else if ([item isEqualToString:@"Statistics"]) {
        UIViewController *toViewController = [Helpers initViewControllerFrom:@"StatisticsViewController"];
        [self.containerViewController openViewController:toViewController];
    } else if ([item isEqualToString:@"Add Task"]) {
        UIViewController *toViewController = [Helpers initViewControllerFrom:@"TaskViewController"];
        
        // Via reference.
        [self.containerViewController openViewController:toViewController];
        
        // Via notification.
        //[[NSNotificationCenter defaultCenter] postNotificationName:OPEN_VC_NOTIFICATION object:toViewController];
    } else if ([item isEqualToString:@"Log Out"]) {
        [self logout];
    }
}

@end
