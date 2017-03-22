//
//  Helpers.m
//  ToDo
//
//  Created by Djuro Alfirevic on 2/15/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "Helpers.h"

@implementation Helpers

#pragma mark - Public API

+ (BOOL)isMorning {
    NSInteger hours = [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:[NSDate date]];
    if (hours < 12) {
        return YES;
    }
    
    return NO;
}

+ (NSString *)valueFrom:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = format;
    
    return [dateFormater stringFromDate:date];
}

+ (NSInteger)numberOfDaysInMonthForDate:(NSDate *)date {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return range.length;
    
}
+ (BOOL)isDate:(NSDate *)date sameAsDate:(NSDate *)otherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date];
    NSDateComponents *otherDateComponents = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:otherDate];
    
    return (dateComponents.day == otherDateComponents.day) && (dateComponents.month == otherDateComponents.month) && (dateComponents.year == otherDateComponents.year);
}

+ (void)saveCustomObjectFromUserDefaultsForKey:(id)object forKey:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (id)loadCustomObjectFromUserDefaultsForKey:(NSString *)key {
    NSData *decodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:decodedObject];
    
    return object;
}

+ (BOOL)isLoggedIn {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_UD]) {
        return YES;
    }
    
    return NO;
}

+ (UIViewController *)initViewControllerFrom:(NSString *)storyboardID {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    return [storyboard instantiateViewControllerWithIdentifier:storyboardID];
}

    

@end
