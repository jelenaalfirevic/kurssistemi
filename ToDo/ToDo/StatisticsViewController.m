//
//  StatisticsViewController.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/18/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "StatisticsViewController.h"

#define kBorderWidth 2.0f

@interface StatisticsViewController ()
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *leftPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *completedCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *notCompletedCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *inProgressCountLabel;

@end

@implementation StatisticsViewController

#pragma mark - Actions

- (IBAction)backButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private API

- (void)configureUI {
    self.leftView.layer.borderWidth = kBorderWidth;
    self.leftView.layer.borderColor = kColorNotCompleted.CGColor;
    
    self.centerView.layer.borderWidth = kBorderWidth;
    self.centerView.layer.borderColor = kColorCompleted.CGColor;
    
    self.rightView.layer.borderWidth = kBorderWidth;
    self.rightView.layer.borderColor = kColorInProgress.CGColor;

}

- (void)fillPercentages {
    CGFloat completedCount = [DATA_MANAGER numberOfTasksPerTaskGroup:TaskGroupCompleted];
    CGFloat notCompletedCount = [DATA_MANAGER numberOfTasksPerTaskGroup:TaskGroupNotCompleted];
    CGFloat inProgressCount = [DATA_MANAGER numberOfTasksPerTaskGroup:TaskGroupInProgress];
    CGFloat totalCount = completedCount + notCompletedCount + inProgressCount;
    
    if (notCompletedCount > 0) {
        self.leftPercentageLabel.text = [NSString stringWithFormat:@"%.0f" , (notCompletedCount/totalCount)*100.0];

    } else {
        self.leftPercentageLabel.text = @"0";
    }
    
    if (completedCount > 0) {
        self.centerPercentageLabel.text = [NSString stringWithFormat:@"%.0f" , (completedCount/totalCount)*100.0];
        
    } else {
        self.centerPercentageLabel.text = @"0";
    }
    
    if (inProgressCount > 0) {
        self.rightPercentageLabel.text = [NSString stringWithFormat:@"%.0f" , (inProgressCount/totalCount)*100.0];
        
    } else {
        self.rightPercentageLabel.text = @"0";
    }
}

- (void)fillCounts {
    NSInteger completedCount = [DATA_MANAGER numberOfTasksPerTaskGroup:TaskGroupCompleted];
    self.completedCountLabel.text = [NSString stringWithFormat:@"%ld", completedCount];
    
    NSInteger notCompletedCount = [DATA_MANAGER numberOfTasksPerTaskGroup:TaskGroupNotCompleted];
    self.completedCountLabel.text = [NSString stringWithFormat:@"%ld", notCompletedCount];
    
    NSInteger inProgressCount = [DATA_MANAGER numberOfTasksPerTaskGroup:TaskGroupInProgress];
    self.completedCountLabel.text = [NSString stringWithFormat:@"%ld", inProgressCount];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
    [self fillCounts];
    [self fillPercentages];
}

@end
