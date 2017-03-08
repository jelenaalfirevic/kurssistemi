//
//  Constance.h
//  ToDo
//
//  Created by Kurs on 2/24/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#ifndef Constance_h
#define Constance_h

// Enums
typedef NS_ENUM(NSInteger, TaskGroup) {
    TaskGroupCompleted = 1,
    TaskGroupNotCompleted,
    TaskGroupInProgress
};

// Constants
#define  kAnimationDuration 0.3f
static NSString *const DATE_FORMAT = @"yyyy-MM-dd";

// Colors
#define kColorCompleted [UIColor colorWithRed:73.0/255.0 green:211.0/255.0 blue:194.0/255.0 alpha:1.0]
#define kColorNotCompleted [UIColor colorWithRed:254.0/255.0 green:172.0/255.0 blue:73.0/255.0 alpha:1.0]
#define kColorInProgress [UIColor colorWithRed:187.0/255.0 green:114.0/255.0 blue:255.0/255.0 alpha:1.0]

// Notifications
static NSString *const LOCALITY_UPDATED_NOTIFICATION = @"LOCALITY_UPDATED_NOTIFICATION";

// User Defaults
static NSString *const USER_IMAGE = @"USER_IMAGE";
static NSString *const USER_UD = @"USER_UD";


#endif /* Constance_h */
