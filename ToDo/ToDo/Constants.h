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

// Notifications
static NSString *const LOCALITY_UPDATED_NOTIFICATION = @"LOCALITY_UPDATED_NOTIFICATION";

// User Defaults
static NSString *const USER_IMAGE = @"USER_IMAGE";
static NSString *const USER_UD = @"USER_UD";


#endif /* Constance_h */
