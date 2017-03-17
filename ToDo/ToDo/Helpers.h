//
//  Helpers.h
//  ToDo
//
//  Created by Djuro Alfirevic on 2/15/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helpers : NSObject
+ (BOOL)isMorning;
+ (NSString *)valueFrom:(NSDate *)date withFormat:(NSString *)format;
+ (NSInteger)numberOfDaysInMonthForDate:(NSDate *)date;
+ (BOOL)isDate:(NSDate *)date sameAsDate:(NSDate *)otherDate;
+ (void)saveCustomObjectFromUserDefaultsForKey:(id)object forKey:(NSString *)key;
+ (id)loadCustomObjectFromUserDefaultsForKey:(NSString *)key;
+ (BOOL)isLoggedIn;
+ (UIViewController *)initViewControllerFrom:(NSString *)storyboardID;
@end
