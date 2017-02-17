//
//  DateCollectionViewCell.m
//  ToDo
//
//  Created by Djuro Alfirevic on 2/17/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "DateCollectionViewCell.h"
#import "Helpers.h"

@interface DateCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *weekDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIView *highlightView;
@property (weak, nonatomic) IBOutlet UIView *hasTasksView;
@end

@implementation DateCollectionViewCell

#pragma mark - Properties

- (void)setDate:(NSDate *)date {
    _date = date;
    
    self.dayLabel.text = [Helpers valueFrom:date withFormat:@"d"];
    self.weekDayLabel.text = [Helpers valueFrom:date withFormat:@"EEE"];
    
    NSDate *todayDate =[NSDate date];
    if ([todayDate isEqualToDate:date]) {
        self.highlightView.hidden = NO;
    } else {
        self.highlightView.hidden = YES;
    }

    //Ternary operator
    self.highlightView.hidden = ([todayDate isEqualToDate:date]) ? NO : YES;

}

@end
