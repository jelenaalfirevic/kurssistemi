//
//  DBTask+Utilities.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/4/17.
//  Copyright © 2017 Jelena Alfirevic. All rights reserved.
//

#import "DBTask+Utilities.h"

@implementation DBTask (Utilities)

#pragma mark - Public API

- (UIColor *)groupColor {
    if (self.group == TaskGroupCompleted) {
        return kColorCompleted;
    } else if (self.group == TaskGroupNotCompleted) {
        return kColorNotCompleted;
    } else {
        return kColorInProgress;
    }
}
@end
