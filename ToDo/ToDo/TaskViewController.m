//
//  TaskViewController.m
//  ToDo
//
//  Created by Djuro Alfirevic on 2/22/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "TaskViewController.h"

@interface TaskViewController ()
@end

@implementation TaskViewController

#pragma mark - Actions

- (IBAction)backButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




@end
